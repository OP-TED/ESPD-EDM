#!/usr/bin/env node

/*
 *
 * NodeJS application to check UUID duplicated in Excel for ESPD v3.3.0
 * 
 */

var XLSX = require("xlsx")
var chalk = require('chalk')
var fs = require("fs")
const { readFileSync } = require('fs')

const { program } = require("@caporal/core")

const { cols } = require("./modules/espd_constants.cjs")

const in_excel_we_trust = [
    //"./criterion/ESPD-criterion_v4.0.0.xlsx",
    //"./criterion/ESPD-criterion_v3.3.0.xlsx",
    //"./criterion/ESPD-criterion_v3.2.0.xlsx",
    //"./criterion/ESPD-criterion_v3.1.0.xlsx",
    //"./criterion/ESPD-criterion_v3.0.1.xlsx",
    //"./criterion/ESPD-criterion_v3.0.0.xlsx",
    //"./criterion/ESPD-criterion-EXTENDED_v2.1.1.xlsx",
    //"./criterion/ESPD-criterion-BASIC_v2.1.1.xlsx",
    //"./criterion/ESPD-criterion-REGULATED_v2.1.0.xlsx",
    //"./criterion/ESPD-criterion-SELFCONTAINED_v2.1.0.xlsx",
    //"./criterion/ESPD-criterion-REGULATED_v2.0.2.xlsx",
    //"./criterion/ESPD-criterion-SELFCONTAINED_v2.0.2.xlsx",
    //"./criterion/ESPD-criterion-REGULATED_v2.0.1.xlsx",
    //"./criterion/ESPD-criterion-SELFCONTAINED_v2.0.1.xlsx",
    //"./criterion/ESPD-criterion-REGULATED_v2.0.0.xlsx",
    //"./criterion/ESPD-criterion-SELFCONTAINED_v2.0.0.xlsx"
],
    json_files = [
        "./criterion/otherCriteria.json",
        "./criterion/selectionCriteria.json",
        "./criterion/exclusionCriteria.json"
    ];

const log = console.log, ESDP_version = 'ESDP release ESPD Service v1.0.0', tool_version = '1.4.0', tool_name = 'uuid_tools';
XLSX.set_fs(fs);
var UUID_list = {};

program
    .version(tool_version)
    .name(tool_name)
    .description("Tool check Excel UUID for criterion")

    .command("extract_indicator", "Extract IDNDICATOR for each QUESTION")
    .action(({ logger, args, options }) => {
        // Combine styled and normal strings
        log(chalk.blue.bold('QUESTION-INDICATOR '), chalk.red(ESDP_version));
        log('\n\n')

        in_excel_we_trust.forEach(xcl => {
            var wbk = XLSX.readFile(xcl)
            log(chalk.bold(xcl))

            var sheet_name_list = wbk.SheetNames;

            for (const i in sheet_name_list) {
                log(''.padStart(80, '_'))
                log(chalk.bold(sheet_name_list[i]))
                extract_indicator(wbk.Sheets[sheet_name_list[i]], sheet_name_list[i])
                log('\n\n')
            }
        })
    })

    .command("criterion_description", "Extract Criterion description")
    .action(({ logger, args, options }) => {
        // Combine styled and normal strings
        log(chalk.blue.bold('Criterion Description'), chalk.red(ESDP_version));
        log('\n\n')

        in_excel_we_trust.forEach(xcl => {
            var wbk = XLSX.readFile(xcl)
            log(chalk.bold(xcl))

            var sheet_name_list = wbk.SheetNames;

            for (const i in sheet_name_list) {
                //log(''.padStart(80, '_'))
                //log(chalk.bold(sheet_name_list[i]))
                criterion_description(wbk.Sheets[sheet_name_list[i]], sheet_name_list[i])
                //log('\n\n')
            }
        })

        json_files.forEach(jsonf => {
            let criteria_count = 1, criteria_label = jsonf.indexOf('exclusion') != -1 ? 'EC' : (jsonf.indexOf('selection') != -1 ? 'SC' : 'OT');
            const raw_data = readFileSync(jsonf), data = JSON.parse(raw_data);
            log(chalk.bold(jsonf))
            if (typeof data.criteria !== 'undefined') {
                (data.criteria).forEach(elm => {
                    if (typeof elm.uuid !== 'undefined' &&
                        typeof elm.criterionType !== 'undefined' && typeof elm.criterionType.code !== 'undefined') {
                        log('ESPD_SERVICE',
                            chalk.green(elm.criterionType.code),
                            chalk.blue(`${criteria_label}-${criteria_count}`),
                            chalk.green(elm.uuid),
                            chalk.green(elm.description))
                        criteria_count++;
                    }
                });
            }
        })
    })

    .command("find_duplicate_UUID", "Build a list of duplicate UUIDs")
    .action(({ logger, args, options }) => {
        // Combine styled and normal strings
        log(chalk.blue.bold('UUID checking'), chalk.red(ESDP_version));
        log('\n\n')

        in_excel_we_trust.forEach(xcl => {
            var wbk = XLSX.readFile(xcl)
            log(chalk.bold(xcl))

            var sheet_name_list = wbk.SheetNames;

            for (const i in sheet_name_list) {
                //log(''.padStart(80, '_'))
                log(chalk.bold(sheet_name_list[i]))
                check_duplicate_UUID_path(wbk.Sheets[sheet_name_list[i]], sheet_name_list[i])
                //log('\n\n')
            }
        })
        log(''.padStart(80, '_'))

        //print the structure
        for (const elm in UUID_list) {
            if (UUID_list[elm].length > 1) {
                log(chalk.greenBright(elm))
                for (const child of UUID_list[elm]) {
                    log('\t', chalk.blue(child))
                }
            }
        }
    })

    .command("build_UUID_dictionary", "Build a list of UUIDs from Excel file")
    .action(({ logger, args, options }) => {
        // Combine styled and normal strings
        log(chalk.blue.bold('UUID dictionary'), chalk.red(ESDP_version));
        log('\n\n')

        in_excel_we_trust.forEach(xcl => {
            var wbk = XLSX.readFile(xcl)
            //log(chalk.bold(xcl))

            var sheet_name_list = wbk.SheetNames;

            for (const i in sheet_name_list) {
                //log(''.padStart(80, '_'))
                //log(chalk.bold(sheet_name_list[i]))
                tag_UUID_catalogue(wbk.Sheets[sheet_name_list[i]], sheet_name_list[i])
                //log('\n\n')
            }
        })

    })

    .command("JSON_to_UUID", "Extract UUIDs from JSON file")
    .action(({ logger, args, options }) => {
        // Combine styled and normal strings
        log(chalk.blue.bold('UUID dictionary'), chalk.red(ESDP_version));
        log('\n\n')

        json_files.forEach(jsonf => {
            let criteria_count = 1, criteria_label = jsonf.startsWith('exclusion') ? 'EC' : (jsonf.startsWith('selection') ? 'SC' : 'OT');
            const raw_data = readFileSync(jsonf), data = JSON.parse(raw_data);
            //Extract Criterion CODE, compute ITED_ID, extract UUID
            if (typeof data.criteria !== 'undefined') {
                (data.criteria).forEach(elm => {
                    if (typeof elm.uuid !== 'undefined' &&
                        typeof elm.criterionType !== 'undefined' && typeof elm.criterionType.code !== 'undefined') {
                        log('ESPD_SERVICE',
                            chalk.green(elm.criterionType.code),
                            chalk.blue(`${criteria_label}${criteria_count}`),
                            chalk.green(elm.uuid))
                        criteria_count++;
                    }
                });
            }

            //log(chalk.bold(jsonf))
        })
    })


// launch the main loop
program.run()

//build a list of duplicated UUIDs
function tag_UUID_catalogue(sph, sheetname) {

    var xlData = XLSX.utils.sheet_to_json(sph)

    let elementcode = ''

    //Column names are in row 1 and row 0 is consider to contain header keys
    let hdr = xlData[0]
    //Detect the column for each label
    for (const key in cols) {
        let lbl = cols[key].label
        if (Object.values(hdr).indexOf(lbl) != -1) {
            cols[key].column = Object.keys(hdr)[Object.values(hdr).indexOf(lbl)]
        }
    }



    xlData.forEach(element => {
        //get the tag
        let col_idx = 1, tag = ''

        do {
            //no entry
            if (typeof element[col_idx] === 'undefined') {
                col_idx++
                continue
            }
            //empty entry
            if (element[col_idx].toString().trim().length == 0) {
                col_idx++
                continue
            }

            //we can extract infomration from the cell
            let elm = element[col_idx].toString().trim()
            //tag format check
            if (elm.startsWith('{') || elm.endsWith('}')) {
                tag = elm.replace('{', '').replace('}', '')

                //start tag
                if (elm.startsWith('{') &&
                    !elm.endsWith('}')) {

                    if (tag == 'CRITERION') {
                        elementcode = element[cols.elementcode.column]
                    }
                }

                //one line tag
                if (elm.startsWith('{') && elm.endsWith('}')) {
                }

                //end tag
                if (!elm.startsWith('{') && elm.endsWith('}')) {
                }

                if (typeof element[cols.elementUUID.column] !== 'undefined' && element[cols.elementUUID.column].trim().length == 36) {
                    log(sheetname, '\t', elementcode, '\t', tag == 'CRITERION' ? `${tag}-${element[col_idx - 1]}` : tag, '\t', element[cols.elementUUID.column])
                }


                //log(tag)
                break
            }
            //some other text
            col_idx++
        } while (col_idx <= 17)

        if (col_idx == 18 && tag == '') {
            //empty line or does not contain any tag
            //log(chalk.bgRed.white('Empty row'))
            return
        }

    });
}


/**
 * Extract the Description for each Criterion
 * 
 * @param {Object} sph - Spreadsheet object 
 * @param {string} sheetname - Spreadsheet name
 */
function criterion_description(sph, sheetname) {
    var xlData = XLSX.utils.sheet_to_json(sph)

    let ns = '', level = 1, ontrue = false

    //Column names are in row 1 and row 0 is consider to contain header keys
    let hdr = xlData[0]
    //Detect the column for each label
    for (const key in cols) {
        let lbl = cols[key].label
        if (Object.values(hdr).indexOf(lbl) != -1) {
            cols[key].column = Object.keys(hdr)[Object.values(hdr).indexOf(lbl)]
        }
    }

    xlData.forEach(element => {
        //get the tag
        let col_idx = 1, tag = ''

        do {
            //no entry
            if (typeof element[col_idx] === 'undefined') {
                col_idx++
                continue
            }
            //empty entry
            if (element[col_idx].toString().trim().length == 0) {
                col_idx++
                continue
            }

            let elm = element[col_idx].toString().trim()
            //tag
            if (elm.startsWith('{') || elm.endsWith('}')) {
                tag = elm.replace('{', '').replace('}', '')

                //start tag
                if (elm.startsWith('{') && !elm.endsWith('}')) {
                    if (tag == 'CRITERION') {
                        log(sheetname, '\t',
                            element[cols.elementcode.column], '\t',
                            `${tag}-${element[col_idx - 1].toString()}`, '\t',
                            element[cols.elementUUID.column], '\t',
                            element[cols.description.column])
                    }

                }

                //log(tag)
                break
            }
            //some other text
            col_idx++
        } while (col_idx <= 17)

        if (col_idx == 18 && tag == '') {
            //empty line or does not contain any tag
            //log(chalk.bgRed.white('Empty row'))
            return
        }

    })
}

//Extract the INDICATOR value for each QUESTION
//Extract the QUESTION_SUBGROPU that follow to check for ONTRUE and ONFALSE
function extract_indicator(sph, sheetname) {
    var xlData = XLSX.utils.sheet_to_json(sph)

    let ns = '', level = 1, ontrue = false

    //Column names are in row 1 and row 0 is consider to contain header keys
    let hdr = xlData[0]
    //Detect the column for each label
    for (const key in cols) {
        let lbl = cols[key].label
        if (Object.values(hdr).indexOf(lbl) != -1) {
            cols[key].column = Object.keys(hdr)[Object.values(hdr).indexOf(lbl)]
        }
    }


    xlData.forEach(element => {
        //get the tag
        let col_idx = 1, tag = ''

        do {
            //no entry
            if (typeof element[col_idx] === 'undefined') {
                col_idx++
                continue
            }
            //empty entry
            if (element[col_idx].toString().trim().length == 0) {
                col_idx++
                continue
            }

            let elm = element[col_idx].toString().trim()
            //tag
            if (elm.startsWith('{') || elm.endsWith('}')) {
                tag = elm.replace('{', '').replace('}', '')

                //start tag
                if (elm.startsWith('{') && !elm.endsWith('}')) {
                    if (tag == 'CRITERION') {
                        ns = `${element[cols.elementcode.column]}`
                        log(chalk.blue(`${ns}`))
                        ontrue = false
                    }

                    if (ontrue && tag == 'QUESTION_SUBGROUP') {
                        log(''.padStart(col_idx - 2, '\t'), chalk.green(tag), '\t', element[cols.elementcode.column])
                    }
                }

                //one line tag
                if (elm.startsWith('{') && elm.endsWith('}')) {
                    if (tag == 'QUESTION' &&
                        element[cols.propertydatatype.column] == 'INDICATOR') {
                        log(''.padStart(col_idx - 2, '\t'), chalk.green(tag), '\t', element[cols.buyervalue.column])
                        ontrue = true
                        level = col_idx + 1
                    }
                }

                //end tag
                if (!elm.startsWith('{') && elm.endsWith('}')) {
                    if (tag == 'CRITERION') {
                        ontrue = false
                    }

                    if (ontrue && level > col_idx) {
                        //ontrue = false
                    }
                }

                //log(tag)
                break
            }
            //some other text
            col_idx++
        } while (col_idx <= 17)

        if (col_idx == 18 && tag == '') {
            //empty line or does not contain any tag
            //log(chalk.bgRed.white('Empty row'))
            return
        }

    })

}

//build a list of duplicated UUIDs
function check_duplicate_UUID_path(sph, sheetname) {

    var xlData = XLSX.utils.sheet_to_json(sph)

    let elementcode = ''
    //Column names are in row 1 and row 0 is consider to contain header keys
    let hdr = xlData[0]
    //Detect the column for each label
    for (const key in cols) {
        let lbl = cols[key].label
        if (Object.values(hdr).indexOf(lbl) != -1) {
            cols[key].column = Object.keys(hdr)[Object.values(hdr).indexOf(lbl)]
        }
    }

    xlData.forEach(element => {

        //get the tag
        let col_idx = 1
        let tag = '';


        do {
            //no entry
            if (typeof element[col_idx] === 'undefined') {
                col_idx++
                continue
            }
            //empty entry
            if (element[col_idx].toString().trim().length == 0) {
                col_idx++
                continue
            }
            let elm = element[col_idx].toString().trim()
            //tag
            if (elm.startsWith('{') || elm.endsWith('}')) {
                tag = elm.replace('{', '').replace('}', '')

                //start tag
                if (elm.startsWith('{') &&
                    !elm.endsWith('}')) {

                    if (tag == 'CRITERION') {
                        elementcode = `${sheetname}::${element[cols.elementcode.column]}`
                    }
                }

                //one line tag
                if (elm.startsWith('{') &&
                    elm.endsWith('}')) {
                }

                //end tag
                if (!elm.startsWith('{') && elm.endsWith('}')) {
                }

                if (typeof element[cols.elementUUID.column] !== 'undefined' && element[cols.elementUUID.column].trim().length > 0) {
                    if (typeof UUID_list[element[cols.elementUUID.column]] === 'undefined') {
                        UUID_list[element[cols.elementUUID.column]] = []
                        UUID_list[element[cols.elementUUID.column]].push(elementcode)
                    } else {
                        UUID_list[element[cols.elementUUID.column]].push(elementcode)
                    }
                }


                //log(tag)
                break
            }
            //some other text
            col_idx++
        } while (col_idx <= 17)

        if (col_idx == 18 && tag == '') {
            //empty line or does not contain any tag
            //log(chalk.bgRed.white('Empty row'))
            return
        }

    });
}