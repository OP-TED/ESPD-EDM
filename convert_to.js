#!/usr/bin/env node

/*
 * NodeJS application to convert Excel for ESPD Criterion to
 * various formats: 
 *   - BoostarpVueJs
 *   - Salt for PlantUML 
 *   - Dia for ???
 * 
 */


var XLSX = require("xlsx")
var chalk = require('chalk')
var fs = require("fs")
const { program } = require("@caporal/core")
const path = require("path")
const { readFileSync } = require('fs')


const { type } = require("os");
const { count } = require("console");

var {JSON2file} = require("./modules/espd_utils.cjs");
const {cols, tag_map} = require("./modules/espd_constants.cjs")

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

var vue_stream = null

const in_excel_we_trust = [
    //"ESPD-criterion-request-multiple-C25-C32.xlsx",
    "ESPD-criterion-response-multiple-C1-C25-C32.xlsx"
]

//Check the complete list of invalid CRITERION
const invalid_criterion = [33, 62, 64]

const log = console.log, ESDP_version = 'ESDP release v4.0.0'
XLSX.set_fs(fs)
var element_children = {}, UUID_list = {}, espd_json = {}, name_version = '';



program
    .version("1.0.0")
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
            fs.writeFileSync(`.\\espd_${name_version}.js`, `/**\n * VueJS components for ESDP-EDM \n * generated on ${(new Date(Date.now())).toISOString()} \n */\n\n`,
                (err) => {
                    if (err) {
                        log(err)
                    } else {
                        log('Vuefication 100%')
                    }
                })

            vue_stream = fs.createWriteStream(`.\\espd_${name_version}.js`, { flags: 'a' });
            JSON2Vue(espd_json)
            vue_stream.end()

            vue_stream = fs.createWriteStream(`.\\espd_response_${name_version}.js`, { flags: 'a' });
            J2V4ESPD(espd_json)
            vue_stream.end()

        })


    })

    .command("excel2bv", "Transform Excel to BootstrapVue UI mockups")
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
                excel2bv(wbk.Sheets[sheet_name_list[i]])
                log('\n\n')
            }
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

    .command("excel2dia", "Transform Excel to PlantUML diagrams")
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
                excel2diagram(wbk.Sheets[sheet_name_list[i]])
                log('\n\n')
            }
        })
    })

    // launch the main loop
program.run()


//detect and transform the structure from Excel to JSON
//then create for each Criteria a Vue component
//as described in col2-col17
/**
 * 
 * @param {spreadsheet object} sph 
 * @param {spreadsheet name} sheet_name 
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
            //start tag
            if (elm.startsWith('{') && !elm.endsWith('}')) {
                tag = elm.replace('{', '').replace('}', '')
                //log(tag)
                switch (tag) {
                    case 'CRITERION':
                        c_obj.tag = `C${element[col_idx - 1]} - ${c_type}`
                        c_obj.type = tag
                        for (const key in cols) {
                            let lbl = cols[key].label, clm = cols[key].column
                            if (clm > 0 && typeof element[clm] !== 'undefined' && element[clm].toString().trim().length > 0) {
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
                            let lbl = cols[key].label, clm = cols[key].column
                            if (clm > 0 && typeof element[clm] !== 'undefined' && element[clm].toString().trim().length > 0) {
                                tmp_elm[key] = element[clm].toString().trim()
                            }
                        }
                        if (!Object.hasOwn(tmp_elm, 'cardinality')) tmp_elm['cardinality'] = 1
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
                tag = elm.replace('{', '').replace('}', '')
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
                            let lbl = cols[key].label, clm = cols[key].column
                            if (clm > 0 && typeof element[clm] !== 'undefined' && element[clm].toString().trim().length > 0) {
                                tmp_elm[key] = element[clm].toString().trim()
                            }
                        }
                        if (!Object.hasOwn(tmp_elm, 'cardinality')) tmp_elm['cardinality'] = 1
                        parent[`${tag_map[tag]}${counter[tag_map[tag]]}`] = tmp_elm
                        break;


                    default:
                        break;
                }
                break
            }

            //end tag
            if (!elm.startsWith('{') && elm.endsWith('}')) {
                tag = elm.replace('{', '').replace('}', '')
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

//auxiliary function to transform espd_json to VueJS component
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
                    data_part.options = options
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
                                        <b-form-group label="${tmp_cmp.type} - ${tmp_cmp.description} [${tmp_cmp.cardinality ?? '1'}]">
                                            <b-form-radio-group id="radio-group-${local_indicator}" v-model="selected${local_indicator}" :options="options" name="radio-options${local_indicator}">
                                            </b-form-radio-group>
                                        </b-form-group>`
                                        result[`selected${local_indicator}`] = 'yes'
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
                                        let choice = tmp_cmp.elementcode == 'ONTRUE' ? 'yes' : 'no'
                                        result.template += `
                                    <div v-if="selected${local_indicator} ==='${choice}'">
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
                                            <b-form-group label="${tmp_cmp.type} - ${tmp_cmp.description} [${tmp_cmp.cardinality ?? '1'}]">
                                                <b-form-radio-group id="radio-group-${local_indicator_qsg}" v-model="selected${local_indicator_qsg}" :options="options" name="radio-options${local_indicator_qsg}">
                                                </b-form-radio-group>
                                            </b-form-group>`
                                        result[`selected${local_indicator_qsg}`] = 'yes'
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
                                        let choice = tmp_cmp.elementcode == 'ONTRUE' ? 'yes' : 'no'
                                        result.template += `
                                        <div v-if="selected${local_indicator_qsg} ==='${choice}'">
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
                        <b-form-group label="${fragment[el].type} - ${fragment[el].description} [${fragment[el].cardinality ?? '1'}]">
                            <b-form-radio-group id="radio-group-${local_indicator}" v-model="selected${local_indicator}" :options="options" name="radio-options${local_indicator}">
                            </b-form-radio-group>
                        </b-form-group>`
                        result[`selected${local_indicator}`] = 'yes'
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

//auxiliary function to transform espd_json to Vue components that can be used in ESPD Response
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
                                } else {
                                    data_part[key] = result[key]
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

                case 'SUBCRITERION': case 'REQUIREMENT_GROUP': case 'REQUIREMENT_SUBGROUP':
                    result.template += `<div>`
                    //TODO - handle cardinality - if ..n then allow to add multiple sections

                    if (Object.hasOwn(fragment[el], 'components')) result = J2V4ESPD(fragment[el].components, result)
                    result.template += `</div>`
                    break;

                case 'QUESTION_GROUP':
                    let local_indicator = ''
                    result.template += `
                        <div>`
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
                                            <br/>${tmp_cmp.description} <b-form-checkbox v-model="selected${local_indicator}" name="check-button" inline="true" switch>
                                                     <b>[{{ selected${local_indicator}?'Yes':'No' }}]</b>
                                            </b-form-checkbox>
                                            `
                                        result[`selected${local_indicator}`] = false
                                    } else {
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
                                            <br/>${tmp_cmp.description} <b-form-checkbox v-model="selected${local_indicator_qsg}" name="check-button" inline="true" switch>
                                                     <b>[{{ selected${local_indicator_qsg}?'Yes':'No' }}]</b>
                                            </b-form-checkbox>
                                            `
                                        result[`selected${local_indicator_qsg}`] = false
                                    } else {
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
                        result.template += `
                        <b-form-group label="${fragment[el].description}" 
                        label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                        <b-form-input placeholder="${fragment[el].propertydatatype}"></b-form-input>
                        </b-form-group>`
                    } else {
                        //This should be rendered inside the QG/QSG
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

//transform the Excel structure to BooststarpVue component
//TODO
function excel2bv(sph) {
    let template = "",
        js = {
            options: [
                { text: 'Yes', value: 'yes' },
                { text: 'No', value: 'no' }
            ]
        },
        qg_qsg_level = [],
        q_level_count = {},
        sel_count = 0;

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
        let col_idx = 1, tag = ''

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
                tag = element[col_idx].trim()
                switch (tag) {
                    case '{CRITERION':
                        template = `<div>
                          <b-card>
                            ${element[col_idx - 1]} - ${element[cols.name.column]}
                            <p>${element[cols.description.column]}</p>
                        `
                        break;
                    case '{SUBCRITERION': case "{REQUIREMENT_GROUP": case "{REQUIREMENT_SUBGROUP":
                        template += `
                            <b-card>
                         `
                        break;
                    case "{QUESTION_GROUP": case "{QUESTION_SUBGROUP":
                        if (element[cols.elementcode.column] == 'ONTRUE') {
                            template += `
                            <b-card>
                            <div v-if="selected${q_level_count[col_idx]} === 'yes'">
                            `
                            qg_qsg_level.unshift(col_idx)
                        } else if (element[cols.elementcode.column] == 'ONFALSE') {
                            template += `
                            <div v-if="selected${q_level_count[col_idx]} === 'no'">
                            `
                            qg_qsg_level.unshift(col_idx)
                        } else {
                            template += `
                            <b-card>
                            `
                        }
                        break;
                    case "CRITERION}":
                        template += `
                        </b-card>
                        </div>`
                        log(template)
                        log("\n{\n data() { \n return ", JSON.stringify(js), "\n} \n}")
                        break;
                    case 'SUBCRITERION}': case "REQUIREMENT_GROUP}": case "REQUIREMENT_SUBGROUP}":
                        template += '</b-card>'
                        break;
                    case "QUESTION_SUBGROUP}": case "QUESTION_GROUP}":
                        if (qg_qsg_level[0] == col_idx) {
                            template += `
                            </div>`
                            qg_qsg_level.shift()
                        } else {
                            template += `
                            </b-card>`
                        }
                        break;
                    case "{LEGISLATION}":
                        template += `
                        <p>${element[col_idx - 1]} - LEGISLATION</p>
                        `
                        break;
                    case "{ADDITIONAL_DESCRIPTION_LINE}": case "{CAPTION}": 
                        template += `
                        <p>${element[col_idx - 1]} - ${element[cols.description.column]} :: ${element[cols.propertydatatype.column]}</p>
                        
                        `
                        break;
                    case "{REQUIREMENT}":
                        template += `
                        <b-form-group label="${element[col_idx - 1]} - ${element[cols.description.column]}">
                        <b-form-input placeholder="${element[cols.propertydatatype.column]}"></b-form-input>
                        </b-form-group>
                        `
                        break;
                    case "{QUESTION}":
                        if (element[cols.propertydatatype.column] == 'INDICATOR') {
                            //It is a Yes/No option group
                            sel_count++
                            template += `
                            <b-form-group label="${element[col_idx - 1]} - ${element[cols.description.column]}">
                                <b-form-radio-group id="radio-group-${sel_count}" v-model="selected${sel_count}" :options="options" name="radio-options${sel_count}">
                                </b-form-radio-group>
                            </b-form-group>`
                            js[`selected${sel_count}`] = 'yes'
                            q_level_count[col_idx] = sel_count

                        } else {
                            template += `
                            <b-form-group label="${element[col_idx - 1]} - ${element[cols.description.column]}">
                            <b-form-input placeholder="${element[cols.propertydatatype.column]}"></b-form-input>
                            </b-form-group>
                            `
                        }
                        break;
                    default:
                        template += `${tag} UNKNOWN`
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
}



//transform the Excel structure to PlantUML Salt
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

//transform the Excel structure to PlantUML diagram
//we map all to a tree and display the Description where applicable
function excel2diagram(sph) {
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

