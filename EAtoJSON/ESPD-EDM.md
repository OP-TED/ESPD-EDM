# ESPD EDM JSON Schema

## Introduction

Our objective is to standardize the ESPD EDM representation and we would like to propose a JSON Schema. This will help to increase the interoperability between ESPD EDM versions.

The need for a schema came from multiple directions:
- users that want to upgrade their ESPD Service to a newer version need to migrate their preivous data to the new ESPD structure, both for ESPD Document and for Critreion.
- comparing and showing the diference between ESPD versions from business and technical point of view.
- use a common basis for technical implementations.

Starting with ESPD v5.0.0 we propose as single source of information the Enterpise Architec (EA) model. The information stored in EA project will be exported in JSON format and will facilitate the implementation and adoption process.

## JSON Schema

The full documentation on JSON schema can be found here: https://json-schema.org/.

ESPD-EDM is represented as a JSON object containing distinct (unique keys) of Exclusion Ground and Selection Criteria objects. This is the deifinition of each object only. For a full structure of the ESPD Document please see (TODO - add reference here). 

```
{
    C1 :{ ... },
    C2: { ... },
    ...
    C##: { ... }
}
```

The following mapping from components to object labels is used:

Component | Label | UBL mapping
--- | --- | ---
CRITERION | C | cac:TenderingCriterion
ADDITIONAL_DESCRIPTION_LINE | ADL | cbc:Description
SUBCRITERION | SBC | cac:SubTenderingCriterion
LEGISLATION | L | cac:Legislation
CAPTION | CA | cac:TenderingCriterionProperty
QUESTION | Q | cac:TenderingCriterionProperty
REQUIREMENT | RQ | cac:TenderingCriterionProperty
QUESTION_GROUP | QG | cac:TenderingCriterionPropertyGroup
QUESTION_SUBGROUP | QSG | cac:SubsidiaryTenderingCriterionPropertyGroup
REQUIREMENT_GROUP | RG | cac:TenderingCriterionPropertyGroup
REQUIREMENT_SUBGROUP | RSG | cac:SubsidiaryTenderingCriterionPropertyGroup
<br/>|   | 
RESPONSE | R | cac:TenderingCriterionResponse
RESPONSE_VALUE | RV | cac:ResponseValue
EVIDENCE_SUPPLIED | RES | cac:EvidenceSupplied
APPLICABLE_PERIOD | RAP | cac:ApplicablePeriod

*CRITERION* is used only at top level all the other elements are components. _QUESTION_GROUP_, _QUESTION_SUBGROUP_, _REQUIREMENT_GROUP_, and _REQUIREMENT_SUBGROUP_ are container structures used to organise the basic elements. The containers may be imbricated.   
The _RESPONSE_, _RESPONSE_VALUE_, _EVIDENCE_SUPPLIED_, and _APPLICABLE_PERIOD_ are used only in the response document, they are not part of the structure and they are used to distinguish between multiple occurences of the same element and for interoperability purpouse.

Each element has a counter that is incremented when the element repeats at the same level, in order to guarantee the unicity of the label. When dealing with multiple occurence of the same element for the response part the discrimination is done by incrementing the corresponding **R#** of that element. In the request part the element will appear only once.

### Top level object

For ESPD v1.X.X until v4.X.X we used to label Criterion with C## (e.g. C33) in order to identify them from techical point of view. We will keep this notation for conveninece and backwards compatibility. If a criterion was deprecated then the number was not recycled, so there are some gaps in criterion numbering. Some of the other sections from the ESPD Document were modelled as Critreion under **OTHER** tag.

Starting with v5.0.0 the **OTHER** criteria were mapped to specific UBL structures and are modelled consequently in EA. The structure for the **OTHER** will be similar to Criterion so that UI rendering should be uniform.

The keys of the top level Criterion element:

Key | Type | Definition
--- | ---  | ---
**tag** | string | Technical name of the element, must allow to indentify the type of Criterion: EG or SC (eventyally OT)
**type** | string | Only one possible value: **CRITERION**
**uuid** | string UUID v4| The UUID from eCertis. This allows to make ESPD - eCertis integration and we should retrieve the following information from eCertis: label of criterion, description of criterion, SUBCRITERION element, LEGISLATION element
**code** | string | The code of the Criterion, the same as the code from specific Code List. The codelist may be Criterion.gc for ESPD v1.0.0-v4.0.0 and ExclusionGround.gc and  SelectionCriterion.gc starting with ESPD v5.0.0. The label and description for criterion may be retrieved from those lists too
**cardinality** | string | It can be: 1 (mandatory with a single occurence), 0..n (optional with multiple occurence), 1..n (mandatory with multiple occurence). Default value: **1**
**components** | Array of Objects | An *Array* of objects that represent the structure of the components of this Criterion.
*name* | string | optional - the name of the Criterion, it should be possible to retrieve it either from eCertis or the Code List GC file
*description* | string | optional - the description of the Criterion, it should be possible to retrieve it either from eCertis fo the Code List XML file
*requestpath* | string | optional - The XML like path that will be used in ESPD Request document and can be computed as concatenation of **tag**_**code**
*responsepath* | string | optional - The XML like path that will be used in ESPD Response document and can be computed as concatenation of **tag**_**code** 

```
C1:{
    tag: "C1_EG",
    type: "CRITERION",
    uuid: "[UUID v4 - source eCertis]",
    code: "[source code list]",
    cardinality: "1",
    components: [ ... ],
    name: "[name from eCertis or code list GC/XML]",
    description: "[description from eCertis of code list XML]",
    requestpath: "[tag_code]",
    responsepath: "[tag_code]"
}
```

### Components object

Each Criterion, Group or SubGroup contains an array of objects, some of them are just containers and at the lowest level are two types of components:
- static text for user information (CAPTION, LEGISLATION, ADDITIONAL_DESCRIPTION_LINE),
- user input field (QUESTION, REQUIREMENT).

The container components are used to organize and group the low level elements. The structures may be imbricated following the business logic that is imposed by grouping from Annex II.

The keys of the Components of container type (QUESTION_GROUP, QUESTION_SUBGROUP, REQUIREMENT_GROUP, REQUIREMENT_SUBGROUP):

Key | Type | Definition
--- | ---  | ---
**type** | string | One of: **QUESTION_GROUP**, **QUESTION_SUBGROUP**, **REQUIREMENT_GROUP**. **REQUIREMENT_SUBGROUP**. The type of container.
**code** | string | One of: **ON\***, **ONFALSE**, **ONTRUE** corresponding to the option that was selected in the leading **QUESTION** having _propertydatatype_: **INDICATOR** <br/> or the value from a list of values if the **QUESTION** has multiple values.
**cardinality** | string | It can be: 1 (mandatory with a single occurence), 0..n (optional with multiple occurence), 1..n (mandatory with multiple occurence). Default value: **1**
**components** | Array of Objects | The components of the this container. It might contain othe containers.
*requestpath* | string | optional - concatenate the parent path with the key 
*responsepath* | string | optional - concatenate the parent value with the key, store the **R#** if the cardinality is **1..n** or **0..n**
*tag* | string | optional - TO BE DEFINED

```
C1: {
    tag: "C1_EG",
    type: "CRITERION",
    uuid: "[UUID v4 - source eCertis]",
    code: "[source code list]",
    cardinality: "1",
    components: [
        QG1: {
            type: "QUESTION_GROUP",
            code: "ON*",
            cardinality: "0..n",
            components: [ ... ],
            requestpath: "C1_EG_code/QG1",
            responsepath: "C1_EG_code/QG1"
        }
     ],
    name: "[name from eCertis or code list GC/XML]",
    description: "[description from eCertis of code list XML]",
    requestpath: "[tag_code]",
    responsepath: "[tag_code]"   
}
```


The keys of the Components of information type (QUESTION, REQUIREMENT, CAPTION, LEGISLATION, ADDITIONAL_DESCRIPTION_LINE):

Key | Type | Definition
--- | ---  | ---
**type** | string | One of: **QUESTION**, **REQUIREMENT**, **CAPTION**, **LEGISLATION**, **ADDITIONAL_DESCRIPTION_LINE**. The type of the field.
**cardinality** | string | It can be: 1 (mandatory with a single occurence), 0..n (optional with multiple occurence), 1..n (mandatory with multiple occurence). Default value: **1**
**description** | string | The label associated to the input field or the text to be displayed for static text fields.
**propertydatatype** | string | The data type of this input. The values should come form **BooleanGUIControlType** code list.
*codelist* | string | mandatory only for fileds associated to a code list. The name of the code list used to populate values in this field.
*sellervalue* | any | optional - The example value provided by the Economic Operator - for **QUESTION** fields
*buyervalue* | any | optional - The example value provided by the Contracting Authority - for **REQUIREMENT** fields
*requestpath* | string | optional - concatenate the parent path with the key 
*responsepath* | string | optional - concatenate the parent value with the key and all **R#** from parent path togehter with its own **R#**
*contentpath* | string | optional - the _responsepath_ concatenated with the **RV**, **RAP**
*tag* | string | optional - TO BE DEFINED




## Definitions

**ESPD Request**  
ESPD Document created by the Contracting Authority or the Buyer that will express a need for goods or services together with Exclusion Grouds and Selection Criteria.

**LOT Management**  
An ESPD Request contains at least one **LOT**. The Exclusion Grounds apply to all LOTs and Selection Critreria applies only to specified LOTs.

**ESPD Response**  
ESPD Document created by the Economic Operator as a followup of an ESPD Request. An ESPD Response is provided for each _LOT_ from the ESPD Request document. All ESPD Response documents must be assembled together and provided to the Contracting Authority or the Buyer.

## Glossary

Acronym | Trem definition 
--------|----------------
ESPD | European Single Procurement Document
ESPD-EDM | European Single Procurement Document Exchange Data Model
EA | Enterprise Architect
EG | Exclusion Ground
SC | Selection Criteria