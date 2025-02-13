#!/usr/bin/env node

/*
 * Generate ESPD Request and ESPD Response XML files from Excel
 * Follow the XSLT logic and rules
 */

var XLSX = require("xlsx")
var chalk = require('chalk')
var fs = require("fs")
const { create } = require('xmlbuilder2')
const { program } = require("@caporal/core")
const uuid_v4 = require('crypto')

const {cols, tag_map, code_list_version} = require("./modules/espd_constants.cjs")
const log = console.log;

var counter = {
    'C': 0,
    'ADL': 0,
    'SBC': 0,
    'L': 0,
    'RG': 0,
    'QG': 0,
    'RSG': 0,
    'QSG': 0,
    'CA': 0,
    'RQ': 0,
    'Q': 0,
    'R': 0,
    'RV': 0,
    'RES': 0,
    'RAP': 0,
}

var schemeVersionID = '4.0.0'

var in_excel_we_trust = [
    //"ESPD-criterion-request-multiple-C25-C32.xlsx",
    "criterion/ESPD-criterion-response-multiple-C1-C25-C32.xlsx"
]

var espd_json = {}, evidence_ids = [], lot_ids = [], espd_request, espd_response

XLSX.set_fs(fs);

program
    .version("1.6.8")
    .name("excel2espd")
    .description("Tool to generate ESDP XML file from Excel Criterion files")

    .command("espd_XML", "Generate ESPD Request and Response XML files")
    .option('--svid [schemeVersionID]', 'ESPD EDM version', {default: '4.0.0'})
    .argument("<excelfile>", "Excel Criterion file to process")
    .action(({ logger, args, options }) => {
        //log(JSON.stringify(args))
        schemeVersionID = options.svid
        if(args.excelfile.length > 0){
            in_excel_we_trust = [ args.excelfile ]
            log(chalk.bold(`Processing ${args.excelfile}`))
        }
        //log(chalk.blue.bold('Excel to XML transformation'), chalk.red('for ESPD realease v4.0.0.'));
        log('\n\n')


        espd_request = create({
            version: '1.0',
            encoding: 'UTF-8',
            defaultNamespace: { ele: 'urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationRequest-2', att: null },
            namespaceAlias: { cbc: 'urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2', cac: 'urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2' }
        })
            .ele('QualificationApplicationRequest')
            .att('http://www.w3.org/2001/XMLSchema-instance', 'xsi:schemaLocation', 'urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationRequest-2 ../xsdrt/maindoc/UBL-QualificationApplicationRequest-2.3.xsd')
            .att('@xmlns', 'xmlns:fn', 'http://www.w3.org/2005/xpath-functions')
            .att('@xmlns', 'xmlns:xs', 'http://www.w3.org/2001/XMLSchema')
            .att('@xmlns', 'xmlns:cac', 'urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2')
            .att('@xmlns', 'xmlns:cbc', 'urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2')
            .att('@xmlns', 'xmlns:espd', `urn:com:grow:espd:${schemeVersionID}`)
            ,
            espd_response = create({
                version: '1.0',
                encoding: 'UTF-8',
                defaultNamespace: { ele: 'urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationResponse-2', att: null },
                namespaceAlias: { cbc: 'urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2', cac: 'urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2' }
            })
                .ele('QualificationApplicationResponse')
                .att('http://www.w3.org/2001/XMLSchema-instance', 'xsi:schemaLocation', 'urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationResponse-2 ../xsdrt/maindoc/UBL-QualificationApplicationResponse-2.3.xsd')
                .att('@xmlns', 'xmlns:fn', 'http://www.w3.org/2005/xpath-functions')
                .att('@xmlns', 'xmlns:xs', 'http://www.w3.org/2001/XMLSchema')
                .att('@xmlns', 'xmlns:cac', 'urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2')
                .att('@xmlns', 'xmlns:cbc', 'urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2')
                .att('@xmlns', 'xmlns:espd', `urn:com:grow:espd:${schemeVersionID}`)

        in_excel_we_trust.forEach(xcl => {
            var wbk = XLSX.readFile(xcl)
            //log(chalk.bold(xcl))
            var sheet_name_list = wbk.SheetNames
            counter[tag_map['CRITERION']] = 0

            for (const i in sheet_name_list) {
                if (Object.hasOwn(sheet_name_list, i)) {
                    const element = sheet_name_list[i];
                    //log(''.padStart(80, '_'))
                    //log(chalk.bold(element))
                    espd_JSON(wbk.Sheets[element], element)
                    //log('\n\n')
                }
            }
        })

        //log(JSON.stringify(espd_json, null, ' '))

        //render the JSON
        createRootElements()

        render_request(espd_json)
        render_request(espd_json, espd_response)
        render_response(espd_json, espd_response)

        createEvidence()
        //log(espd_request.end({ prettyPrint: true }))
        writeXMLfiles()

        //espd_response.doc()
        //log(espd_response.end({ prettyPrint: true }))

    })


// launch the main loop
program.run()

/**
 * create the ESPD Request and Response XML JSON structures
 * @param {*} sph - spreadsheet object
 * @param {str} sheetname - name of the spreadsheet
 */
function espd_JSON(sph, sheetname) {
    var xlData = XLSX.utils.sheet_to_json(sph)

    let c_obj = {},
        c_type = (sheetname.startsWith('EG') ? 'EG' : (sheetname.startsWith('SC') ? 'SC' : 'OT')),
        element_map = [];
    //reset the level counter
    for (const key in counter) {
        if (Object.hasOwn(counter, key)) {
            counter[key] = 0
        }
    }

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
                        c_obj.tag = `C${element[col_idx - 1]} - ${c_type}` //this assumes that the CRITERION number is in column 1
                        c_obj.type = tag
                        //default lot for Selection Criteria
                        if(c_type == 'SC') c_obj.lots = []
                        for (const key in cols) {
                            let clm = cols[key].column
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
                            let clm = cols[key].column
                            if (clm > 0 && Object.hasOwn(element, clm) && element[clm].toString().trim().length > 0) {
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
                            let clm = cols[key].column
                            if (clm > 0 && Object.hasOwn(element, clm) && element[clm].toString().trim().length > 0) {
                                tmp_elm[key] = element[clm].toString().trim()
                            }
                        }
                        if (!Object.hasOwn(tmp_elm, 'cardinality')) tmp_elm['cardinality'] = 1
                        parent[`${tag_map[tag]}${counter[tag_map[tag]]}`] = tmp_elm
                        if(tag == 'REQUIREMENT' && tmp_elm.propertydatatype == 'LOT_IDENTIFIER'){
                            if(lot_ids.indexOf(tmp_elm.buyervalue) == -1)lot_ids.push(tmp_elm.buyervalue)
                            //add LOT to CRITERION
                            if(!Object.hasOwn(c_obj, 'lots')){
                                c_obj.lots = []
                            }
                            if(c_obj.lots.indexOf(tmp_elm.buyervalue.trim()) == -1) c_obj.lots.push(tmp_elm.buyervalue.trim())
                            //log(JSON.stringify(c_obj.lots, null, 4))
                        }
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
                        if(c_type == 'SC' && c_obj.lots.length == 0) c_obj.lots.push('LOT-0000')
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

    })

}

/**
 * Auxiliary function to write ESPD Request and Response XML to a file
 */
function writeXMLfiles() {
    espd_request.doc()
    fs.writeFile('ESPD_Request.xml', espd_request.end({ prettyPrint: true }), (err) => {
        if (err) {
            log('Error writing to file:', err);
        } else {
            log(`JSON data written to ESPD_Request.xml`);
        }
    });

    espd_response.doc()
    fs.writeFile('ESPD_Response.xml', espd_response.end({ prettyPrint: true }), (err) => {
        if (err) {
            log('Error writing to file:', err);
        } else {
            log(`JSON data written to ESPD_Response.xml`);
        }
    });
}

/**
 * Generate Request header
 */
function createRootElements() {
    espd_request.com(` The ESPD-EDM-V${schemeVersionID} is entirely based on OASIS UBL-2.3 `)
        .ele('@cbc', 'UBLVersionID', { 'schemeAgencyID': 'OASIS-UBL-TC' }).txt('2.3').up()
        .com(` How ESPD-EDM-V${schemeVersionID} uses the UBL-2.3 schemas whilst keeping conformance `)
        .ele('@cbc', 'ProfileExecutionID', { 'schemeAgencyID': "OP", 'schemeVersionID': schemeVersionID }).txt(`ESPD-EDMv${schemeVersionID}`).up()
        .com(' The identifier of this document is generally generated by the systems that creates the ESPD ')
        .ele('@cbc', 'ID', { 'schemeAgencyID': 'DGPE' }).txt(`ESPDREQ-DGPE-${uuid_v4.randomUUID()}`).up()
        .com(' Indicates whether this document is an original or a copy. In this case the document is the original ')
        .ele('@cbc', 'CopyIndicator').txt('false').up()
        .com(' The unique identifier for this instance of the document. Copies of this document should have different UUIDs ')
        .ele('@cbc', 'UUID', { 'schemeID': 'ISO/IEC 9834-8:2008 - 4UUID', 'schemeAgencyID': 'XXXESPD-SERVICEXXX', 'schemeVersionID': schemeVersionID }).txt(uuid_v4.randomUUID()).up()
        .com(' The reference number the contracting authority assigns to this procurement procedure ')
        .ele('@cbc', 'ContractFolderID', { 'schemeAgencyID': 'DGPE' }).txt('PP.20170419.1024-9').up()
        .ele('@cbc', 'IssueDate').txt((new Date()).toISOString().substring(0, 10)).up()
        .ele('@cbc', 'IssueTime').txt((new Date()).toTimeString().substring(0, 8) + (new Date()).toTimeString().substring(12, 15) + ":" + (new Date()).toTimeString().substring(15, 17)).up()
        .com(' The version of the content of this document. If the document is modified the element cbc:PreviousVersionID should be instantiated ')
        .ele('@cbc', 'VersionID', { 'schemeAgencyID': 'OP', 'schemeVersionID': schemeVersionID }).txt(schemeVersionID).up()
        .com(' The type of the procurement procedure; this information is provided by eForms and the concret notice per procedure. e.g. open = 	In open procedures any interested economic operator may submit a tender in response to a call for competition. ')
        .ele('@cbc', 'ProcedureCode', code_list_version[schemeVersionID].procedure_code).txt('Open').up()


    espd_response.com(` The ESPD-EDM-V${schemeVersionID} is entirely based on OASIS UBL-2.3 `)
        .ele('@cbc', 'UBLVersionID', { 'schemeAgencyID': "OASIS-UBL-TC" }).txt('2.3').up()
        .com(` How ESPD-EDM-V${schemeVersionID} uses the UBL-2.3 schemas whilst keeping conformance `)
        .ele('@cbc', 'ProfileExecutionID', { 'schemeAgencyID': "OP", 'schemeVersionID': schemeVersionID }).txt(`ESPD-EDMv${schemeVersionID}`).up()
        .com(` The identifier of this document	generally generated by the systems that creates the ESPD `)
        .ele('@cbc', 'ID', { 'schemeAgencyID': 'DGPE' }).txt(`ESPDREQ-DGPE-${uuid_v4.randomUUID()}`).up()
        .com(' Indicates whether this document is an original or a copy. In this case the document is the original ')
        .ele('@cbc', 'CopyIndicator').txt('false').up()
        .com(' The unique identifier for this instance of the document. Copies of this document should have different UUIDs ')
        .ele('@cbc', 'UUID', { 'schemeID': 'ISO/IEC 9834-8:2008 - 4UUID', 'schemeAgencyID': 'XXXESPD-SERVICEXXX', 'schemeVersionID': schemeVersionID }).txt(uuid_v4.randomUUID()).up()
        .com(' The reference number the contracting authority assigns to this procurement procedure ')
        .ele('@cbc', 'ContractFolderID', { 'schemeAgencyID': 'DGPE' }).txt('PP.20170419.1024-9').up()
        .ele('@cbc', 'IssueDate').txt((new Date()).toISOString().substring(0, 10)).up()
        .ele('@cbc', 'IssueTime').txt((new Date()).toTimeString().substring(0, 8) + (new Date()).toTimeString().substring(12, 15) + ":" + (new Date()).toTimeString().substring(15, 17)).up()
        .com(' The version of the content of this document. If the document is modified the element cbc:PreviousVersionID should be instantiated ')
        .ele('@cbc', 'VersionID', { 'schemeAgencyID': 'OP', 'schemeVersionID': schemeVersionID }).txt(schemeVersionID).up()
        .com(' The type of the procurement procedure; this information is provided by eForms and the concret notice per procedure. e.g. open = 	In open procedures any interested economic operator may submit a tender in response to a call for competition. ')
        .ele('@cbc', 'ProcedureCode', code_list_version[schemeVersionID].procedure_code).txt('Open').up()

    createContractingAuthority()


}

/**
 * Generate Request Contracting Authority
 */
function createContractingAuthority() {

    espd_request.ele('@cac', 'ContractingParty')
        .ele('@cbc', 'BuyerProfileURI').txt('DV').up()
        .ele('@cac', 'Party')
        .ele('@cbc', 'WebsiteURI').txt('DV').up()
        .ele('@cbc', 'EndpointID', { 'schemeID': 'DV', 'schemeAgencyID': 'OP' }).txt('DV').up()
        .ele('@cac', 'PartyIdentification')
        .ele('@cbc', 'ID', { 'schemeAgencyID': "VIES" }).txt('B82387770').up()
        .up()
        .ele('@cac', 'PartyName')
        .ele('@cbc', 'Name').txt('DV').up()
        .up()
        .ele('@cac', 'PostalAddress')
        .ele('@cbc', 'StreetName').txt('DV').up()
        .ele('@cbc', 'CityName').txt('DV').up()
        .ele('@cbc', 'PostalZone').txt('DV').up()
        .ele('@cac', 'Country')
        .ele('@cbc', 'IdentificationCode', code_list_version[schemeVersionID].country).txt('BEL').up()
        .up()
        .up()
        .ele('@cac', 'Contact')
        .ele('@cbc', 'Name').txt('DV').up()
        .ele('@cbc', 'Telephone').txt('DV').up()
        .ele('@cbc', 'ElectronicMail').txt('DV').up()
        .up()
        .up()
        .up()

    espd_response.ele('@cac', 'ContractingParty')
        .ele('@cbc', 'BuyerProfileURI').txt('DV').up()
        .ele('@cac', 'Party')
        .ele('@cbc', 'WebsiteURI').txt('DV').up()
        .ele('@cbc', 'EndpointID', { 'schemeID': 'DV', 'schemeAgencyID': 'OP' }).txt('DV').up()
        .ele('@cac', 'PartyIdentification')
        .ele('@cbc', 'ID', { 'schemeAgencyID': "VIES" }).txt('B82387770').up()
        .up()
        .ele('@cac', 'PartyName')
        .ele('@cbc', 'Name').txt('DV').up()
        .up()
        .ele('@cac', 'PostalAddress')
        .ele('@cbc', 'StreetName').txt('DV').up()
        .ele('@cbc', 'CityName').txt('DV').up()
        .ele('@cbc', 'PostalZone').txt('DV').up()
        .ele('@cac', 'Country')
        .ele('@cbc', 'IdentificationCode', code_list_version[schemeVersionID].country).txt('BEL').up()
        .up()
        .up()
        .ele('@cac', 'Contact')
        .ele('@cbc', 'Name').txt('DV').up()
        .ele('@cbc', 'Telephone').txt('DV').up()
        .ele('@cbc', 'ElectronicMail').txt('DV').up()
        .up()
        .up()
        .up()

    //add the Economic Operator for the Response
    espd_response.ele('@cac', 'EconomicOperatorParty')
        .ele('@cac', 'EconomicOperatorRole')
        .ele('@cbc', 'RoleCode', code_list_version[schemeVersionID].eo_role_type).txt('group-mem').up()
        .up()
        .ele('@cac', 'Party')
        .ele('@cbc', 'WebsiteURI').txt('https://www.ProcurerWebsite.eu').up()
        .ele('@cbc', 'IndustryClassificationCode', code_list_version[schemeVersionID].economic_operator_size).txt('sme').up()
        .ele('@cac', 'PartyIdentification')
        .ele('@cbc', 'ID', { 'schemeAgencyID': "OP" }).txt('AD123456789').up()
        .up()
        .ele('@cac', 'PartyName')
        .ele('@cbc', 'Name').txt('__Procurer Official Name__').up()
        .up()
        .ele('@cac', 'PostalAddress')
        .ele('@cbc', 'StreetName').txt('__ProcurerStreet__').up()
        .ele('@cbc', 'CityName').txt('__ProcurerCity__').up()
        .ele('@cbc', 'PostalZone').txt('12345').up()
        .ele('@cac', 'Country')
        .ele('@cbc', 'IdentificationCode', code_list_version[schemeVersionID].country).txt('BEL').up()
        .up()
        .up()
        .ele('@cac', 'Contact')
        .ele('@cbc', 'Name').txt('__ProcurerContactName__').up()
        .ele('@cbc', 'Telephone').txt('654321').up()
        .ele('@cbc', 'Telefax').txt('098765').up()
        .ele('@cbc', 'ElectronicMail').txt('__ProcurerContact@gov.eu').up()
        .up()
        .up()
        .up()

    createProcurementProject()
}

/**
 * Generate Request Procurement Project
 */
function createProcurementProject() {
    espd_request.ele('@cac', 'ProcurementProject')
        .ele('@cbc', 'Description').txt('Description of Project.').up()
        .up()

    lot_ids.sort().forEach((lotid) =>{
        //log(lotid)
        espd_request.ele('@cac', 'ProcurementProjectLot')
                    .ele('@cbc', 'ID', {'schemeID': "Criterion", 'schemeAgencyID':"OP", 'schemeVersionID':schemeVersionID}).txt(lotid).up()
                    .up()    
    })

    //Procurement Projet and Prourement Project Lot
    //Respond only to LOT-0000, default lot - check in lots array of CRITERION
    espd_response.ele('@cac', 'ProcurementProject')
        .ele('@cbc', 'Description').txt('Description of Project.').up()
        .up()

    espd_response.ele('@cac', 'ProcurementProjectLot')
        .ele('@cbc', 'ID', { 'schemeID': "Criterion", 'schemeAgencyID': "OP", 'schemeVersionID': schemeVersionID }).txt('LOT-0000').up()
        .up()
}

/**
 * Create Evidence for ESPD Response
 */
function createEvidence() {
    evidence_ids.forEach((evid) => {
        espd_response.ele('@cac', 'Evidence')
        .ele('@cbc', 'ID', { 'schemeAgencyID': "XXXAGENCYXXX" }).txt(evid).up()
        .ele('@cbc', 'ConfidentialityLevelCode', code_list_version[schemeVersionID].access_right).txt('CONFIDENTIAL').up()
        .ele('@cac', 'DocumentReference')
        .ele('@cbc', 'ID', { 'schemeAgencyID': "XXXAGENCYXXX" }).txt('SAT-11121233').up()
        .ele('@cac', 'Attachment')
        .ele('@cac', 'ExternalReference')
        .ele('@cbc', 'URI').txt('http:dod.gov.usa/sat/it/soft/prk?id=11121233').up()
        .up().up()
        .ele('@cac', 'IssuerParty')
        .ele('@cac', 'PartyIdentification')
        .ele('@cbc', 'ID', { 'schemeAgencyID': "XXXAGENCYXXX" }).txt('XXXXXXXX').up()
        .up()
        .ele('@cac', 'PartyName')
        .ele('@cbc', 'Name').txt('USA DoD').up()
        .up()
        .up()
        .up()
        .up()
    })
}

/**
 * Render the elementes of JSON to XML ESPD Request, and ESPD Response - the Request part
 */
function render_request(obj, part = espd_request, EG_FLAG = true) {
    let tmp = part
    for (const elm in obj) {

        if (Object.hasOwn(obj, elm)) {
            const element = obj[elm]
            switch (element.type) {
                case "CRITERION":
                    let c_id = (element.requestpath.indexOf('_OT_') != -1)?element.requestpath:element.elementUUID
                    tmp = part.com(` Criterion: ${element.name} `)
                        .ele('@cac', 'TenderingCriterion')
                        .ele('@cbc', 'ID', { 'schemeID': 'Criterion', 'schemeAgencyID': 'OP', 'schemeVersionID': schemeVersionID }).txt(c_id).up()
                        .ele('@cbc', 'CriterionTypeCode', code_list_version[schemeVersionID].criterion).txt(element.elementcode).up()
                        .ele('@cbc', 'Name').txt(element.name).up()
                        .ele('@cbc', 'Description').txt(element.description).up()
                        
                    //add lot for SC only
                    if(element.tag.endsWith('- SC')){ 
                        for (let index = 0; index < element.lots.length; index++) {
                            tmp = tmp.ele('@cac', 'ProcurementProjectLotReference')
                            .ele('@cbc', 'ID', {'schemeID': "Criterion", 'schemeAgencyID':"OP", 'schemeVersionID':schemeVersionID}).txt(element.lots[index]).up()
                            .up()    
                          }
                    }
                    //create the inner elements
                    if (Object.hasOwn(element, 'components')) render_request(element.components, tmp, element.tag.endsWith('- EG'))
                    part.up()

                    break;
                case "SUBCRITERION":
                    tmp = part.ele('@cac', 'SubTenderingCriterion')
                        .ele('@cbc', 'ID', { 'schemeID': 'Criterion', 'schemeAgencyID': 'OP', 'schemeVersionID': schemeVersionID }).txt(element.requestpath).up()
                        .ele('@cbc', 'Name').txt(element.name).up()
                        .ele('@cbc', 'Description').txt(element.description).up()
                    //create the inner elements
                    if (Object.hasOwn(element, 'components')) render_request(element.components, tmp, EG_FLAG)
                    part.up()
                    break;
                case "LEGISLATION":
                    tmp = part.ele('@cac', 'Legislation')
                        .ele('@cbc', 'ID', { 'schemeID': 'Criterion', 'schemeAgencyID': 'OP', 'schemeVersionID': schemeVersionID }).txt(element.requestpath).up()
                        .ele('@cbc', 'Title').txt('[Legislation Title]').up()
                        .ele('@cbc', 'Description').txt('[Legislation Description]').up()
                        .ele('@cbc', 'JurisdictionLevel').txt('EU').up()
                        .ele('@cbc', 'Article').txt('[Article, e.g. Article 2.I.a]').up()
                        .ele('@cbc', 'URI').txt('http://eur-lex.europa.eu/').up()
                        .ele('@cac', 'Language')
                        .ele('@cbc', 'LocaleCode', code_list_version[schemeVersionID].language).txt('ENG').up()
                        .up()
                        .up()
                    //create the inner elements
                    if (Object.hasOwn(element, 'components')) render_request(element.components, tmp, EG_FLAG)
                    part.up()
                    break;
                case "ADDITIONAL_DESCRIPTION_LINE":
                    tmp = part.ele('@cbc', 'Description').txt(element.description).up()
                    //create the inner elements
                    if (Object.hasOwn(element, 'components')) render_request(element.components, tmp, EG_FLAG)
                    part.up()
                    break;
                case "REQUIREMENT_GROUP": case "QUESTION_GROUP":
                    //render only 1st occurence in Request
                    if (Object.hasOwn(element, 'cardinality') && typeof element.cardinality === 'string') {
                        //log(element.cardinality, typeof element.cardinality)              
                        if (element.cardinality.indexOf("(2)") != -1 ||
                            element.cardinality.indexOf("(3)") != -1 ||
                            element.cardinality.indexOf("(4)") != -1)
                            break;
                    }
                    tmp = part.ele('@cac', 'TenderingCriterionPropertyGroup')
                        .ele('@cbc', 'ID', { 'schemeID': 'Criterion', 'schemeAgencyID': 'OP', 'schemeVersionID': schemeVersionID }).txt(element.requestpath).up()
                        .ele('@cbc', 'PropertyGroupTypeCode', code_list_version[schemeVersionID].property_group_type).txt(element.elementcode).up()

                    //create the inner elements
                    if (Object.hasOwn(element, 'components')) render_request(element.components, tmp, EG_FLAG)
                    part.up()
                    break;
                case "REQUIREMENT_SUBGROUP": case "QUESTION_SUBGROUP":
                    //render only 1st occurence in Request
                    if (Object.hasOwn(element, 'cardinality') && typeof element.cardinality === 'string') {
                        //log(element.cardinality, typeof element.cardinality)
                        if (element.cardinality.indexOf("(2)") != -1 ||
                            element.cardinality.indexOf("(3)") != -1 ||
                            element.cardinality.indexOf("(4)") != -1)
                            break;
                    }
                    tmp = part.ele('@cac', 'SubsidiaryTenderingCriterionPropertyGroup')
                        .ele('@cbc', 'ID', { 'schemeID': 'Criterion', 'schemeAgencyID': 'OP', 'schemeVersionID': schemeVersionID }).txt(element.requestpath).up()
                        .ele('@cbc', 'PropertyGroupTypeCode', code_list_version[schemeVersionID].property_group_type).txt(element.elementcode).up()

                    //create the inner elements
                    if (Object.hasOwn(element, 'components')) render_request(element.components, tmp, EG_FLAG)
                    part.up()
                    break;
                case "QUESTION": case "CAPTION":
                    part.ele('@cac', 'TenderingCriterionProperty')
                        .ele('@cbc', 'ID', { 'schemeID': 'Criterion', 'schemeAgencyID': 'OP', 'schemeVersionID': schemeVersionID }).txt(element.requestpath).up()
                        .ele('@cbc', 'Name').txt(element.name).up()
                        .ele('@cbc', 'Description').txt(element.description).up()
                        .ele('@cbc', 'TypeCode', code_list_version[schemeVersionID].criterion_element_type).txt(element.type).up()
                        .ele('@cbc', 'ValueDataTypeCode', code_list_version[schemeVersionID].response_data_type).txt(Object.hasOwn(element, 'propertydatatype') ? element.propertydatatype : 'NONE').up()
                        .up()
                    break;
                case "REQUIREMENT":
                    tmp = part.ele('@cac', 'TenderingCriterionProperty')
                        .ele('@cbc', 'ID', { 'schemeID': 'Criterion', 'schemeAgencyID': 'OP', 'schemeVersionID': schemeVersionID }).txt(element.requestpath).up()
                        .ele('@cbc', 'Name').txt(element.name).up()
                        .ele('@cbc', 'Description').txt(element.description).up()
                        .ele('@cbc', 'TypeCode', code_list_version[schemeVersionID].criterion_element_type).txt(element.type).up()
                        .ele('@cbc', 'ValueDataTypeCode', code_list_version[schemeVersionID].response_data_type).txt(Object.hasOwn(element, 'propertydatatype') ? element.propertydatatype : 'NONE').up()
                        .com(' No answer is expected here from the economic operator, as this is a REQUIREMENT issued by the contracting authority. Hence the element "cbc:ValueDataTypeCode" contains the type of value of the requirement issued by the contracting authority  ')

                    switch (element.propertydatatype) {
                        case 'AMOUNT':
                            tmp.ele('@cbc', 'ExpectedAmount', { 'currencyID': 'EUR' }).txt(element.buyervalue ? element.buyervalue : 0).up()
                            break;
                        case 'IDENTIFIER': case "EVIDENCE_IDENTIFIER": case "ECONOMIC_OPERATOR_IDENTIFIER": case "LOT_IDENTIFIER":
                            tmp.ele('@cbc', 'ExpectedID', { 'schemeAgencyID': 'OP' }).txt(element.buyervalue).up()
                            break;
                        case 'CODE_BOOLEAN':
                            tmp.ele('@cbc', 'ExpectedCode', code_list_version[schemeVersionID].boolean_gui_control_type).txt(element.buyervalue).up()
                            break;
                        case 'CODE_COUNTRY':
                            tmp.ele('@cbc', 'ExpectedCode', code_list_version[schemeVersionID].country).txt(element.buyervalue).up()
                            break;
                        case 'ECONOMIC_OPERATOR_ROLE_CODE':
                            tmp.ele('@cbc', 'ExpectedCode', code_list_version[schemeVersionID].eo_role_type).txt(element.buyervalue).up()
                            break;
                        case 'DESCRIPTION':
                            tmp.ele('@cbc', 'ExpectedDescription').txt(element.buyervalue).up()
                            break;
                        case 'PERCENTAGE':
                            tmp.ele('@cbc', 'ValueUnitCode').txt('PERCENTAGE').up()
                                .ele('@cbc', 'ExpectedValueNumeric').txt(element.buyervalue ? element.buyervalue : 0).up()
                            break;
                        case 'INDICATOR':
                            //not present in Excel
                            tmp.ele('@cbc', 'ExpectedIndicator').txt(element.buyervalue ? element.buyervalue : 'false').up()
                            break;
                        case 'DATE':
                            //not present in Excel
                            tmp.ele('@cbc', 'ValueUnitCode').txt('DATE').up()
                            .ele('@cbc', 'ExpectedValueNumeric').txt(element.buyervalue ? element.buyervalue : '2000-01-01').up()
                            break;
                        case 'PERIOD':
                            //in Excel file the value for PERIOD is: 2016-01-01; 2017-01-01
                            //.ele('@cbc', 'StartDate').txt(element.buyervalue ? element.buyervalue.substring(0, element.buyervalue.indexOf(';')).trim() : '2000-01-01').up()
                            //.ele('@cbc', 'EndDate').txt(element.buyervalue ? element.buyervalue.substring(element.buyervalue.indexOf(';')+1).trim() : '2050-12-31').up()

                            tmp.ele('@cac', 'ApplicablePeriod')
                                .ele('@cbc', 'StartDate').txt('2000-01-01').up()
                                .ele('@cbc', 'EndDate').txt('2050-12-31').up()
                                .up()
                            break;
                        case 'MINIMUM_QUANTITY_INTEGER': case 'MINIMUM_QUANTITY_YEAR': case 'MINIMUM_QUANTITY': 
                        case 'QUANTITY_INTEGER': case 'QUANTITY': case 'QUANTITY_YEAR':
                            tmp.ele('@cbc', 'ExpectedValueNumeric').txt(element.buyervalue ? element.buyervalue : 0).up()
                            break;
                        case 'MAXIMUM_AMOUNT':
                            tmp.ele('@cbc', 'MaximumAmount', { 'currencyID': 'EUR' }).txt(element.buyervalue ? element.buyervalue : 0).up()
                            break;
                        case 'MINIMUM_AMOUNT':
                            tmp.ele('@cbc', 'MinimumAmount', { 'currencyID': 'EUR' }).txt(element.buyervalue ? element.buyervalue : 0).up()
                            break;
                        case 'MAXIMUM_VALUE_NUMERIC':
                            tmp.ele('@cbc', 'MaximumValueNumeric').txt(element.buyervalue).up()
                            break;
                        case 'MINIMUM_VALUE_NUMERIC':
                            tmp.ele('@cbc', 'MinimumValueNumeric').txt(element.buyervalue).up()
                            break;
                        case 'TRANSLATION_TYPE_CODE':
                            //not used in Excel file
                            tmp.ele('@cbc', 'TranslationTypeCode').txt(element.buyervalue).up()
                            break;
                        case 'COPY_QUALITY_TYPE_CODE':
                            //not used in Excel file
                            tmp.ele('@cbc', 'CopyQualityTypeCode').txt(element.buyervalue).up()
                            break;
                        case 'CERTIFICATION_LEVEL_DESCRIPTION':
                            //not used in Excel files
                            tmp.ele('@cbc', 'CertificationLevelDescription').txt(element.buyervalue).up()
                            break;
                        case 'URL':
                            tmp.ele('@cbc', 'ExpectedURI', { 'schemeAgencyID': 'OP' }).txt(element.buyervalue).up()
                            break;
                        case 'CODE':
                            if (element.codelist == 'Occupation') tmp.ele('@cbc', 'ExpectedCode', code_list_version[schemeVersionID].occupation).txt(element.buyervalue).up()
                            if (element.codelist == 'FinancialRatioType') tmp.ele('@cbc', 'ExpectedCode', code_list_version[schemeVersionID].financial_ration_type).txt(element.buyervalue).up()
                            if (element.codelist == 'EoRoleType') tmp.ele('@cbc', 'ExpectedCode', code_list_version[schemeVersionID].eo_role_type).txt(element.buyervalue).up()
                            break;

                        default:
                            tmp.com(` PropertyDataType: ${element.propertydatatype} not defined `)
                            break;
                    }

                    part.up()
                    break;
                default:
                    part.com(` Unkown ${element.type} - UBL mapping not implemented `).up()
                    break;
            }
        }
    }
}

/**
 * Render the elements of JSON to XML ESPD Response 
 * @param {JSON} obj 
 * @param {JSON} part 
 */
function render_response(obj, part = espd_response, crt_criterion = 'NONE') {
    let tmp = part

    for (const elm in obj) {
        if (Object.hasOwn(obj, elm)) {
            const element = obj[elm];

            switch (element.type) {
                case 'CRITERION':
                    //check for Selection Criteria and LOT-0000
                    if(element.tag.endsWith('-SC') && element.lots.indexOf('LOT-0000') == -1) break;
                    //create the inner elements
                    if (Object.hasOwn(element, 'components')) render_response(element.components, tmp, element.name)
                    break;
                case "QUESTION_GROUP": case "QUESTION_SUBGROUP":
                    //check for QUESTIONS that are INDICATOR and render only the components that are ON*,
                    //and ONTRUE or ONFALSE depending on the value of the INDICATOR
                    let tmpComponents = {}, QI_FLAG = false, INDICATOR_value = null;
                    if (Object.hasOwn(element, 'components')) {
                        for (const key in element.components) {
                            if (Object.hasOwn(element.components, key)) {
                                const e = element.components[key]
                                tmpComponents[key] = e
                                if (e.type == 'QUESTION' && e.propertydatatype == 'INDICATOR' && Object.hasOwn(e, "sellervalue")) {
                                    QI_FLAG = true
                                    INDICATOR_value = e.sellervalue
                                }
                            }
                        }
                        if (QI_FLAG) {
                            for (const cmp in tmpComponents) {
                                if (Object.hasOwn(tmpComponents, cmp)) {
                                    const c = tmpComponents[cmp]
                                    if (['QUESTION_GROUP', 'QUESTION_SUBGROUP'].indexOf(c.type) != -1) {
                                        if ((c.elementcode == 'ONTRUE' && INDICATOR_value == 'false') ||
                                            (c.elementcode == 'ONFALSE' && INDICATOR_value == 'true')) {
                                            delete tmpComponents[cmp]
                                        }
                                    }
                                }
                            }
                        }
                        render_response(tmpComponents, part, crt_criterion)
                    }

                    break;
                case "REQUIREMENT_GROUP":
                    //the structure is CRITERION -> REQUIREMENT_GROUP -> REQUIREMENT
                    //check if one of the REQUIREMENTS has LOT-0000
                    let lot_OK = false
                    if(Object.hasOwn(element, 'components')){
                        for (const cmp in element['components']) {
                            if (Object.hasOwn(element['components'], cmp) && !lot_OK) {
                                const el = element['components'][cmp];
                                if(el.type == 'REQUIREMENT' && el.propertydatatype == 'LOT_IDENTIFIER' && el.buyervalue == 'LOT-0000'){
                                    lot_OK = true
                                }
                            }
                        }
                    }
                    if(lot_OK) render_response(element.components, tmp, crt_criterion)
                    break;
                case "REQUIREMENT_SUBGROUP":
                case 'SUBCRITERION':
                case 'LEGISLATION': case 'ADDITIONAL_DESCRIPTION_LINE':
                case 'REQUIREMENT': case 'CAPTION':
                    //create the inner elements
                    if (Object.hasOwn(element, 'components')) render_response(element.components, tmp, crt_criterion)
                    break;
                case 'QUESTION':
                    tmp = part.com(`  Answer to Criterion:${crt_criterion}  `)
                        .com(` Property: ${element.description} (PropertyID: ${element.responsepath}) `)
                        .ele('@cac', 'TenderingCriterionResponse')
                        .ele('@cbc', 'ID', { 'schemeID': "Criterion", 'schemeAgencyID': "XXXESPD-SERVICEXXX", 'schemeVersionID': schemeVersionID }).txt(element.responsecontent1).up()
                        .ele('@cbc', 'ValidatedCriterionPropertyID', { 'schemeID': "Criterion", 'schemeAgencyID': "XXXESPD-SERVICEXXX", 'schemeVersionID': schemeVersionID }).txt(element.responsecontent2).up()

                    switch (element.propertydatatype) {
                        case 'PERIOD':
                            tmp.ele('@cac', 'ApplicablePeriod')
                                .ele('@cbc', 'StartDate').txt('2017-01-01').up()
                                .ele('@cbc', 'EndDate').txt('2017-12-12').up()
                                .up()
                            break;
                        case 'EVIDENCE_IDENTIFIER':
                            tmp.ele('@cac', 'EvidenceSupplied')
                                .ele('@cbc', 'ID', { 'schemeAgencyID': 'OP' }).txt(element.responsecontent3).up()
                                .up()
                            evidence_ids.push(element.responsecontent3)
                            break;
                        case 'DESCRIPTION':
                            tmp.ele('@cac', 'ResponseValue')
                                .ele('@cbc', 'ID', { 'schemeID': "Criterion", 'schemeAgencyID': "XXXESPD-SERVICEXXX", 'schemeVersionID': schemeVersionID }).txt(element.responsecontent3).up()
                                .ele('@cbc', 'Description').txt(element.sellervalue ? element.sellervalue : 'Dummy Description').up()
                                .up()
                            break;
                        case 'INDICATOR':
                            tmp.ele('@cac', 'ResponseValue')
                                .ele('@cbc', 'ID', { 'schemeID': "Criterion", 'schemeAgencyID': "XXXESPD-SERVICEXXX", 'schemeVersionID': schemeVersionID }).txt(element.responsecontent3).up()
                                .ele('@cbc', 'ResponseIndicator').txt('true').up()
                                .up()
                            break;
                        case 'IDENTIFIER':
                            tmp.ele('@cac', 'ResponseValue')
                                .ele('@cbc', 'ID', { 'schemeID': "Criterion", 'schemeAgencyID': "XXXESPD-SERVICEXXX", 'schemeVersionID': schemeVersionID }).txt(element.responsecontent3).up()
                                .ele('@cbc', 'ResponseID', { 'schemeAgencyID': 'OP' }).txt(element.sellervalue ? element.sellervalue : 'Dummy ID').up()
                                .up()
                            break;
                        case 'ECONOMIC_OPERATOR_IDENTIFIER':
                            tmp.ele('@cac', 'ResponseValue')
                                .ele('@cbc', 'ID', { 'schemeID': "Criterion", 'schemeAgencyID': "XXXESPD-SERVICEXXX", 'schemeVersionID': schemeVersionID }).txt(element.responsecontent3).up()
                                .ele('@cbc', 'ResponseID', { 'schemeAgencyID': 'XXXEOIDXXX' }).txt(element.sellervalue ? element.sellervalue : 'Dummy EO_ID').up()
                                .up()
                            break;
                        case 'QUAL_IDENTIFIER':
                            tmp.ele('@cac', 'ResponseValue')
                                .ele('@cbc', 'ID', { 'schemeID': "Criterion", 'schemeAgencyID': "XXXESPD-SERVICEXXX", 'schemeVersionID': schemeVersionID }).txt(element.responsecontent3).up()
                                .ele('@cbc', 'ResponseID', { 'schemeAgencyID': 'XXXQUALIDXXX' }).txt(element.sellervalue ? element.sellervalue : 'Dummy QUAL_ID').up()
                                .up()
                            break;
                        case 'URL':
                            tmp.ele('@cac', 'ResponseValue')
                                .ele('@cbc', 'ID', { 'schemeID': "Criterion", 'schemeAgencyID': "XXXESPD-SERVICEXXX", 'schemeVersionID': schemeVersionID }).txt(element.responsecontent3).up()
                                .ele('@cbc', 'ResponseURI').txt(element.sellervalue ? element.sellervalue : 'www.no-such-site.eu').up()
                                .up()
                            break;
                        case 'AMOUNT':
                            tmp.ele('@cac', 'ResponseValue')
                                .ele('@cbc', 'ID', { 'schemeID': "Criterion", 'schemeAgencyID': "XXXESPD-SERVICEXXX", 'schemeVersionID': schemeVersionID }).txt(element.responsecontent3).up()
                                .ele('@cbc', 'ResponseAmount', { 'currencyID': 'EUR' }).txt(1000000000).up()
                                .up()
                            break;
                        case 'PERCENTAGE':
                            tmp.ele('@cac', 'ResponseValue')
                                .ele('@cbc', 'ID', { 'schemeID': "Criterion", 'schemeAgencyID': "XXXESPD-SERVICEXXX", 'schemeVersionID': schemeVersionID }).txt(element.responsecontent3).up()
                                .ele('@cbc', 'ResponseNumeric', { 'format': 'PERCENTAGE' }).txt(element.sellervalue ? element.sellervalue : 3.14).up()
                                .up()
                            break;
                        case 'QUANTITY_INTEGER':
                            tmp.ele('@cac', 'ResponseValue')
                                .ele('@cbc', 'ID', { 'schemeID': "Criterion", 'schemeAgencyID': "XXXESPD-SERVICEXXX", 'schemeVersionID': schemeVersionID }).txt(element.responsecontent3).up()
                                .ele('@cbc', 'ResponseQuantity', { 'unitCode': 'INTEGER' }).txt(element.sellervalue ? element.sellervalue : 42).up()
                                .up()
                            break;
                        case 'QUANTITY_YEAR':
                            tmp.ele('@cac', 'ResponseValue')
                                .ele('@cbc', 'ID', { 'schemeID': "Criterion", 'schemeAgencyID': "XXXESPD-SERVICEXXX", 'schemeVersionID': schemeVersionID }).txt(element.responsecontent3).up()
                                .ele('@cbc', 'ResponseQuantity', { 'unitCode': 'YEAR' }).txt(element.sellervalue ? element.sellervalue : 2000).up()
                                .up()
                            break;
                        case 'QUANTITY':
                            tmp.ele('@cac', 'ResponseValue')
                                .ele('@cbc', 'ID', { 'schemeID': "Criterion", 'schemeAgencyID': "XXXESPD-SERVICEXXX", 'schemeVersionID': schemeVersionID }).txt(element.responsecontent3).up()
                                .ele('@cbc', 'ResponseQuantity').txt(element.sellervalue ? element.sellervalue : 60).up()
                                .up()
                            break;
                        case 'DATE':
                            tmp.ele('@cac', 'ResponseValue')
                                .ele('@cbc', 'ID', { 'schemeID': "Criterion", 'schemeAgencyID': "XXXESPD-SERVICEXXX", 'schemeVersionID': schemeVersionID }).txt(element.responsecontent3).up()
                                .ele('@cbc', 'ResponseDate').txt('2000-01-01').up()
                                .up()
                            break;
                        case 'TIME':
                            tmp.ele('@cac', 'ResponseValue')
                                .ele('@cbc', 'ID', { 'schemeID': "Criterion", 'schemeAgencyID': "XXXESPD-SERVICEXXX", 'schemeVersionID': schemeVersionID }).txt(element.responsecontent3).up()
                                .ele('@cbc', 'ResponseTime').txt(element.sellervalue ? element.sellervalue : '00:00:00+00:00').up()
                                .up()
                            break;
                        case 'CODE_COUNTRY':
                            tmp.ele('@cac', 'ResponseValue')
                                .ele('@cbc', 'ID', { 'schemeID': "Criterion", 'schemeAgencyID': "XXXESPD-SERVICEXXX", 'schemeVersionID': schemeVersionID }).txt(element.responsecontent3).up()
                                .ele('@cbc', 'ResponseCode', code_list_version[schemeVersionID].country).txt('BEL').up()
                                .up()
                            break;
                        case 'CODE':
                            if (element.codelist == 'Occupation') {
                                tmp.ele('@cac', 'ResponseValue')
                                    .ele('@cbc', 'ID', { 'schemeID': "Criterion", 'schemeAgencyID': "XXXESPD-SERVICEXXX", 'schemeVersionID': schemeVersionID }).txt(element.responsecontent3).up()
                                    .ele('@cbc', 'ResponseCode', code_list_version[schemeVersionID].occupation).txt('dummy-value').up()
                                    .up()
                            } else if (element.codelist == 'FinancialRatioType') {
                                tmp.ele('@cac', 'ResponseValue')
                                    .ele('@cbc', 'ID', { 'schemeID': "Criterion", 'schemeAgencyID': "XXXESPD-SERVICEXXX", 'schemeVersionID': schemeVersionID }).txt(element.responsecontent3).up()
                                    .ele('@cbc', 'ResponseCode', code_list_version[schemeVersionID].financial_ration_type).txt('dummy-value').up()
                                    .up()
                            } else if (element.codelist == 'EoRoleType') {
                                tmp.ele('@cac', 'ResponseValue')
                                    .ele('@cbc', 'ID', { 'schemeID': "Criterion", 'schemeAgencyID': "XXXESPD-SERVICEXXX", 'schemeVersionID': schemeVersionID }).txt(element.responsecontent3).up()
                                    .ele('@cbc', 'ResponseCode', code_list_version[schemeVersionID].eo_role_type).txt('dummy-value').up()
                                    .up()
                            }

                            break;
                        default:
                            break;
                    }

                    //add the reference to the LOT only for SC
                    if(element.responsepath.indexOf('_SC_') != -1)
                    tmp = tmp.ele('@cac', 'ProcurementProjectLotReference')
                            .ele('@cbc', 'ID', {'schemeID': "Criterion", 'schemeAgencyID':"OP", 'schemeVersionID':schemeVersionID}).txt('LOT-0000').up()
                            .up() 
                    tmp.up()
                    //part.up()
                    break;

                default:
                    break;
            }
        }
    }
}