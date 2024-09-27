//Tags mapped to elements from the Excel Criterion columns
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
    examplevalue: {
        label: "Value(example)",
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

//Excel Criterion short tags - used for labeling elements
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
    'APPLICABLE PERIOD': 'RAP'
};

//Excel Criterion spreadsheet name to Criterion type
const namespace_map = {
    'EG-': '_EG_',
    'SC-': '_SC_',
    'SC_': '_SC_',
    'OTHER-': '_OT_',
    'OTHER.': '_OT_'
};

//Excel Criterion invalid criterion numbers
const invalid_criterion = [33, 62, 64]

/**
 * Code Lists Versions
 * Used directly to create XML document based on ESPD version nubmer and the ShortName of code list
 */
const code_list_version = {
    "4.0.0": {
        "access_right": { 'listID': "http://publications.europa.eu/resource/authority/access-right", 'listAgencyID': "OP", 'listVersionID': "20240612-0" },
        "country" : { 'listID': "http://publications.europa.eu/resource/authority/country", 'listAgencyID': "OP", 'listVersionID': "20240925-0" },
        "criterion": { 'listID': "http://publications.europa.eu/resource/authority/criterion", 'listAgencyID': "OP", 'listVersionID': "20240612-0" },
        "currency": { 'listID': "http://publications.europa.eu/resource/authority/currency", 'listAgencyID': "OP", 'listVersionID': "20220928-0" },
        "docrfercontent_type": { 'listID': "http://publications.europa.eu/resource/authority/docrefcontent-type", 'listAgencyID': "OP", 'listVersionID': "20220928-0" },       
        "economic_operator_size": { 'listID': "http://publications.europa.eu/resource/authority/economic-operator-size", 'listAgencyID': "OP", 'listVersionID': "20240612-0" },
        "eo_role_type": { 'listID': "http://publications.europa.eu/resource/authority/eo-role-type", 'listAgencyID': "OP", 'listVersionID': "20211208-0" },
        "language": { 'listID': "http://publications.europa.eu/resource/authority/language", 'listAgencyID': "OP", 'listVersionID': "20240925-0" },
        "occupation": { 'listID': "http://publications.europa.eu/resource/authority/occupation", 'listAgencyID': "EMPL", 'listVersionID': "20221214-0" },
        "eoid_type": {'listID': "eoid-type" , 'listAgencyID': "OP", 'listVersionID': "4.0.0"},
        "financial_ration_type": {'listID': "financial-ratio-type", 'listAgencyID': "OP", 'listVersionID': "4.0.0"},
        "property_group_type": { 'listID': "property-group-type", 'listAgencyID': "OP", 'listVersionID': "4.0.0" },
        "criterion_element_type": { 'listID': "criterion-element-type", 'listAgencyID': "OP", 'listVersionID': "4.0.0" },
        "response_data_type": { 'listID': "response-data-type", 'listAgencyID': "OP", 'listVersionID': "4.0.0" },
        "boolean_gui_control_type" : { 'listID': 'boolean-gui-control-type', 'listAgencyID': 'OP', 'listVersionID': "4.0.0"},
        "profile_execution_id": { 'listID': "profile-execution-id", 'listAgencyID': "OP", 'listVersionID': "4.0.0" },
        "procedure_code": { "listID": "Dummy_procurement-procedure-type", "listAgencyID": "OP", "listVersionID": "yyyymmdd-0" }
    },
    "3.3.0": {
        "access_right": { 'listID': "http://publications.europa.eu/resource/authority/access-right", 'listAgencyID': "OP", 'listVersionID': "20220316-0" },
        "country" : { 'listID': "http://publications.europa.eu/resource/authority/country", 'listAgencyID': "OP", 'listVersionID': "20220928-0" },
        "criterion": { 'listID': "http://publications.europa.eu/resource/authority/criterion", 'listAgencyID': "OP", 'listVersionID': "20230315-0" },
        "currency": { 'listID': "http://publications.europa.eu/resource/authority/currency", 'listAgencyID': "OP", 'listVersionID': "20220928-0" },
        "docrfercontent_type": { 'listID': "http://publications.europa.eu/resource/authority/docrefcontent-type", 'listAgencyID': "OP", 'listVersionID': "20220316-0" },
        "economic_operator_size": { 'listID': "http://publications.europa.eu/resource/authority/economic-operator-size", 'listAgencyID': "OP", 'listVersionID': "20240612-0" },
        "eo_role_type": { 'listID': "http://publications.europa.eu/resource/authority/eo-role-type", 'listAgencyID': "OP", 'listVersionID': "20211208-0" },
        "language": { 'listID': "http://publications.europa.eu/resource/authority/language", 'listAgencyID': "OP", 'listVersionID': "20220928-0" },
        "occupation": { 'listID': "http://publications.europa.eu/resource/authority/occupation", 'listAgencyID': "EMPL", 'listVersionID': "20221214-0" },
        "eoid_type": {'listID': "eoid-type" , 'listAgencyID': "OP", 'listVersionID': "3.3.0"},
        "financial_ration_type": {'listID': "financial-ratio-type" , 'listAgencyID': "OP", 'listVersionID': "3.3.0"},
        "property_group_type": { 'listID': "property-group-type", 'listAgencyID': "OP", 'listVersionID': "3.3.0" },
        "criterion_element_type": { 'listID': "criterion-element-type", 'listAgencyID': "OP", 'listVersionID': "3.3.0" },
        "response_data_type": { 'listID': "response-data-type", 'listAgencyID': "OP", 'listVersionID': "3.3.0" },
        "boolean_gui_control_type" : { 'listID': 'boolean-gui-control-type', 'listAgencyID': 'OP', 'listVersionID': "3.3.0"},
        "profile_execution_id": { 'listID': "profile-execution-id", 'listAgencyID': "OP", 'listVersionID': "3.3.0" },
        "procedure_code": { "listID": "Dummy_procurement-procedure-type", "listAgencyID": "OP", "listVersionID": "yyyymmdd-0" }
    }
}

module.exports  = {cols, tag_map, namespace_map, invalid_criterion, code_list_version}