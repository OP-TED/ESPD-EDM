#!/usr/bin/env node

/*
 * NodeJS application to convert Excel for ESPD Criterion to
 * various formats: 
 *   - BoostarpVueJs
 *   - Salt wireframes for PlantUML 
 *   - Salt tree tables for PlantUML
 * 
 */


var XLSX = require("xlsx")
var chalk = require('chalk')
var fs = require("fs")
const { program } = require("@caporal/core")

var { JSON2file } = require("./modules/espd_utils.cjs");
const { cols, tag_map } = require("./modules/espd_constants.cjs")

const in_excel_we_trust = [
    //"ESPD-criterion-request-multiple-C25-C32.xlsx",
    //"./criterion/ESPD-criterion-res_v4.0.0.xlsx",
    "./criterion/ESPD-criterion_v4.0.0.xlsx"

]

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

const log = console.log, ESDP_version = 'ESDP release v4.0.0'
XLSX.set_fs(fs)
var vue_stream = null, espd_json = {}, name_version = '';

program
    .version("1.6.0")
    .name("convert_to")
    .description("Tool to convert Criterion Excel file to other fromats")

    .command("excel2vue", "Generate BootstrapVue components for each criteria")
    .action(({ logger, args, options }) => {
        // Combine styled and normal strings
        log(chalk.blue.bold('Vuefy Excel'), chalk.red(ESDP_version));
        log('\n\n')

        in_excel_we_trust.forEach(xcl => {
            var wbk = XLSX.readFile(xcl)
            log(chalk.bold(xcl))

            var sheet_name_list = wbk.SheetNames;

            for (const i in sheet_name_list) {
                log(''.padStart(80, '_'))
                log(chalk.bold(sheet_name_list[i]))
                excel2bootstrapvue(wbk.Sheets[sheet_name_list[i]], sheet_name_list[i])
                log('\n\n')
            }

            //espd_json contains all information from Excel in JSON format
            //save the JSON_file
            //log(JSON.stringify(espd_json, null, ' '))
            name_version = xcl.substring(xcl.indexOf('_v') + 1, xcl.length - ".xlsx".length)

            JSON2file(`.\\espd_edm_${name_version}.json`, espd_json)


            if (fs.existsSync(`.\\espd_${name_version}.js`)) {
                try {
                    fs.unlinkSync(`.\\espd_${name_version}.js`)
                } catch (error) {
                    log(error)
                }
            }
            fs.writeFileSync(`.\\espd_${name_version}.js`, `/**\n * VueJS components for ESDP-EDM \n * generated on ${(new Date(Date.now())).toISOString()} \n */\n\n`)

            vue_stream = fs.createWriteStream(`.\\espd_${name_version}.js`, { flags: 'a' });
            JSON2Vue(espd_json)
            vue_stream.end()

            if (fs.existsSync(`.\\espd_response_${name_version}.js`)) {
                try {
                    fs.unlinkSync(`.\\espd_response_${name_version}.js`)
                } catch (error) {
                    log(error)
                }
            }

            vue_stream = fs.createWriteStream(`.\\espd_response_${name_version}.js`, { flags: 'a' });
            J2V4ESPD(espd_json)
            vue_stream.end()
        })
    })

    .command("excel2salt", "Transform Excel to PlantUML Salt UI mockups")
    .action(({ logger, args, options }) => {
        // Combine styled and normal strings
        log(chalk.blue.bold('UUID checking'), chalk.red('for ESPD realease v4.0.0.'));
        log('\n\n')

        in_excel_we_trust.forEach(xcl => {
            var wbk = XLSX.readFile(xcl)
            log(chalk.bold(xcl))

            var sheet_name_list = wbk.SheetNames;
            counter[tag_map['CRITERION']] = 0

            for (const i in sheet_name_list) {
                log(''.padStart(80, '_'))
                log(chalk.bold(sheet_name_list[i]))
                excel2salt(wbk.Sheets[sheet_name_list[i]])
                log('\n\n')
            }
        })
    })

    .command("excel2treetrable", "Transform Excel to PlantUML tree table diagram")
    .action(({ logger, args, options }) => {
        // Combine styled and normal strings
        log(chalk.blue.bold('UUID checking'), chalk.red('for ESPD realease v4.0.0.'));
        log('\n\n')

        in_excel_we_trust.forEach(xcl => {
            var wbk = XLSX.readFile(xcl)
            log(chalk.bold(xcl))

            var sheet_name_list = wbk.SheetNames;
            counter[tag_map['CRITERION']] = 0

            for (const i in sheet_name_list) {
                log(''.padStart(80, '_'))
                log(chalk.bold(sheet_name_list[i]))
                excel2treetable(wbk.Sheets[sheet_name_list[i]])
                log('\n\n')
            }
        })
    })

// launch the main loop
program.run()


/**
 * Detect and transform the structure from Excel to JSON
 * used to create for each Criteria a Vue component
 * follows the description in col2-col17
 * @param {*} sph - spreasheet object 
 * @param {string} sheet_name - the name of current spreadsheet 
 */
function excel2bootstrapvue(sph, sheet_name) {
    /**
     * the structure that we will build is an Object that has a collection of Objects representing each Criterion
     * each Criterion has a couple of properties as defined in cols and a collection of Objects representing the components
     * each component has a couple of properties as defined in cols and a collection  of Objects represting the inner components
     * this will be until we reach the leaf level - the one line tags
     * the leaf has a couple of properties as defined in cols
     * each component is numbered sequentially and it corresponds to the order of appearance inside a Criterion
     */

    var xlData = XLSX.utils.sheet_to_json(sph)

    let c_obj = {}, c_type = (sheet_name.startsWith('EG') ? 'EG' : (sheet_name.startsWith('SC') ? 'SC' : 'OT')), element_map = []
    //reset the level counter
    for (const key in counter) {
        if (Object.hasOwn(counter, key)) {
            counter[key] = 0
        }
    }

    xlData.forEach(element => {

        //Detect the column for each label
        for (const key in cols) {
            let lbl = cols[key].label
            if (Object.values(element).indexOf(lbl) != -1) {
                cols[key].column = Object.keys(element)[Object.values(element).indexOf(lbl)]
            }
        }

        //get the tag
        let col_idx = 1, tag = '', tmp_elm = {}, parent = {}

        do {
            //no entry
            if (!Object.hasOwn(element, col_idx)) {
                col_idx++
                continue
            }
            //empty entry
            if (element[col_idx].toString().trim().length == 0) {
                col_idx++
                continue
            }
            let elm = element[col_idx].toString().trim(), tag = elm.replace('{', '').replace('}', '')
            //start tag
            if (elm.startsWith('{') && !elm.endsWith('}')) {
                //log(tag)
                switch (tag) {
                    case 'CRITERION':
                        c_obj.tag = `C${element[col_idx - 1]} - ${c_type}`
                        c_obj.type = tag
                        for (const key in cols) {
                            let clm = cols[key].column
                            if (clm > 0 && Object.hasOwn(element, clm) && element[clm].toString().trim().length > 0) {
                                c_obj[key] = element[clm].toString().trim()
                            }
                        }
                        c_obj.components = {}
                        break;

                    case 'SUBCRITERION': case 'REQUIREMENT_GROUP':
                    case 'QUESTION_GROUP': case 'QUESTION_SUBGROUP':
                    case 'REQUIREMENT_SUBGROUP':

                        if (!Object.hasOwn(c_obj, 'components')) c_obj.components = {}
                        parent = c_obj.components
                        if (element_map.length > 0) {
                            parent = element_map.reduce((acc, crtVal) => {
                                if (!Object.hasOwn(acc[crtVal], 'components')) acc[crtVal].components = {}
                                return acc[crtVal].components
                            }, parent)
                        }
                        counter[tag_map[tag]]++

                        tmp_elm = {}
                        tmp_elm.type = tag
                        for (const key in cols) {
                            let clm = cols[key].column
                            if (clm > 0 && Object.hasOwn(element, clm) && element[clm].toString().trim().length > 0) {
                                tmp_elm[key] = element[clm].toString().trim()
                            }
                        }
                        if (!Object.hasOwn(tmp_elm, 'cardinality')) tmp_elm['cardinality'] = '1'
                        //skip multiple occurences, keep only the 1st occurence
                        tmp_elm['cardinality'] = tmp_elm['cardinality'].replace('(1)', '').trim()
                        if (tmp_elm['cardinality'].indexOf('(') != -1) break

                        tmp_elm.components = {}
                        parent[`${tag_map[tag]}${counter[tag_map[tag]]}`] = tmp_elm
                        element_map.push(`${tag_map[tag]}${counter[tag_map[tag]]}`)

                        break;

                    default:
                        break;
                }
                break
            }

            //one line tag
            if (elm.startsWith('{') && elm.endsWith('}')) {
                //log(tag)
                switch (tag) {
                    case 'ADDITIONAL_DESCRIPTION_LINE': case 'LEGISLATION':
                    case 'CAPTION': case 'QUESTION': case 'REQUIREMENT':

                        if (!Object.hasOwn(c_obj, 'components')) c_obj.components = {}
                        parent = c_obj.components
                        if (element_map.length > 0) {
                            parent = element_map.reduce((acc, crtVal) => {
                                if (!Object.hasOwn(acc[crtVal], 'components')) acc[crtVal].components = {}
                                return acc[crtVal].components
                            }, parent)
                        }
                        counter[tag_map[tag]]++

                        tmp_elm = {}
                        tmp_elm.type = tag
                        for (const key in cols) {
                            let clm = cols[key].column
                            if (clm > 0 && Object.hasOwn(element, clm) && element[clm].toString().trim().length > 0) {
                                tmp_elm[key] = element[clm].toString().trim()
                            }
                        }
                        if (!Object.hasOwn(tmp_elm, 'cardinality')) tmp_elm['cardinality'] = '1'
                        //skip multiple occurences, keep only the 1st occurence
                        tmp_elm['cardinality'] = tmp_elm['cardinality'].replace('(1)', '').trim()
                        if (tmp_elm['cardinality'].indexOf('(') != -1) break

                        parent[`${tag_map[tag]}${counter[tag_map[tag]]}`] = tmp_elm
                        break;


                    default:
                        break;
                }
                break
            }

            //end tag
            if (!elm.startsWith('{') && elm.endsWith('}')) {
                //log(tag)
                switch (tag) {
                    case 'CRITERION':
                        //log(c_obj)
                        espd_json[c_obj.tag.substring(0, c_obj.tag.indexOf('-') - 1)] = c_obj
                        c_obj = {}
                        //reset the level counter
                        for (const key in counter) {
                            if (Object.hasOwn(counter, key)) {
                                counter[key] = 0
                            }
                        }
                        break;
                    case 'SUBCRITERION': case 'REQUIREMENT_GROUP':
                    case 'QUESTION_GROUP': case 'QUESTION_SUBGROUP':
                    case 'REQUIREMENT_SUBGROUP':
                        //counter[tag_map[tag]]--
                        element_map.pop()
                        break;
                    default:
                        break;
                }
                break
            }
            //some other text or empty line
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
 * Auxiliary function to transform espd_json to VueJS component for view
 * JSON to BootstrapVue for ESPD v4.0.0
 * @param {*} fragment - JSON Object to be processed
 * @param {*} result - JSON Object to carry information from one call to another
 */
function JSON2Vue(fragment,
    result = {
        sel_count: 0,
        template: ''
    }) {

    const options = [
        { text: 'Yes', value: 'yes' },
        { text: 'No', value: 'no' }
    ]

    var last_sel_count = 0

    for (const el in fragment) {
        if (Object.hasOwn(fragment, el)) {
            switch (fragment[el].type) {
                case 'CRITERION':
                    last_sel_count = Math.min(last_sel_count, result.sel_count)
                    //log(last_sel_count)
                    result.template =
                        `<div>
                        <b-card title="${fragment[el].tag} - ${fragment[el].name}">
                            <b-card-text>${fragment[el].description}</b-card-text>
                        `
                    if (Object.hasOwn(fragment[el], 'components')) result = JSON2Vue(fragment[el].components, result)
                    result.template += `</b-card>
                    </div>`
                    //Produce Vue component
                    let data_part = {}
                    //data_part.options = options
                    for (const key in result) {
                        if (Object.hasOwn(result, key)) {
                            if (key != 'template' && key != 'sel_count')
                                if (key.startsWith('selected')) {
                                    if (Number.parseInt(key.substring(8)) > last_sel_count) data_part[key] = result[key]
                                } else {
                                    data_part[key] = result[key]
                                }
                        }
                    }
                    //log('\n\n/**')
                    //log(` * Component - ${fragment[el].tag} - ${fragment[el].name}`)
                    //log(' */')
                    //log(`Vue.component("${fragment[el].tag}",
                    //{ 
                    //    data(){
                    //        return ${JSON.stringify(data_part, null, ' ')}
                    //    },
                    //    template: \`${result.template}\`
                    //})`)
                    //log(result.template)

                    last_sel_count = Math.max(last_sel_count, result.sel_count)

                    vue_stream.write('\n\n/**\n')
                    vue_stream.write(` * Component - ${fragment[el].tag} - ${fragment[el].name}\n`)
                    vue_stream.write(' */\n')
                    vue_stream.write(`Vue.component("${fragment[el].tag}",
                    { 
                        data(){
                            return ${JSON.stringify(data_part, null, ' ')}
                        },
                        template: \`${result.template}\`
                    })`)

                    break;

                case 'SUBCRITERION': case 'REQUIREMENT_GROUP': case 'REQUIREMENT_SUBGROUP':
                    result.template += `<b-card>`
                    if (Object.hasOwn(fragment[el], 'name') && Object.hasOwn(fragment[el], 'description')) result.template += `<p>${fragment[el].name} <em>${fragment[el].description}</em> [<em>${fragment[el].cardinality ?? '1'}</em>]</p>`
                    if (Object.hasOwn(fragment[el], 'components')) result = JSON2Vue(fragment[el].components, result)
                    result.template += `</b-card>`
                    break;

                case 'QUESTION_GROUP':
                    let local_indicator = ''
                    result.template += `
                    <b-card class="my-1"> <p>Cardinality [<em>${fragment[el].cardinality ?? '1'}</em>]</p>`
                    if (Object.hasOwn(fragment[el], 'components')) {
                        for (const e in fragment[el].components) {
                            if (Object.hasOwn(fragment[el].components, e)) {
                                let tmp_cmp = fragment[el].components[e]
                                if (tmp_cmp.type == 'QUESTION') {
                                    if (tmp_cmp.propertydatatype == 'INDICATOR') {
                                        //log(e, '\t', tmp_cmp.propertydatatype)
                                        result.sel_count++
                                        local_indicator = (result.sel_count + '').padStart(2, '0')
                                        result.template += `
                                        <!--
                                        <b-form-group label="${tmp_cmp.type} - ${tmp_cmp.description} [${tmp_cmp.cardinality ?? '1'}]">
                                            <b-form-radio-group id="radio-group-${local_indicator}" v-model="selected${local_indicator}" :options="options" name="radio-options${local_indicator}">
                                            </b-form-radio-group>
                                        </b-form-group>
                                        -->
                                        <b-form-group> 
                                        ${tmp_cmp.type} ${tmp_cmp.description} [${tmp_cmp.cardinality ?? '1'}] <b-form-checkbox id="radio-group-${local_indicator}" v-model="selected${local_indicator}" name="radio-options${local_indicator}" inline="true"  switch><b>({{ selected${local_indicator}?'Yes':'No' }})</b></b-form-checkbox>
                                        </b-form-group>`
                                        result[`selected${local_indicator}`] = true
                                    } else {
                                        result.template += `
                                        <b-form-group label="${tmp_cmp.type} - ${tmp_cmp.description} [${tmp_cmp.cardinality ?? '1'}]" 
                                        label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                        <b-form-input placeholder="${tmp_cmp.propertydatatype}"></b-form-input>
                                        </b-form-group>`
                                    }
                                }

                                if (['QUESTION_GROUP', 'QUESTION_SUBGROUP'].indexOf(tmp_cmp.type) != -1) {
                                    if (['ONTRUE', 'ONFALSE'].indexOf(tmp_cmp.elementcode) != -1) {
                                        let choice = tmp_cmp.elementcode == 'ONTRUE'
                                        result.template += `
                                    <div v-if="${choice ? '' : '!'}selected${local_indicator}">
                                    <b-card class="my-1"> <p>Cardinality [<em>${tmp_cmp.cardinality ?? '1'}</em>]</p>`
                                        //if (Object.hasOwn(tmp_cmp, 'components')) result = JSON2Vue(tmp_cmp.components, result)
                                        result = JSON2Vue({ e: tmp_cmp }, result)
                                        result.template += `
                                    </b-card>
                                    </div>`
                                    }
                                    if (tmp_cmp.elementcode == 'ON*') {
                                        result.template += `<b-card class="my-1"> <p>Cardinality [<em>${tmp_cmp.cardinality ?? '1'}</em>]</p>`
                                        result = JSON2Vue({ e: tmp_cmp }, result)
                                        result.template += '</b-card>'
                                    }
                                }

                                if (tmp_cmp.type == 'CAPTION') {
                                    result.template += `<b-card-text>${tmp_cmp.type} - ${tmp_cmp.description}</b-card-text>`
                                }

                                if (tmp_cmp.type == 'LEGISLATION') {
                                    result.template += `<b-card-text class="my-1">LEGISLATION [<em>${tmp_cmp.cardinality}</em>]</b-card-text>`
                                }
                            }
                        }
                    }
                    result.template += `
                    </b-card>`
                    break;

                case 'QUESTION_SUBGROUP':
                    let local_indicator_qsg = ''
                    if (Object.hasOwn(fragment[el], 'components')) {
                        for (const e in fragment[el].components) {
                            if (Object.hasOwn(fragment[el].components, e)) {
                                let tmp_cmp = fragment[el].components[e]
                                if (tmp_cmp.type == 'QUESTION') {
                                    if (tmp_cmp.propertydatatype == 'INDICATOR') {
                                        //log(e, '\t', tmp_cmp.propertydatatype)
                                        result.sel_count++
                                        local_indicator_qsg = (result.sel_count + '').padStart(2, '0')
                                        result.template += `
                                        <!--    
                                        <b-form-group label="${tmp_cmp.type} - ${tmp_cmp.description} [${tmp_cmp.cardinality ?? '1'}]">
                                                <b-form-radio-group id="radio-group-${local_indicator_qsg}" v-model="selected${local_indicator_qsg}" :options="options" name="radio-options${local_indicator_qsg}">
                                                </b-form-radio-group>
                                            </b-form-group>
                                            -->
                                            <b-form-group>
                                        ${tmp_cmp.type} ${tmp_cmp.description} [${tmp_cmp.cardinality ?? '1'}] <b-form-checkbox id="radio-group-${local_indicator_qsg}" v-model="selected${local_indicator_qsg}" name="radio-options${local_indicator_qsg}" inline="true"  switch><b>({{ selected${local_indicator_qsg}?'Yes':'No' }})</b></b-form-checkbox>
                                        </b-form-group>`
                                        result[`selected${local_indicator_qsg}`] = true
                                    } else {
                                        result.template += `
                                            <b-form-group label="${tmp_cmp.type} - ${tmp_cmp.description} [${tmp_cmp.cardinality ?? '1'}]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="${tmp_cmp.propertydatatype}"></b-form-input>
                                            </b-form-group>`
                                    }
                                }

                                if (['QUESTION_GROUP', 'QUESTION_SUBGROUP'].indexOf(tmp_cmp.type) != -1) {
                                    if (['ONTRUE', 'ONFALSE'].indexOf(tmp_cmp.elementcode) != -1) {
                                        let choice = tmp_cmp.elementcode == 'ONTRUE'
                                        result.template += `
                                        <div v-if="${choice ? '' : '!'}selected${local_indicator_qsg}">
                                        <b-card class="my-1"> <p>Cardinality [<em>${tmp_cmp.cardinality ?? '1'}</em>]</p>`
                                        //if (Object.hasOwn(tmp_cmp, 'components')) result = JSON2Vue(tmp_cmp.components, result)
                                        result = JSON2Vue({ e: tmp_cmp }, result)
                                        result.template += `
                                        </b-card>
                                        </div>`
                                    }
                                    if (tmp_cmp.elementcode == 'ON*') {
                                        result.template += `<b-card class="my-1"> <p>Cardinality [<em>${tmp_cmp.cardinality ?? '1'}</em>]</p>`
                                        result = JSON2Vue({ e: tmp_cmp }, result)
                                        result.template += '</b-card>'
                                    }
                                }

                                if (tmp_cmp.type == 'CAPTION') {
                                    result.template += `<b-card-text>${tmp_cmp.type} - ${tmp_cmp.description}</b-card-text>`
                                }

                                if (tmp_cmp.type == 'LEGISLATION') {
                                    result.template += `<b-card-text class="my-1">LEGISLATION [<em>${tmp_cmp.cardinality}</em>]</b-card-text>`
                                }
                            }
                        }
                    }
                    break;

                case 'QUESTION':
                    if (fragment[el].propertydatatype != 'INDICATOR') {
                        result.template += `
                        <b-form-group label="${fragment[el].type} - ${fragment[el].description} [${fragment[el].cardinality ?? '1'}]" 
                        label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                        <b-form-input placeholder="${fragment[el].propertydatatype}"></b-form-input>
                        </b-form-group>`
                    } else {
                        result.sel_count++
                        let local_indicator = `${result.sel_count}`.padStart(2, '0')
                        result.template += `
                        <!--
                        <b-form-group label="${fragment[el].type} - ${fragment[el].description} [${fragment[el].cardinality ?? '1'}]">
                            <b-form-radio-group id="radio-group-${local_indicator}" v-model="selected${local_indicator}" :options="options" name="radio-options${local_indicator}">
                            </b-form-radio-group>
                        </b-form-group>
                        -->
                        ${fragment[el].type}  ${fragment[el].description} [${fragment[el].cardinality ?? '1'}] <b-form-checkbox id="radio-group-${local_indicator}" v-model="selected${local_indicator}" name="radio-options${local_indicator}" inline="true" switch><b>({{ selected${local_indicator}?'Yes':'No' }})</b></b-form-checkbox>
                        `
                        result[`selected${local_indicator}`] = true
                    }
                    break;

                case 'LEGISLATION':
                    result.template += `<b-card-text class="my-1">LEGISLATION [<em>${fragment[el].cardinality}</em>]</b-card-text>`
                    break;

                case 'ADDITIONAL_DESCRIPTION_LINE': case 'CAPTION':
                    result.template += `<b-card-text>${fragment[el].type} - ${fragment[el].description}</b-card-text>`
                    break;

                case 'REQUIREMENT':
                    result.template += `
                    <b-form-group label="${fragment[el].type} - ${fragment[el].description} [${fragment[el].cardinality ?? '1'}]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="${fragment[el].propertydatatype}"></b-form-input>
                    </b-form-group>
                    `
                    break;

                default:
                    log('unknown element: ', fragment[el], '\t', fragment[el].type)
                    break;
            }

        }
    }

    return result
}

/**
 * Auxiliary function to transform espd_json to Vue components that can be used in ESPD Response
 * JSON to BootstrapVue for ESPD v4.0.0 tranformation
 * @param {*} fragment - JSON object to be processed
 * @param {*} result - JSON object to conserver the result
 */
function J2V4ESPD(fragment,
    result = {
        sel_count: 0,
        template: ''
    }) {

    var last_sel_count = 0

    for (const el in fragment) {
        if (Object.hasOwn(fragment, el)) {
            switch (fragment[el].type) {
                case 'CRITERION':
                    last_sel_count = Math.min(last_sel_count, result.sel_count)
                    //log(last_sel_count)
                    result.template =
                        `<div>
                        <strong>${fragment[el].name}</strong>
                        <p>${fragment[el].description}</p>
                        `
                    if (Object.hasOwn(fragment[el], 'components')) result = J2V4ESPD(fragment[el].components, result)
                    result.template += `
                    </div>`
                    //Produce Vue component
                    let data_part = {}
                    for (const key in result) {
                        if (Object.hasOwn(result, key)) {
                            if (key != 'template' && key != 'sel_count')
                                if (key.startsWith('selected')) {
                                    if (Number.parseInt(key.substring(8)) > last_sel_count) data_part[key] = result[key]
                                } else if (key.startsWith(fragment[el].responsepath)) {
                                    data_part[key] = result[key]
                                } else if(key.startsWith('opt_') || key.startsWith('val_')){
                                    data_part[key] = result [key]
                                }
                        }
                    }

                    //log('\n\n/**')
                    //log(` * Component - ${fragment[el].tag} - ${fragment[el].name}`)
                    //log(' */')
                    //log(`Vue.component("${el}",
                    //{ 
                    //    data(){
                    //        return ${JSON.stringify(data_part, null, ' ')}
                    //    },
                    //    template: \`${result.template}\`
                    //})`)

                    //log(result.template)

                    last_sel_count = Math.max(last_sel_count, result.sel_count)

                    vue_stream.write('\n\n/**\n')
                    vue_stream.write(` * Component - ${fragment[el].tag} - ${fragment[el].name}\n`)
                    vue_stream.write(' */\n')
                    vue_stream.write(`Vue.component("${name_version}-${el}",
                    { 
                        data(){
                            return ${JSON.stringify(data_part, null, ' ')}
                        },
                        template: \`${result.template}\`
                    })`)

                    break;

                case 'SUBCRITERION':
                    result.template += `<div>`
                    if (Object.hasOwn(fragment[el], 'components')) result = J2V4ESPD(fragment[el].components, result)
                    result.template += `</div>`
                    break;
                case 'REQUIREMENT_GROUP':
                    result[fragment[el].requestpath] = []
                    result.template += `<div>`

                    if (fragment[el].cardinality.toString().trim().endsWith('..n')) {
                        result.template += `<b-card footer-tag="footer">`
                    }

                    if (Object.hasOwn(fragment[el], 'components')) result = J2V4ESPD(fragment[el].components, result)

                    if (fragment[el].cardinality.toString().trim().endsWith('..n')) {
                        result.template += `<template #footer>
                    <b-button variant="success"><b-icon icon="plus-square-fill" aria-hidden="true"></b-icon></b-button>
                    </template>
                    </b-card>`
                    }
                    result.template += `</div>`

                    break;

                case 'REQUIREMENT_SUBGROUP':
                    result[fragment[el].requestpath] = []
                    result.template += `<div>`

                    if (fragment[el].cardinality.toString().trim().endsWith('..n')) {
                        result.template += `<b-card footer-tag="footer">`
                    }

                    let is_radio_group = false, select_variable = "", option_variable = ""
                    if (Object.hasOwn(fragment[el], 'components')) {
                        for (const e in fragment[el].components) {
                            if (Object.hasOwn(fragment[el].components, e)) {
                                const tmp_cmp = fragment[el].components[e]

                                //log(JSON.stringify(tmp_cmp, null, 2))

                                if (tmp_cmp.type == 'REQUIREMENT') {
                                    if (tmp_cmp.buyervalue == 'RADIO_BUTTON_TRUE') {
                                        //The list of values is in elementcode field
                                        //This is a list of exclusive values for a group or radio buttons
                                        result.sel_count++
                                        let local_indicator = (result.sel_count + '').padStart(2, '0')
                                        is_radio_group = true
                                        select_variable = `val_${tmp_cmp.responsepath.replaceAll("-","_").substring(0,tmp_cmp.responsepath.indexOf("/"))}`
                                        option_variable = `opt_${tmp_cmp.responsepath.replaceAll("-", "_").substring(0,tmp_cmp.responsepath.indexOf("/"))}`
                                        let tc = 0
                                        result[option_variable] = tmp_cmp.elementcode.replace("[", "").replace("]", "").split(",").map(x => { return { text: x.trim(), value: tc++ } })
                                        result[select_variable] = result[option_variable][0].value
                                        result.template += `<b-form-group label="${tmp_cmp.description}" v-slot="{ ariaDescribedby }">
                                    <b-form-radio-group
                                        id="radio-group-${local_indicator}"
                                        v-model="${select_variable}"
                                        :options="${option_variable}"
                                        :aria-describedby="ariaDescribedby"
                                        name="radio-options"
                                    ></b-form-radio-group>
                                    </b-form-group>
                                    `
                                    } else {
                                        //render normally this element
                                        result = J2V4ESPD({ e: tmp_cmp }, result)
                                    }
                                }else if (tmp_cmp.type == 'REQUIREMENT_SUBGROUP') {
                                    if (is_radio_group) {
                                        //The section is shown depending on the value in elementcode field
                                        result.template += `<template v-if="${select_variable}===${result[option_variable].find(ae => ae.text==tmp_cmp.elementcode).value}">`
                                        result = J2V4ESPD({ e: tmp_cmp }, result)
                                        result.template += `</template>`
                                    } else {
                                        //render normally this element
                                        result = J2V4ESPD({ e: tmp_cmp }, result)
                                    }
                                }else {
                                    //render normally this element
                                    result = J2V4ESPD({ e: tmp_cmp }, result)
                                }

                            }
                        }
                        //result = J2V4ESPD(fragment[el].components, result)
                    }

                    if (fragment[el].cardinality.toString().trim().endsWith('..n')) {
                        result.template += `<template #footer>
                        <b-button variant="success"><b-icon icon="plus-square-fill" aria-hidden="true"></b-icon></b-button>
                        </template>
                        </b-card>`
                    }
                    result.template += `</div>`

                    break;

                case 'QUESTION_GROUP':
                    let local_indicator = ''
                    result[fragment[el].responsepath] = []
                    result.template += `
                        <div>`
                    if (Object.hasOwn(fragment[el], 'components')) {
                        for (const e in fragment[el].components) {
                            if (Object.hasOwn(fragment[el].components, e)) {
                                let tmp_cmp = fragment[el].components[e]
                                if (tmp_cmp.type == 'QUESTION') {
                                    if (tmp_cmp.propertydatatype == 'INDICATOR') {
                                        //log(e, '\t', tmp_cmp.propertydatatype)
                                        result[tmp_cmp.responsepath] = false
                                        result.sel_count++
                                        local_indicator = (result.sel_count + '').padStart(2, '0')
                                        result.template += `
                                            <br/>${tmp_cmp.description} <b-form-checkbox v-model="selected${local_indicator}" name="check-button" inline="true" switch>
                                                     <b>[{{ selected${local_indicator}?'Yes':'No' }}]</b>
                                            </b-form-checkbox>
                                            `
                                        result[`selected${local_indicator}`] = false
                                    } else {
                                        result[tmp_cmp.responsepath] = ''
                                        result.template += `
                                            <b-form-group label="${tmp_cmp.description}" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="${tmp_cmp.propertydatatype}"></b-form-input>
                                            </b-form-group>`
                                    }
                                }

                                if (['QUESTION_GROUP', 'QUESTION_SUBGROUP'].indexOf(tmp_cmp.type) != -1) {
                                    if (['ONTRUE', 'ONFALSE'].indexOf(tmp_cmp.elementcode) != -1) {
                                        result.template += `
                                        <div v-if="${tmp_cmp.elementcode == 'ONTRUE' ? '' : '!'}selected${local_indicator}">
                                        `
                                        //if (Object.hasOwn(tmp_cmp, 'components')) result = J2V4ESPD(tmp_cmp.components, result)
                                        result = J2V4ESPD({ e: tmp_cmp }, result)
                                        result.template += `
                                        </div>`
                                    }
                                    if (tmp_cmp.elementcode == 'ON*') {
                                        result.template += `<div>`
                                        //if (Object.hasOwn(tmp_cmp, 'components')) result = J2V4ESPD(tmp_cmp.components, result)
                                        result = J2V4ESPD({ e: tmp_cmp }, result)
                                        result.template += '</div>'
                                    }
                                }

                                if (tmp_cmp.type == 'CAPTION') {
                                    result.template += `<em>${tmp_cmp.description}</em>`
                                }

                                if (tmp_cmp.type == 'LEGISLATION') {
                                    result.template += `<em>LEGISLATION</em>`
                                }
                            }
                        }
                    }
                    result.template += `
                        </div>`
                    break;

                case 'QUESTION_SUBGROUP':
                    let local_indicator_qsg = ''
                    result[fragment[el].responsepath] = []

                    if (Object.hasOwn(fragment[el], 'components')) {
                        for (const e in fragment[el].components) {
                            if (Object.hasOwn(fragment[el].components, e)) {
                                let tmp_cmp = fragment[el].components[e]
                                if (tmp_cmp.type == 'QUESTION') {
                                    if (tmp_cmp.propertydatatype == 'INDICATOR') {
                                        //log(e, '\t', tmp_cmp.propertydatatype)
                                        result[tmp_cmp.responsepath] = false
                                        result.sel_count++
                                        local_indicator_qsg = (result.sel_count + '').padStart(2, '0')
                                        result.template += `
                                            <br/>${tmp_cmp.description} <b-form-checkbox v-model="selected${local_indicator_qsg}" name="check-button" inline="true" switch>
                                                     <b>[{{ selected${local_indicator_qsg}?'Yes':'No' }}]</b>
                                            </b-form-checkbox>
                                            `
                                        result[`selected${local_indicator_qsg}`] = false
                                    } else {
                                        result[tmp_cmp.responsepath] = ''
                                        result.template += `
                                            <b-form-group label="${tmp_cmp.description}" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="${tmp_cmp.propertydatatype}"></b-form-input>
                                            </b-form-group>`
                                    }
                                }

                                if (['QUESTION_GROUP', 'QUESTION_SUBGROUP'].indexOf(tmp_cmp.type) != -1) {
                                    if (['ONTRUE', 'ONFALSE'].indexOf(tmp_cmp.elementcode) != -1) {
                                        result.template += `
                                        <div v-if="${tmp_cmp.elementcode == 'ONTRUE' ? '' : '!'}selected${local_indicator_qsg}">
                                        `
                                        //if (Object.hasOwn(tmp_cmp, 'components')) result = J2V4ESPD(tmp_cmp.components, result)
                                        result = J2V4ESPD({ e: tmp_cmp }, result)
                                        result.template += `
                                        </div>`
                                    }
                                    if (tmp_cmp.elementcode == 'ON*') {
                                        result.template += `<div>`
                                        //if (Object.hasOwn(tmp_cmp, 'components')) result = J2V4ESPD(tmp_cmp.components, result)
                                        result = J2V4ESPD({ e: tmp_cmp }, result)
                                        result.template += '</div>'
                                    }
                                }

                                if (tmp_cmp.type == 'CAPTION') {
                                    result.template += `<em>${tmp_cmp.description}</em>`
                                }

                                if (tmp_cmp.type == 'LEGISLATION') {
                                    result.template += `<em>LEGISLATION</em>`
                                }
                            }
                        }
                    }
                    break;

                case 'QUESTION':
                    if (fragment[el].propertydatatype != 'INDICATOR') {
                        result[fragment[el].responsepath] = true
                        result.template += `
                        <b-form-group label="${fragment[el].description}" 
                        label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                        <b-form-input placeholder="${fragment[el].propertydatatype}"></b-form-input>
                        </b-form-group>`
                    } else {
                        //This should be rendered inside the QG/QSG
                        result[fragment[el].responsepath] = ''
                        result.sel_count++
                        let local_indicator = `${result.sel_count}`.padStart(2, '0')
                        result.template += `
                        ${fragment[el].description} <b-form-checkbox v-model="selected${local_indicator}" name="check-button" inline="true" switch>
                        <b>[{{ selected${local_indicator}?'Yes':'No' }}]</b>
                        </b-form-checkbox>`
                        result[`selected${local_indicator}`] = false
                    }
                    break;

                case 'LEGISLATION':
                    result.template += `<em>LEGISLATION</em>`
                    break;

                case 'ADDITIONAL_DESCRIPTION_LINE': case 'CAPTION':
                    result.template += `<em>${fragment[el].description}</em>`
                    break;

                case 'REQUIREMENT':
                    result[fragment[el].responsepath] = ''
                    result.template += `
                    <b-form-group label="${fragment[el].description}"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="${fragment[el].propertydatatype}"></b-form-input>
                    </b-form-group>
                    `
                    break;

                default:
                    log('unknown element: ', fragment[el], '\t', fragment[el].type)
                    break;
            }

        }
    }

    return result
}

/**
 * Transform the Excel structure to PlantUML Salt
 * @param {Object} sph - spreadsheet Object
 */
function excel2salt(sph) {

    var xlData = XLSX.utils.sheet_to_json(sph)

    let cols = {
        cardinality: {
            label: "Cardinality",
            column: 1
        },
        elementcode: {
            label: "Element Code",
            column: 1
        },
        name: {
            label: "Name",
            column: 1
        },
        description: {
            label: "Description",
            column: 1
        },
        buyervalue: {
            label: "Buyer Value (example)",
            column: 1
        },
        propertydatatype: {
            label: "PropertyDataType",
            column: 1
        }
    };

    xlData.forEach(element => {

        //log(element)
        for (const key in cols) {
            let lbl = cols[key].label
            if (Object.values(element).indexOf(lbl) != -1) {
                cols[key].column = Object.keys(element)[Object.values(element).indexOf(lbl)]
                //log(cols[key].label, cols[key].label)
            }
        }

        //get the tag
        let col_idx = 1
        let tag = ''

        do {
            //no entry
            if (!Object.hasOwn(element, col_idx)) {
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
                tag = element[col_idx].trim()
                switch (tag) {
                    case '{CRITERION':
                        log("@startsalt")
                        log('{+\n', element[col_idx - 1],
                            element[cols.name.column], " - ",
                            element[cols.description.column].length > 60 ? element[cols.description.column].substring(0, 56) + '...' : element[cols.description.column])
                        break;
                    case '{SUBCRITERION': case "{QUESTION_GROUP": case "{REQUIREMENT_GROUP": case "{QUESTION_SUBGROUP": case "{REQUIREMENT_SUBGROUP":

                        log('{^ "', element[col_idx - 1],
                            element[cols.name.column] ? element[cols.name.column] : '',
                            element[cols.description.column] ? element[cols.description.column] : '',
                            element[cols.elementcode.column] ? (element[cols.elementcode.column] == 'ONTRUE') ? 'YES' : ((element[cols.elementcode.column] == 'ONFALSE') ? 'NO' : '') : '',
                            '"')
                        log('.')
                        break;
                    case "CRITERION}":
                        log('}')
                        log("@endsalt")
                        break;
                    case 'SUBCRITERION}': case "QUESTION_GROUP}": case "REQUIREMENT_GROUP}": case "QUESTION_SUBGROUP}": case "REQUIREMENT_SUBGROUP}":
                        log('} | *')
                        break;
                    case "{LEGISLATION}":
                        log(element[col_idx - 1])
                        //log(''.padStart(col_idx - 1, '+'),`${element[col_idx-1]} | .`)
                        break;
                    case "{ADDITIONAL_DESCRIPTION_LINE}": case "{CAPTION}": case "{QUESTION}": case "{REQUIREMENT}":
                        if (element[cols.propertydatatype.column] == 'INDICATOR') {
                            log(`${element[col_idx - 1]}  ${element[cols.description.column]} | { () Yes | () No}`)
                        } else {
                            log(element[col_idx - 1], element[cols.description.column], ' | " ', element[cols.propertydatatype.column], ' "')
                        }
                        break;
                    default:
                        log(tag, ' UNKNOWN')
                        break;
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
 * Transform the Excel structure to PlantUML diagram
 * we map all to a tree and display the Description where applicable
 * @param {Object} sph - spredsheet Object
 */
function excel2treetable(sph) {
    log("@startsalt\n{")
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
            if (!Object.hasOwn(element, col_idx)) {
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
                tag = element[col_idx].trim()
                switch (tag) {
                    case '{CRITERION':
                        log(`== ${element[18]}\n{T-`)
                        log(''.padStart(col_idx - 1, '+'), `${element[col_idx - 1]} | ${element[19].length > 60 ? element[19].substring(0, 56) + '...' : element[19]}`)
                        break;
                    case '{SUBCRITERION': case "{QUESTION_GROUP": case "{REQUIREMENT_GROUP": case "{QUESTION_SUBGROUP": case "{REQUIREMENT_SUBGROUP":
                        log(''.padStart(col_idx - 1, '+'), `${element[col_idx - 1]} | ${element[19] ? element[19] : '.'}`)
                        break;
                    case "CRITERION}":
                        log('}\n==\n')
                        break;
                    case 'SUBCRITERION}': case "QUESTION_GROUP}": case "REQUIREMENT_GROUP}": case "QUESTION_SUBGROUP}": case "REQUIREMENT_SUBGROUP}":
                        break;
                    case "{LEGISLATION}":
                        log(''.padStart(col_idx - 1, '+'), `${element[col_idx - 1]} | ${element[19] ? element[19] : '.'}`)
                        break;
                    case "{ADDITIONAL_DESCRIPTION_LINE}": case "{CAPTION}": case "{QUESTION}": case "{REQUIREMENT}":
                        log(''.padStart(col_idx - 1, '+'), `${element[col_idx - 1]} | ${element[19]}`)
                        break;
                    default:
                        log(''.padStart(col_idx - 1, '+'), tag, 'UNKNOWN')
                        break;
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
    log("}\n@endsalt")
}

