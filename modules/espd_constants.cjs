//Tags mapped to elements from the Excel 
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
    buyervalue: {
        label: "Buyer Value (example)",
        column: 0
    },
};

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
}


module.exports  = {cols, tag_map}