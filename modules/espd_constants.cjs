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

module.exports  = {cols, tag_map, namespace_map, invalid_criterion}