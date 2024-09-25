#!/usr/bin/env node

/*
 *
 * NodeJS application to process Code Lists Excel for ESPD v4.0.0
 *  
 *  - generate the technical Code Lists
 *  - download the EU Vocabularies Code Lists
 * 
 */

var XLSX = require("xlsx")
var chalk = require('chalk');
var fs = require("fs")
const { create } = require('xmlbuilder2')
const axios = require("axios")

const { program } = require("@caporal/core");

var in_excel_we_trust = [
    "ESPD-CodeLists.xlsx",
]

const log = console.log, 
      ESPD_version = 'ESPD release v4.0.0', 
      path_to_folder = '.\\cl\\gc\\';

XLSX.set_fs(fs);
var name_version = '4.0.0', 
    proxy_user = '', proxy_password = '', proxy_server = 'proxy-t2-lu.welcome.ec.europa.eu', proxy_port = '8012';

program
    .version("1.0.0")
    .name("codelist")
    .description("Tool to handle Code List Excel files")

    .command("process_code_lists", "Process Code Lists")
    .option('--user [user]', 'proxy server user', {default: ''})
    .option('--password [password]', 'proxy server password', {default: ''})
    .argument('<excelfile>', 'Excel Code List file to be processed')
    .action(({ args, options, logger }) => {
        log(options)
        proxy_user = options.user
        proxy_password = options.password
        // Combine styled and normal strings
        log(chalk.bold(`Processing ${args.excelfile}`), chalk.red(ESPD_version), '\n\n')
        in_excel_we_trust = [ args.excelfile ]
        
        in_excel_we_trust.forEach(xcl => {
            var wbk = XLSX.readFile(xcl)
            log(chalk.bold(xcl))

            //name_version = xcl.substring(xcl.indexOf('_v') + 1, xcl.length - ".xlsx".length)
            log(name_version)

            //check if version folder exists and start with a clean one
            if (fs.existsSync(`${path_to_folder}`)) {
                // cleanup
                fs.rmSync(`${path_to_folder}`, { recursive: true, force: true })
                fs.mkdirSync(`${path_to_folder}`, { recursive: true }, (err) => {
                    log(err)
                })
            } else {
                fs.mkdirSync(`${path_to_folder}`, { recursive: true }, (err) => {
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
            
        })

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

    json_structure.type = (json_structure.CanonicalUri.startsWith('https://github.com/')) ? 'technical' : 'external'
    json_structure.name = (json_structure.type == 'external') ? json_structure.LongName : json_structure.ListID

    //log(JSON.stringify(json_structure, null, 4))

    switch (json_structure.type) {
        case 'technical':
            //Create the Code List file in \codelists\gc
            var gc = create({
                version: '1.0',
                encoding: 'UTF-8'
            })
                .ele('gc\:CodeList')
                .att('@xmlns', 'xmlns:gc', 'http://docs.oasis-open.org/codelist/ns/genericode/1.0/')

                let tmp = gc.ele('Identification')
                .ele('ShortName').txt(json_structure['ShortName']).up()
                .ele('LongName').txt(json_structure['LongName']?json_structure['LongName']:json_structure['ShortName']).up()
                .ele('LongName', {'Identifier': 'listId'}).txt(json_structure['ListID']).up()
                .ele('Version').txt(json_structure['Version']).up()
                .ele('CanonicalUri').txt(json_structure['CanonicalUri']).up()
                .ele('CanonicalVersionUri').txt(json_structure['CanonicalVersionUri']).up()
                .ele('LocationUri').txt(json_structure['LocationUri']).up()

                if (json_structure['AgencyLongName']){
                    //Get the data from the structure
                    tmp.ele('Agency')
                    .ele('LongName').txt(json_structure['AgencyLongName']).up()
                    .ele('Identifier', {'Identifier': json_structure['AgencyIdentifier']}).up()
                    .up()
                }else{
                    //Fill in default data
                    tmp.ele('Agency')
                    .ele('ShortName').txt('Publications Office').up()
                    .ele('LongName').txt('Publications Office of the European Union').up()
                    .ele('Identifier', { 'Identifier':'TED-OP-ESPD' }).up()
                    .up()
                }
                tmp.up()

                //write the values
                tmp = gc.ele('ColumnSet')
                for(const elm in table_labels){
                    switch(table_labels[elm]){
                        case 'Code':
                            tmp.ele('Column', {'Id':'code', 'Use':'required'})
                            .ele('ShortName').txt('Code').up()
                            .ele('Data', { 'Type': 'normalizedString', 'Lang':'eng'}).up()
                            .up()
                            break;
                        case 'Name':
                            tmp.ele('Column', {'Id':'Name', 'Use':'optional'})
                            .ele('ShortName').txt('Name').up()
                            .ele('Data', { 'Type': 'string', 'Lang':'eng'}).up()
                            .up()
                            break;
                        case 'Description':
                            break;
                        case 'Status':
                            tmp.ele('Column', {'Id':'status', 'Use':'required'})
                            .ele('ShortName').txt('Status').up()
                            .ele('Data', { 'Type': 'normalizedString', 'Lang':'eng'}).up()
                            .up()
                            break;
                        default:
                            tmp.ele('Column', {'Id': `name-${table_labels[elm].toLowerCase()}`, 'Use': 'optional'})
                            .ele('ShortName').txt('Name').up()
                            .ele('Data', { 'Type': 'string', 'Lang':table_labels[elm].toLowerCase()}).up()
                            .up()
                    }
                }
                tmp.ele('Key', {'Id': 'codeKey'})
                .ele('ShortName').txt('CodeKey').up()
                .ele('ColumnRef', { 'Ref': 'code'}).up()
                .up()
                tmp.up()

                tmp = gc.ele('SimpleCodeList')
                for (const key in json_structure.fields) {
                    if (Object.hasOwn(json_structure.fields, key)) {
                        const element = json_structure.fields[key];
                        let tmp1 = tmp.ele('Row')
                        for (const elm in table_labels){
                            switch (table_labels[elm]) {
                                case 'Description':
                                    break;
                                case 'Name':
                                    tmp1.ele('Value', { 'ColumnRef': 'Name'})
                                    .ele('SimpleValue').txt(element[table_labels[elm]]).up()
                                    .up()
                                    break;
                                case 'Code': case 'Status':
                                    tmp1.ele('Value', { 'ColumnRef': table_labels[elm].toLowerCase()})
                                    .ele('SimpleValue').txt(element[table_labels[elm]]).up()
                                    .up()
                                    break;
                            
                                default:
                                    if(element[table_labels[elm]]){
                                        tmp1.ele('Value', { 'ColumnRef':`name-${table_labels[elm].toLowerCase()}`})
                                        .ele('SimpleValue').txt(element[table_labels[elm]]).up()
                                        .up()
                                    }
                                    break;
                            }
                        }
                        tmp1.up()
                    }
                }
                tmp.up()

                tmp.up()
            writeXMLfiles(gc, `${json_structure.ShortName}.gc`)
            break;
        case 'external':
            //Download the Code List from external site to \codelist\gc
            log(`Download file ${json_structure.CanonicalVersionUri}`)

            axios.get(json_structure.LocationUri, {
                proxy: {
                    protocol: "http",           
                    host: proxy_server,
                    port: proxy_port,
                    auth: { username: proxy_user, password: proxy_password }
                }
            })
            .then((result) => {
                //Save the file to the right location
                fs.writeFile(`${path_to_folder}${json_structure.ShortName}.gc`, result.data, (err) => {
                    if (err) {
                        log('Error writing to file:', err);
                    } else {
                        log(`External code list data written to ${path_to_folder}${json_structure.ShortName}.gc`);
                    }
                });
                //console.log(result.data)
            })
            .catch((error) => console.log(error));
            break;
    
        default:
            log(`Unknown type: ${json_structure.type}!`)
            break;
    }
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

//auxiliary function to write ESPD Request and Response XML to a file
function writeXMLfiles(xml_doc, file_name) {
    //log(xml_doc)

    xml_doc.doc()
    fs.writeFile(`${path_to_folder}\\${file_name}`, xml_doc.end({ prettyPrint: true }), (err) => {
        if (err) {
            log('Error writing to file:', err);
        } else {
            log(`Code list created: ${file_name}`);
        }
    })
}