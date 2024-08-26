#!/usr/bin/env node

/*
 * NodeJS application to check UUID generated in Excel for ESPD v4.0.0
 * 
 * 1. Check that the tags created for each element are correct and the numbering corresponds to nesting level 
 * 2. Check that the generated path is valid according to the UUID generation algorithm
 * 3. Other functionalities to extact information from the Excel file
 * 
 */

var XLSX = require("xlsx")
var chalk = require('chalk');
var fs = require("fs")

const { program } = require("@caporal/core");
const path = require("path");

//Tags mapped to elements from the Excel 
/**
 * Name	
 * Description	
 * Buyer Value (example)	
 * Seller Value (example)	
 * Cardinality	
 * PropertyDataType	
 * XML PATH Like VARIANT ID Request	
 * ElementUUID	
 * XML PATH LIKE VARIANT ID Response Structure	
 * XML PATH LIKE VARIANT ID Response Contents (1)	
 * XML PATH LIKE VARIANT ID Response Contents (2)	
 * XML PATH LIKE VARIANT ID Response Contents (3)	
 * Element Code	
 * Code List	
 * Comment
 */
const cols = {
    name: {
        label: "Name",
        column: 0
    },
    description: {
        label: "Description",
        column: 0
    },
    buyervalue: {
        label: "Buyer Value (example)",
        column: 0
    },
    sellervalue: {
        label: "Seller Value (example)",
        column: 0
    },
    cardinality: {
        label: "Cardinality",
        column: 0
    },
    propertydatatype: {
        label: "PropertyDataType",
        column: 0
    },
    elementUUID: {
        label: 'ElementUUID',
        column: 0
    },
    elementcode: {
        label: "Element Code",
        column: 0
    },
    codelist: {
        label: "Code List",
        column: 0
    },
    comment: {
        label: "Comment",
        column: 0
    },
    requestpath: {
        label: "XML PATH Like VARIANT ID Request",
        column: 0
    },
    responsepath: {
        label: "XML PATH LIKE VARIANT ID Response Structure",
        column: 0
    },
    responsecontent1: {
        label: "XML PATH LIKE VARIANT ID Response Contents (1)",
        column: 0
    },
    responsecontent2: {
        label: "XML PATH LIKE VARIANT ID Response Contents (2)",
        column: 0
    },
    responsecontent3: {
        label: "XML PATH LIKE VARIANT ID Response Contents (3)",
        column: 0
    }
};

//Tags mapped to elements from the Excel 
const tag_map = {
    'CRITERION': 'C',
    'ADDITIONAL_DESCRIPTION_LINE': 'ADL',
    'SUBCRITERION': 'SBC',
    'LEGISLATION': 'L',
    'REQUIREMENT_GROUP': 'RG',
    'QUESTION_GROUP': 'QG',
    'REQUIREMENT_SUBGROUP': 'RSG',
    'QUESTION_SUBGROUP': 'QSG',
    'CAPTION': 'CA',
    'REQUIREMENT': 'RQ',
    'QUESTION': 'Q',
    'RESPONSE': 'R',
    'RESPONSE VALUE': 'RV',
    'EVIDENCE SUPPLIED': 'RES',
    'APPLICABLE PERIOD': 'RAP',
}
var counter = {
    'C': 0,
    'ADL': 1,
    'SBC': 1,
    'L': 1,
    'RG': 1,
    'QG': 1,
    'RSG': 1,
    'QSG': 1,
    'CA': 1,
    'RQ': 1,
    'Q': 1,
    'R': 1,
    'RV': 1,
    'RES': 1,
    'RAP': 1,
}

const namespace_map = {
    'EG-': '_EG_',
    'SC-': '_SC_',
    'SC_': '_SC_',
    'OTHER-': '_OT_',
    'OTHER.': '_OT_'
}

const in_excel_we_trust = [
    "ESPD-criterion-request-multiple-C25-C32.xlsx",
    "ESPD-criterion-response-multiple-C1-C25-C32.xlsx"
]

//Check the complete list of invalid CRITERION
const invalid_criterion = [33, 62, 64]

const log = console.log;
XLSX.set_fs(fs);
let element_children = {};

program
    .version("1.0.0")
    .name("checkjs")
    .description("Tool to handle Criterion Excel files")

    .command("all_JSON", "Print all spreadsheets as JSON")
    .action(({ logger, args, options }) => {
        // Combine styled and normal strings
        log(chalk.blue.bold('UUID checking'), chalk.red('for ESPD realease v4.0.0.'));
        log('\n\n')

        in_excel_we_trust.forEach(xcl => {
            var wbk = XLSX.readFile(xcl),
                what = xcl.indexOf('-request-') != -1
            log(chalk.bold(xcl))

            var sheet_name_list = wbk.SheetNames;
            counter[tag_map['CRITERION']] = 0

            for (const i in sheet_name_list) {
                log(''.padStart(80, '_'))
                log(chalk.bold(sheet_name_list[i]))
                print_all(wbk.Sheets[sheet_name_list[i]])
                log('\n\n')
            }
        })

    })

    .command("full_structures", "Print full structure of each spreadsheet")
    .action(({ logger, args, options }) => {
        // Combine styled and normal strings
        log(chalk.blue.bold('UUID checking'), chalk.red('for ESPD realease v4.0.0.'));
        log('\n\n')

        in_excel_we_trust.forEach(xcl => {
            var wbk = XLSX.readFile(xcl),
                what = xcl.indexOf('-request-') != -1
            log(chalk.bold(xcl))

            var sheet_name_list = wbk.SheetNames;
            counter[tag_map['CRITERION']] = 0

            for (const i in sheet_name_list) {
                log(''.padStart(80, '_'))
                log(chalk.bold(sheet_name_list[i]))
                print_structures(wbk.Sheets[sheet_name_list[i]])
                log('\n\n')
            }
        })
    })

    .command("each_structure", "Print the element and child structure")
    .action(({ logger, args, options }) => {
        // Combine styled and normal strings
        log(chalk.blue.bold('UUID checking'), chalk.red('for ESPD realease v4.0.0.'));
        log('\n\n')

        element_children = {};

        in_excel_we_trust.forEach(xcl => {
            var wbk = XLSX.readFile(xcl),
                what = xcl.indexOf('-request-') != -1
            log(chalk.bold(xcl))

            var sheet_name_list = wbk.SheetNames;

            for (const i in sheet_name_list) {
                //log(''.padStart(80, '_'))
                //log(chalk.bold(sheet_name_list[i]))
                //detect elements structure
                detect_structure(wbk.Sheets[sheet_name_list[i]])
                //log('\n\n')
            }

            //print the structure
            for (const elm in element_children) {
                log(chalk.greenBright(elm))
                for (const child of element_children[elm]) {
                    log('\t', chalk.blue(child))
                }
            }
        })
    })

    .command("check_tag", "Check the TAGS for each element")
    .action(({ logger, args, options }) => {
        // Combine styled and normal strings
        log(chalk.blue.bold('UUID checking'), chalk.red('for ESPD realease v4.0.0.'));
        log('\n\n')

        in_excel_we_trust.forEach(xcl => {
            var wbk = XLSX.readFile(xcl),
                what = xcl.indexOf('-request-') != -1
            log(chalk.bold(xcl))

            var sheet_name_list = wbk.SheetNames;
            counter[tag_map['CRITERION']] = 0

            for (const i in sheet_name_list) {
                log(''.padStart(80, '_'))
                log(chalk.bold(sheet_name_list[i]))
                check_tags(wbk.Sheets[sheet_name_list[i]], what)
                log('\n\n')
            }
        })
    })

    .command("check_UUID", "Check the XML like path IDs for each element")
    .action(({ logger, args, options }) => {
        // Combine styled and normal strings
        log(chalk.blue.bold('UUID checking'), chalk.red('for ESPD realease v4.0.0.'));
        log('\n\n')

        in_excel_we_trust.forEach(xcl => {
            var wbk = XLSX.readFile(xcl),
                what = xcl.indexOf('-request-') != -1
            log(chalk.bold(xcl))

            var sheet_name_list = wbk.SheetNames;
            counter[tag_map['CRITERION']] = 0

            for (const i in sheet_name_list) {
                log(''.padStart(80, '_'))
                log(chalk.bold(sheet_name_list[i]))
                check_UUID_path(wbk.Sheets[sheet_name_list[i]], what, sheet_name_list[i])
                log('\n\n')
            }
        })
    })


// launch the main loop
program.run()

//check the green label before each element in the Excel file
//tags are unique per level
//the numbering of same tags on the same level is continuous
//CRITERION numbering is continuous over the entire workbook --- exceptions to be taken into account from invalid_criterion
function check_tags(sph, IS_REQUEST) {
    var xlData = XLSX.utils.sheet_to_json(sph)
    var crt_structure = {}

    xlData.forEach(element => {

        //Detect the column for each label
        for (const key in cols) {
            let lbl = cols[key].label
            if (Object.values(element).indexOf(lbl) != -1) {
                cols[key].column = Object.keys(element)[Object.values(element).indexOf(lbl)]
                //log(cols[key].label, cols[key].column)
            }
        }

        //get the tag
        let col_idx = 1
        let tag = ''

        do {
            //no entry
            if (typeof element[col_idx] === 'undefined') {
                col_idx++
                continue
            }
            //empty entry
            if (element[col_idx].trim().length == 0) {
                col_idx++
                continue
            }
            //tag
            if (element[col_idx].trim().startsWith('{') || element[col_idx].trim().endsWith('}')) {
                tag = element[col_idx].trim().replace('{', '').replace('}', '')

                //start tag
                if (element[col_idx].trim().startsWith('{') &&
                    !element[col_idx].trim().endsWith('}')) {
                    if (tag == 'CRITERION') {
                        counter[tag_map[tag]]++
                        //skip the invalid CRITERION numbers
                        if (invalid_criterion.indexOf(counter[tag_map[tag]]) != -1) {
                            counter[tag_map[tag]]++
                        }
                    }
                    //for the other elements have to compute the corresponding level
                    if (typeof crt_structure[col_idx - 2] === 'undefined') crt_structure[col_idx - 2] = {}

                    if (typeof crt_structure[col_idx - 2][tag_map[tag]] === 'undefined') {
                        crt_structure[col_idx - 2][tag_map[tag]] = 1
                    } else {

                        //process the cardinality
                        if (` ${element[cols.cardinality.column]}`.indexOf('(') != -1) {
                            let card = element[cols.cardinality.column].match(/\([\d]\)/g)[0].replace('(', '').replace(')', '')
                            if (card == 1) crt_structure[col_idx - 2][tag_map[tag]]++
                        } else {
                            crt_structure[col_idx - 2][tag_map[tag]]++
                        }

                    }

                    crt_structure[0][tag_map['CRITERION']] = counter[tag_map['CRITERION']]

                    const tag_ok = element[col_idx - 1] == `${tag_map[tag]}${crt_structure[col_idx - 2][tag_map[tag]]}`

                    if (!tag_ok) log(`${tag_map[tag]}${crt_structure[col_idx - 2][tag_map[tag]]}`)
                    //print the result
                    log(tag_ok ? chalk.bold.green('[OK]\t') : chalk.bold.red('[NOK]\t'),
                        chalk.green(element[col_idx - 1]), '\t',
                        ''.padStart(col_idx - 2, '\t'),
                        chalk.bgWhite.black(tag))

                }

                //one line tag
                if (element[col_idx].trim().startsWith('{') &&
                    element[col_idx].trim().endsWith('}')) {
                    if (typeof crt_structure[col_idx - 2] === 'undefined') crt_structure[col_idx - 2] = {}
                    if (typeof crt_structure[col_idx - 2][tag_map[tag]] === 'undefined') {
                        crt_structure[col_idx - 2][tag_map[tag]] = 1
                    } else {
                        if (` ${element[cols.cardinality.column]}`.indexOf('(') == -1) {
                            crt_structure[col_idx - 2][tag_map[tag]]++
                        }
                    }
                    const tag_ok = element[col_idx - 1] == `${tag_map[tag]}${crt_structure[col_idx - 2][tag_map[tag]]}`

                    //print the result
                    log(tag_ok ? chalk.bold.green('[OK]\t') : chalk.bold.red('[NOK]\t'),
                        chalk.green(element[col_idx - 1]), '\t',
                        ''.padStart(col_idx - 2, '\t'),
                        chalk.bgWhite.black(tag))
                }

                //end tag
                if (!element[col_idx].trim().startsWith('{') &&
                    element[col_idx].trim().endsWith('}')) {
                    if (tag == 'CRITERION') crt_structure = {}
                    delete crt_structure[col_idx - 1]
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

//check the XML like path that is generated for each element
//the path for Request is in the column 23 and is only for opening tags or one line tags
//the path for Response is in the columns 24 as Request and for each variant of response in cols: 26, 27, 28, 29
//the namespace is composed from: CRITERION-NUMBER::namespace_map::Element Code (Crierion line, column 25 for Reques and column 30 for Response)
//the other rules:
// - concatenate the path for each child element
function check_UUID_path(sph, IS_REQUEST, sheetname) {
    //IS_REQUEST = true -> Request Excel file, otehrwise Response Excel file

    var xlData = XLSX.utils.sheet_to_json(sph)
    let crt_structure = {}
    let root_element = ''
    let path_structure = []
    let end_path = [], res_end_path = [];
    let tag_path = [], res_tag_path = [];

    xlData.forEach(element => {

        //Detect the column for each label
        for (const key in cols) {
            let lbl = cols[key].label
            if (Object.values(element).indexOf(lbl) != -1) {
                cols[key].column = Object.keys(element)[Object.values(element).indexOf(lbl)]
                //log(cols[key].label, cols[key].column)
            }
        }

        //get the tag
        let col_idx = 1
        let tag = ''
        

        do {
            //no entry
            if (typeof element[col_idx] === 'undefined') {
                col_idx++
                continue
            }
            //empty entry
            if (element[col_idx].trim().length == 0) {
                col_idx++
                continue
            }
            //tag
            if (element[col_idx].trim().startsWith('{') || element[col_idx].trim().endsWith('}')) {
                tag = element[col_idx].trim().replace('{', '').replace('}', '')

                //start tag
                if (element[col_idx].trim().startsWith('{') &&
                    !element[col_idx].trim().endsWith('}')) {

                    if (tag == 'CRITERION') {
                        counter[tag_map[tag]]++
                        //skip the invalid CRITERION numbers
                        if (invalid_criterion.indexOf(counter[tag_map[tag]]) != -1) {
                            counter[tag_map[tag]]++
                        }
                        //create root element
                        var ns = ''
                        for (const p in namespace_map) {
                            if (sheetname.startsWith(p)) {
                                ns = namespace_map[p]
                                break
                            }
                        }

                        root_element = `${tag_map[tag]}${counter[tag_map[tag]]}${ns}${element[cols.elementcode.column]}`

                        path_structure.push(root_element)
                    }

                    //for the other elements have to compute the corresponding level
                    if (typeof crt_structure[col_idx - 2] === 'undefined') crt_structure[col_idx - 2] = {}

                    if (typeof crt_structure[col_idx - 2][tag_map[tag]] === 'undefined') {
                        crt_structure[col_idx - 2][tag_map[tag]] = 1
                    } else {
                        if (!IS_REQUEST) {
                            //process the cardinality
                            if (` ${element[cols.cardinality.column]}`.indexOf('(') != -1) {
                                let card = element[cols.cardinality.column].match(/\([\d]\)/g)[0].replace('(', '').replace(')', '')
                                if (card == 1) crt_structure[col_idx - 2][tag_map[tag]]++
                            } else {
                                crt_structure[col_idx - 2][tag_map[tag]]++
                            }
                        } else if (` ${element[cols.cardinality.column]}`.indexOf('(') == -1) {
                            crt_structure[col_idx - 2][tag_map[tag]]++
                        }
                    }

                    crt_structure[0][tag_map['CRITERION']] = counter[tag_map['CRITERION']]

                    if (tag != 'CRITERION') {
                        path_structure.push(`${tag_map[tag]}${crt_structure[col_idx - 2][tag_map[tag]]}`)
                    }

                    let tag_ok = false, computed_path = path_structure.join('/')

                    if(tag == 'REQUIREMENT_GROUP' || tag == 'REQUIREMENT_SUBGROUP'){
                        if (` ${element[cols.cardinality.column]}`.indexOf('(') != -1) {
                            let card = element[cols.cardinality.column].match(/\([\d]\)/g)[0].replace('(', '').replace(')', '')    
                            end_path.push(`/R${card}`)
                        }else if( ` ${element[cols.cardinality.column]}`.indexOf('..n') != -1){
                            end_path.push('/R1')
                        }else if( ` ${element[cols.cardinality.column]}`.indexOf('0..1') != -1 ||  `${element[cols.cardinality.column]}` == '1'){
                            end_path.push('')
                        }
                        tag_path.push(tag)

                        //log(end_path.reduce((acc, crtval) => crtval.length==0?acc:acc+crtval, ''), tag, tag_path.join(':'))
                    }

                    //Response processing
                    if(!IS_REQUEST){
                        //if(tag == 'QUESTION_GROUP' || tag == 'QUESTION_SUBGROUP'){
                            
                            if (` ${element[cols.cardinality.column]}`.indexOf('(') != -1) {
                                let card = element[cols.cardinality.column].match(/\([\d]\)/g)[0].replace('(', '').replace(')', '')    
                                res_end_path.push(`/R${card}`)
                            }else if( ` ${element[cols.cardinality.column]}`.indexOf('..n') != -1){
                                res_end_path.push('/R1')
                            }else if( ` ${element[cols.cardinality.column]}`.indexOf('0..1') != -1 ||  `${element[cols.cardinality.column]}` == '1'){
                                res_end_path.push('')
                            }
                            res_tag_path.push(tag)
                            //log(res_end_path.reduce((acc, crtval) => crtval.length==0?acc:acc+crtval, ''), tag, ' -> ', res_tag_path.join(':'))
                        //}
                    }


                    
                    tag_ok = (element[cols.requestpath.column].trim() == computed_path)

                    //print the result
                    log(tag_ok ? chalk.bold.green('[OK]\t') : chalk.bold.red('[NOK]\t'),
                        chalk.green(element[col_idx - 1]), '\t',
                        chalk.green(element[cols.requestpath.column].trim().padEnd(60)), '\t',
                        chalk.blue(computed_path.padEnd(60)), '\t',
                        ''.padStart(col_idx - 2, '\t'),
                        chalk.bgWhite.black(tag))

                }

                //one line tag
                if (element[col_idx].trim().startsWith('{') &&
                    element[col_idx].trim().endsWith('}')) {

                    if (typeof crt_structure[col_idx - 2] === 'undefined') crt_structure[col_idx - 2] = {}

                    if (typeof crt_structure[col_idx - 2][tag_map[tag]] === 'undefined') {
                        crt_structure[col_idx - 2][tag_map[tag]] = 1
                    } else {
                        if (` ${element[cols.cardinality.column]}`.indexOf('(') == -1) {
                            crt_structure[col_idx - 2][tag_map[tag]]++
                        }
                    }

                    if (tag != 'CRITERION') {
                        path_structure.push(`${tag_map[tag]}${crt_structure[col_idx - 2][tag_map[tag]]}`)
                    }

                    let computed_path = path_structure.join('/'), res_computed_path = path_structure.join('/');

                    if (tag == 'REQUIREMENT') {
                        if (` ${element[cols.cardinality.column]}`.indexOf('(') != -1) {
                            let card = element[cols.cardinality.column].match(/\([\d]\)/g)[0].replace('(', '').replace(')', '')
                            end_path.push(`/R${card}`)                            
                        } else {
                            end_path.push('/R1')
                        }
                        //log(end_path.reduce((acc, crtval) => crtval.length==0?acc:acc+crtval, ''), tag)
                        computed_path = computed_path.concat(end_path.reduce((acc, crtval) => crtval.length==0?acc:acc+crtval, ''))
                        end_path.pop()
                    }

                    //Response QUESTION tag
                    if(! IS_REQUEST){
                        if(tag == 'QUESTION'){
                            res_end_path.push('/R1')
                            let val_path = element[cols.propertydatatype.column] == 'PERIOD'?'/RAP':(element[cols.propertydatatype.column] == 'EVIDENCE_IDENTIFIER'?'/RES':'/RV')

                            //log(res_end_path.reduce((acc, crtval) => crtval.length==0?acc:acc+crtval, ''), tag)
                            res_computed_path = res_computed_path.concat(res_end_path.reduce((acc, crtval) => crtval.length==0?acc:acc+crtval, ''))
                            res_end_path.pop() 

                            
                            let check1 = res_computed_path == element[cols.responsecontent1.column], check3 = res_computed_path.concat(val_path) == element[cols.responsecontent3.column];
                            
                            log(check1 ? chalk.bold.green('[OK]\t') : chalk.bold.red('[NOK]\t'),
                            chalk.green(element[col_idx - 1]), '\t',
                            chalk.green(element[cols.responsecontent1.column].trim().padEnd(60)), '\t',
                            chalk.blue(res_computed_path.padEnd(60)), '\t',
                            ''.padStart(col_idx - 2, '\t'),
                            chalk.bgWhite.black(tag))

                            log(check3 ? chalk.bold.green('[OK]\t') : chalk.bold.red('[NOK]\t'),
                            chalk.green(element[col_idx - 1]), '\t',
                            chalk.green(element[cols.responsecontent3.column].trim().padEnd(60)), '\t',
                            chalk.blue(res_computed_path.concat(val_path).padEnd(60)), '\t',
                            ''.padStart(col_idx - 2, '\t'),
                            chalk.bgWhite.black(tag))
                        }
                        
                    }


                    let tag_ok = (element[cols.requestpath.column].trim() == computed_path)

                    //print the result
                    log(tag_ok ? chalk.bold.green('[OK]\t') : chalk.bold.red('[NOK]\t'),
                        chalk.green(element[col_idx - 1]), '\t',
                        chalk.green(element[cols.requestpath.column].trim().padEnd(60)), '\t',
                        chalk.blue(computed_path.padEnd(60)), '\t',
                        ''.padStart(col_idx - 2, '\t'),
                        chalk.bgWhite.black(tag))
                    
                    path_structure.pop()

                }

                //end tag
                if (!element[col_idx].trim().startsWith('{') && element[col_idx].trim().endsWith('}')) {

                    if (tag == 'CRITERION') {
                        crt_structure = {}
                        path_structure = []
                        end_path = []
                        tag_path = []
                        res_end_path = []
                        res_tag_path = []
                    }
                    delete crt_structure[col_idx - 1]
                    path_structure.pop()


                    if (tag == tag_path[tag_path.length-1]) {
                        end_path.pop()
                        tag_path.pop()
                    }

                    if (tag == res_tag_path[res_tag_path.length-1]) {
                        res_end_path.pop()
                        res_tag_path.pop()
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

//detect and print the structure of the objects
//as described in col2-col17
function print_structures(sph) {
    var xlData = XLSX.utils.sheet_to_json(sph)

    let cardinality = 1

    xlData.forEach(element => {

        //log(element)
        if (Object.values(element).indexOf('Cardinality') != -1) {
            cardinality = Object.keys(element)[Object.values(element).indexOf('Cardinality')]
            //log(cardinality, element[cardinality])
        }

        //get the tag
        let col_idx = 1
        let tag = ''

        do {
            //no entry
            if (typeof element[col_idx] === 'undefined') {
                col_idx++
                continue
            }
            //empty entry
            if (element[col_idx].trim().length == 0) {
                col_idx++
                continue
            }
            //tag
            if (element[col_idx].trim().startsWith('{') || element[col_idx].trim().endsWith('}')) {
                tag = element[col_idx].trim().replace('{', '').replace('}', '')
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

        log(''.padStart(col_idx - 2, '\t'), chalk.blueBright(tag), '\t', element[cardinality] ? element[cardinality] : '')

    });

}

//detect elemets structure only the 1st level
//root -> child elements
function detect_structure(sph) {
    var xlData = XLSX.utils.sheet_to_json(sph)
    var parent = null, parent_col = 0
    let cardinality = 1
    xlData.forEach(element => {

        if (Object.values(element).indexOf('Cardinality') != -1) {
            cardinality = Object.keys(element)[Object.values(element).indexOf('Cardinality')]
            //log(cardinality, element[cardinality])
        }
        //get the tag
        let col_idx = 1
        let tag = ''

        do {
            //no entry
            if (typeof element[col_idx] === 'undefined') {
                col_idx++
                continue
            }
            //empty entry
            if (element[col_idx].trim().length == 0) {
                col_idx++
                continue
            }
            //tag
            //open tag that may contain sub tags
            if ((element[col_idx].trim().startsWith('{') && !element[col_idx].trim().endsWith('}'))) {
                tag = element[col_idx].trim().replace('{', '')
                //log(tag)
                if (!Object.hasOwn(element_children, tag)) element_children[tag] = []
                if (parent && parent_col < col_idx &&
                    element_children[parent].indexOf(`${tag}  ${element[cardinality] ? element[cardinality] : '?!?'}`) == -1) element_children[parent].push(`${tag}  ${element[cardinality] ? element[cardinality] : '?!?'}`)
                parent = tag
                parent_col = col_idx

                if (tag != 'CRITERION' && (!element[cardinality] || (element[cardinality] && `${element[cardinality]}`.trim() == ''))) log(`No cardinality ${parent}:${tag} __ ${typeof element[cardinality]}`)
                break
            }
            //one line tag - most probably the leaf
            if ((element[col_idx].trim().startsWith('{') && element[col_idx].trim().endsWith('}'))) {
                tag = element[col_idx].trim().replace('{', '').replace('}', '')
                //log(tag)
                //if (typeof element_children[tag] === 'undefined') element_children[tag] = []
                if (parent && element_children[parent].indexOf(`${tag}  ${element[cardinality] ? element[cardinality] : '?!?'}`) == -1) element_children[parent].push(`${tag}  ${element[cardinality] ? element[cardinality] : '?!?'}`)

                if (!element[cardinality] || (element[cardinality] && `${element[cardinality]}`.trim() == '')) log(`No cardinality ${parent}:${tag} __ ${typeof element[cardinality]}`)
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

//dump Excel to JSON
function print_all(sph) {
    var xlData = XLSX.utils.sheet_to_json(sph)
    log(xlData)
}