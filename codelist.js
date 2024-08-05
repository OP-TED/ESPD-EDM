#!/usr/bin/env node

/*
 *
 * NodeJS application to check UUID duplicated in Excel for ESPD v3.3.0
 * 
 */

var XLSX = require("xlsx")
var chalk = require('chalk');
var fs = require("fs")
const { readFileSync } = require('fs');

const { program } = require("@caporal/core");
const path = require("path");
const { type } = require("os");

const in_excel_we_trust = [
    "ESPD-CodeLists_v3.0.0.xlsx",
    "ESPD-CodeLists_v3.0.1.xlsx",
    "ESPD-CodeLists_v3.1.0.xlsx",
    "ESPD-CodeLists_v3.2.0.xlsx",
    "ESPD-CodeLists_v3.3.0.xlsx",
]

const log = console.log, ESPD_version = 'ESPD release v3.X', path_to_folder = '.\\ESPD\\codelists\\';
XLSX.set_fs(fs);

let name_version = '', json_ui = {}, json_external = [];

var clJSON = require('./ESPD/codelists/codelist.json')
//download all codelists some are from Github some are form EU Vocabulary
var extclJSON = require('./ESPD/codelists/external_code_list.json')

var extModel = require('./ESPD/model/model.json')

program
    .version("1.0.0")
    .name("codelist")
    .description("Tool to handle Code List Excel files")

    .command("all_JSON", "Print all spreadsheets as JSON")
    .action(({ logger, args, options }) => {
        // Combine styled and normal strings
        log(chalk.blue.bold('Dump code list'), chalk.red(ESPD_version));
        log('\n\n')

        in_excel_we_trust.forEach(xcl => {
            var wbk = XLSX.readFile(`${path_to_folder}${xcl}`)
            log(chalk.bold(xcl))

            var sheet_name_list = wbk.SheetNames;

            for (const i in sheet_name_list) {
                log(''.padStart(80, '_'))
                log(chalk.bold(sheet_name_list[i]))
                print_all(wbk.Sheets[sheet_name_list[i]])
                log('\n\n')
            }
        })

    })

    .command("process_code_lists", "Process Code Lists")
    .action(({ logger, args, options }) => {
        // Combine styled and normal strings
        log(chalk.blue.bold('Process code list'), chalk.red(ESPD_version));
        log('\n')

        in_excel_we_trust.forEach(xcl => {
            var wbk = XLSX.readFile(`${path_to_folder}${xcl}`)
            log(chalk.bold(xcl))

            name_version = xcl.substring(xcl.indexOf('_v') + 1, xcl.length - ".xlsx".length)
            log(name_version)

            json_ui[name_version] = []

            //check if version folder exists and start with a clean one
            if (fs.existsSync(`${path_to_folder}${name_version}`)) {
                // cleanup
                fs.rmSync(`${path_to_folder}${name_version}`, { recursive: true, force: true })
                fs.mkdirSync(`${path_to_folder}${name_version}`, { recursive: true }, (err) => {
                    log(err)
                })

            } else {
                fs.mkdirSync(`${path_to_folder}${name_version}`, { recursive: true }, (err) => {
                    log(err)
                })
            }

            var sheet_name_list = wbk.SheetNames;

            for (const i in sheet_name_list) {
                log(''.padStart(80, '_'))
                log(chalk.bold(sheet_name_list[i]))

                process_code_lists(wbk.Sheets[sheet_name_list[i]])
                //log('\n')
            }

            //update external_code_list.json
            extclJSON = extclJSON.concat(json_external)
            
            let uniques = extclJSON.map(item => JSON.stringify(item))
                                   .filter((value, index, self) => self.indexOf(value) === index)
            //console.log(uniques)
            JSON2file('.\\ESPD\\codelists\\external_code_list.json', uniques.map(item => JSON.parse(item)))
            //update codelist.json
            clJSON.code_lists[name_version] = []
            clJSON.code_lists[name_version] = json_ui[name_version]
            JSON2file('.\\ESPD\\codelists\\codelist.json', clJSON)
        })

    })

    .command("process_model", "Process all models as options")
    .action(({logger, args, options}) => {
        log(chalk.blue.bold('Process all models as options'), chalk.red(ESPD_version));
        log('\n')

        let model_file = require('./ESPD/model/espd_edm_v3.3.0.json')
        if (! Object.hasOwn(extModel, 'models')) extModel.models = {}
        if (! Object.hasOwn(extModel.models, 'v3.3.0')) extModel.models['v3.3.0'] = []

        for (const key in model_file) {
            if (Object.hasOwn(model_file, key)) {
                extModel.models['v3.3.0'].push({ value: model_file[key].tag, text: `${model_file[key].tag} - ${model_file[key].name}` })
            }
        }
        log(extModel)
        JSON2file('.\\ESPD\\model\\model.json', extModel)
    })

// launch the main loop
program.run()


//process code lists and produce the json files
//fetch the external codelists
//add the structure to the UI list
function process_code_lists(sph) {
    //Converting Excel to JSON, each column of the row is mapped to a letter
    // A: [col1], B: [col2] ...
    var xlData = XLSX.utils.sheet_to_json(sph, { header: "A" })
    let json_structure = {}, IS_TABLE = false,
        table_labels = {
            A: 'Code',
            B: 'Name',
            C: 'Description',
            D: 'Status',
            E: 'bul',
            F: 'spa',
            G: 'ces',
            H: 'dan',
            I: 'deu',
            J: 'est',
            K: 'ell',
            L: 'eng',
            M: 'fra',
            N: 'gle',
            O: 'hrv',
            P: 'ita',
            Q: 'lav',
            R: 'lit',
            S: 'hun',
            T: 'mlt',
            U: 'nld',
            V: 'pol',
            W: 'por',
            X: 'ron',
            Y: 'slk',
            Z: 'slv',
            AA: 'fin',
            AB: 'swe'
        };

    xlData.forEach(element => {
        //build the JSON that will be saved in the folder
        if (!IS_TABLE) {
            switch (element.A) {
                case "ShortName": case "ListID": case "Version": case "LongName":
                case "CanonicalVersionUri": case "LocationUri": case "AgencyIdentifier":
                case "CanonicalUri": case "AgencyLongName":
                    json_structure[element.A] = element.B
                    break;
                case "Code":
                    //this is the table with technical list for definitions
                    json_structure.fields = {}
                    IS_TABLE = true
                    break;

                default:
                    log(element.A, ' ...unknown!')
                    break;
            }
        } else {
            //populate the fields object
            json_structure.fields[element.A] = {}
            for (const key in table_labels) {
                if (Object.hasOwnProperty.call(table_labels, key)) {
                    const label = table_labels[key]
                    json_structure.fields[element.A][label] = element[key] || ""
                }
            }
        }
    })

    json_structure.type = (json_structure.LocationUri.startsWith('https://github.com/ESPD/ESPD-EDM/')) ? 'technical' : 'external'
    json_structure.name = (json_structure.type == 'external') ? json_structure.LongName : json_structure.ListID

    //log(JSON.stringify(json_structure))
    //const filePath = `${path_to_folder}${name_version}\\${json_structure.name}\\${json_structure.name}.json`;
    //JSON2file(filePath, json_structure)

    //build the JSON that is used to fetch the remote files
    //fethc all files
    json_external.push({
        folder: `${name_version}`,
        filename: `${json_structure.ShortName}.gc`,
        uri: json_structure.LocationUri
    })

    //build the JSON that will be saved in the UI
    json_ui[name_version].push(json_structure.ShortName)

}


//dump Excel to JSON
function print_all(sph) {
    var xlData = XLSX.utils.sheet_to_json(sph, { header: "A" })
    log(xlData)
}

//auxiliary function to write a JSON to a file
function JSON2file(where, what) {
    //log(where)
    //log(JSON.stringify(what, null, 4))
    fs.writeFile(where, JSON.stringify(what, null, 4), (err) => {
        if (err) {
            log('Error writing to file:', err);
        } else {
            log(`JSON data written to ${where}`);
        }
    });
}