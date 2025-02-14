# ESPD EDM JSON Schema

## Introduction

Our objective is to standardize the ESPD EDM representation and we would like to propose a JSON Schema for that purpouse. This will help to increase the interoperability between ESPD EDM versions.

The need for a schema came from multiple directions:

- users that want to upgrade their ESPD Service to a newer version and need to migrate their preivous data to the new ESPD structure, both for ESPD Document and for Critreion.
- comparing and showing the diference between ESPD versions from business and technical point of view.
- use a common basis for technical implementations.

Starting with ESPD v5.0.0 we propose as single source of information: the Enterpise Architec (EA) model. The information stored in EA project will be exported in JSON format and will facilitate the implementation and adoption process.

## JSON Schema

The full documentation on JSON schema can be found here: https://json-schema.org/.

ESPD-EDM is represented as a JSON object containing distinct (unique keys) of Exclusion Ground and Selection Criteria objects, and Additional Information.  

```
{
    C1 :{ ... },
    C2: { ... },
    ...
    C##: { ... },
    AI1: { ... },
    ...
    AI##: { ... }
}
```

The following mapping from components to object labels is used:

| Component                   | Label | UBL mapping                                   |
| --------------------------- | ----- | --------------------------------------------- |
| CRITERION                   | C     | cac:TenderingCriterion                        |
| ADDITIONAL_INFORMATION      | AI    | cac:QualifyingParty                           |
| ADDITIONAL_DESCRIPTION_LINE | ADL   | cbc:Description                               |
| SUBCRITERION                | SBC   | cac:SubTenderingCriterion                     |
| LEGISLATION                 | L     | cac:Legislation                               |
| CAPTION                     | CA    | cac:TenderingCriterionProperty                |
| QUESTION                    | Q     | cac:TenderingCriterionProperty                |
| REQUIREMENT                 | RQ    | cac:TenderingCriterionProperty                |
| QUESTION_GROUP              | QG    | cac:TenderingCriterionPropertyGroup           |
| QUESTION_SUBGROUP           | QSG   | cac:SubsidiaryTenderingCriterionPropertyGroup |
| REQUIREMENT_GROUP           | RG    | cac:TenderingCriterionPropertyGroup           |
| REQUIREMENT_SUBGROUP        | RSG   | cac:SubsidiaryTenderingCriterionPropertyGroup |
| GROUP                       | G     | cac:TenderingCriterionPropertyGroup           |
| SUBGROUP                    | SG    | cac:SubsidiaryTenderingCriterionPropertyGroup |
| <br/>                       |       |
| RESPONSE                    | R     | cac:TenderingCriterionResponse                |
| RESPONSE_VALUE              | RV    | cac:ResponseValue                             |
| EVIDENCE_SUPPLIED           | RES   | cac:EvidenceSupplied                          |
| APPLICABLE_PERIOD           | RAP   | cac:ApplicablePeriod                          |

_CRITERION_ and _ADDITIONAL_INFORMATION_ are used only at top level all the other elements are components. _QUESTION_GROUP_, _QUESTION_SUBGROUP_, _REQUIREMENT_GROUP_, _REQUIREMENT_SUBGROUP_, _GROUP_, and _SUBGROUP_ are container structures used to organise the basic elements. The containers may be imbricated. The diference between _QUESTION_* and _REQUIREMENT_* is that the _QUESTION_* contains only question elements and is targetted to **ECONOMIC OPERATOR**. The _REQUIREMENT_ contains requirement elements and is dedicated to **BUYER**. The diference between _GROUP_ and _SUBGROUP_ is at the level of imbrication: the first level is _GROUP_ and the subsequent levels are _SUBGROUP_, also they are mapped to distinct UBL elements.  
The _RESPONSE_, _RESPONSE_VALUE_, _EVIDENCE_SUPPLIED_, and _APPLICABLE_PERIOD_ are used only in the response document, they are not part of the structure and they are used to distinguish between multiple occurences of the same element and for interoperability purpouse, in particular **R** label.

Each element has a counter that is incremented when the element repeats at the same level, in order to guarantee the unicity of the label. When dealing with multiple occurence of the same element for the response part the discrimination is done by incrementing the corresponding **R#** of that element. In the request part the label for that element will appear only once.

### Top level object

For ESPD v1.X.X until v4.X.X we used to label Criterion with C## (e.g. C33) in order to identify them from techical point of view. We will keep this notation for conveninece and backwards compatibility. If a criterion was deprecated then the number was not recycled, so there are some gaps in criterion numbering. Some of the other sections from the ESPD Document were modelled as Critreion under **OTHER** tag. We introduce notation **AI** - (ADDITIONAL INFORMATION) for those sections. They are sections that contain other information than Exclusion Grounds or Selection Criteria.

Starting with v5.0.0 the **OTHER** criteria were mapped to specific UBL structures and are modelled consequently in EA. The structure for the **OTHER** will be similar to Criterion so that UI rendering should be uniform.

The keys of the top level Criterion element:

| Key             | Type                  | Definition                                                                                                                                                                                                                                                                                 |
| --------------- | --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **tag**         | string                | Technical name of the element, must allow to indentify the type of Criterion: EG or SC (eventyally OT)                                                                                                                                                                                     |
| **type**        | string                | Only one possible value: **CRITERION**                                                                                                                                                                                                                                                     |
| **uuid**        | string UUID v4        | The UUID from eCertis. This allows to make ESPD - eCertis integration and we should retrieve the following information from eCertis: label of criterion, description of criterion, SUBCRITERION element, LEGISLATION element                                                               |
| **code**        | string                | The code of the Criterion, the same as the code from specific Code List. The codelist may be Criterion.gc for ESPD v1.0.0-v4.0.0 and ExclusionGround.gc and SelectionCriterion.gc starting with ESPD v5.0.0. The label and description for criterion may be retrieved from those lists too |
| **cardinality** | string                | It can be: 1 (mandatory with a single occurence), 0..n (optional with multiple occurence), 1..n (mandatory with multiple occurence). Default value: **1**                                                                                                                                  |
| **components**  | Collection of Objects | Objects that represent the structure of the components of this Criterion, the order matters!                                                                                                                                                                                               |
| _name_          | string                | optional - the name of the Criterion, it should be possible to retrieve it either from eCertis or the Code List GC file                                                                                                                                                                    |
| _description_   | string                | optional - the description of the Criterion, it should be possible to retrieve it either from eCertis fo the Code List XML file                                                                                                                                                            |
| _requestpath_   | string                | optional - The XML like path that will be used in ESPD Request document and can be computed as concatenation of **tag**\_**code**                                                                                                                                                          |
| _responsepath_  | string                | optional - The XML like path that will be used in ESPD Response document and can be computed as concatenation of **tag**\_**code**                                                                                                                                                         |

```
C1:{
    tag: "C1_EG",
    type: "CRITERION",
    uuid: "[UUID v4 - source eCertis]",
    code: "[source code list]",
    cardinality: "1",
    components: { ... },
    name: "[name from eCertis or code list GC/XML]",
    description: "[description from eCertis or code list XML]",
    requestpath: "[tag_code]",
    responsepath: "[tag_code]"
}
```

For _ADDITIONAL_INFORMATION_ top level component we have the following attributes:

| Key             | Type                  | Definition                                                                                                                                                                               |
| --------------- | --------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| _tag_           | string                | Technical name of the element, must allow to indentify the type **ADDITIONAL INFORMATION** (eventyally OT)                                                                               |
| **type**        | string                | Only one possible value: **ADDITIONAL_INFORMATION**                                                                                                                                      |
| _code_          | string                | The code of the Criterion, the same as the code from specific Code List. The codelist is Criterion.gc for ESPD v1.0.0-v4.0.0. Starting with ESPD v5.0.0 the code list will be deprecated |
| **cardinality** | string                | It can be: 1 (mandatory with a single occurence), 0..n (optional with multiple occurence), 1..n (mandatory with multiple occurence). Default value: **1**                                |
| **components**  | Collection of Objects | Objects that represent the structure of the components of this Criterion, the order matters!                                                                                             |
| **name**        | string                | The name of the Additiona Information, it should be possible to retrieve it from Code List GC file                                                                                       |
| **description** | string                | The description of the Additional Information, it should be possible to retrieve it from Code List XML file                                                                              |
| _requestpath_   | string                | optional - The XML like path that will be used in ESPD Request document and can be computed as concatenation of **tag**\_**code**                                                        |
| _responsepath_  | string                | optional - The XML like path that will be used in ESPD Response document and can be computed as concatenation of **tag**\_**code**                                                       |

```
AI1:{
    tag: "AI1_OT",
    type: "ADDITIONAL_INFORMATION",
    code: "[source code list]",
    cardinality: "1",
    components: { ... },
    name: "[name code list GC/XML]",
    description: "[description from code list XML]",
    requestpath: "[tag_code]",
    responsepath: "[tag_code]"
}
```

### Components object

Each Criterion, Group or SubGroup contains an array of objects, some of them are just containers and at the lowest level are two types of components:

- static text for user information (CAPTION, LEGISLATION, ADDITIONAL_DESCRIPTION_LINE),
- user input field (QUESTION, REQUIREMENT).

The container components are used to organize and group the low level elements. The structures may be imbricated following the business logic that is imposed by grouping from Annex II.

The keys of the Components of container type (QUESTION_GROUP, QUESTION_SUBGROUP, REQUIREMENT_GROUP, REQUIREMENT_SUBGROUP, SUBCRITERION):

| Key             | Type                  | Definition                                                                                                                                                                                                                                     |
| --------------- | --------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **type**        | string                | One of: **QUESTION_GROUP**, **QUESTION_SUBGROUP**, **REQUIREMENT_GROUP**, **REQUIREMENT_SUBGROUP**, **SUBCRITERION**. The type of container.                                                                                                                     |
| **code**        | string                | One of: **ON\***, **ONFALSE**, **ONTRUE** corresponding to the option that was selected in the leading **QUESTION** having _propertydatatype_: **INDICATOR** <br/> or the value from a list of values if the **QUESTION** has multiple values. |
| **cardinality** | string                | It can be: 1 (mandatory with a single occurence), 0..n (optional with multiple occurence), 1..n (mandatory with multiple occurence). Default value: **1**                                                                                      |
| **components**  | Collection of Objects | The components of the this container. It might contain othe containers. The order of objects matters! The **SUBCRITERION** retrieves the components from eCertis.                                                                                                                                          |
| _requestpath_   | string                | optional - concatenate the parent path with the key of the element object                                                                                                                                                                      |
| _responsepath_  | string                | optional - concatenate the parent value with the key of the element object, store the **R#** if the cardinality is **1..n** or **0..n**                                                                                                        |
| _tag_           | string                | optional - TO BE DEFINED                                                                                                                                                                                                                       |

```
C1: {
    tag: "C1_EG",
    type: "CRITERION",
    uuid: "[UUID v4 - source eCertis]",
    code: "[source code list]",
    cardinality: "1",
    components: {
        QG1: {
            type: "QUESTION_GROUP",
            code: "ON*",
            cardinality: "0..n",
            components: { ... },
            requestpath: "C1_EG_code/QG1",
            responsepath: "C1_EG_code/QG1"
        }
    },
    name: "[name from eCertis or code list GC/XML]",
    description: "[description from eCertis of code list XML]",
    requestpath: "[tag_code]",
    responsepath: "[tag_code]"
}
```

The keys of the Components of information type (QUESTION, REQUIREMENT, CAPTION, LEGISLATION, ADDITIONAL_DESCRIPTION_LINE):

| Key                  | Type   | Definition                                                                                                                                                |
| -------------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **type**             | string | One of: **QUESTION**, **REQUIREMENT**, **CAPTION**, **LEGISLATION**, **ADDITIONAL_DESCRIPTION_LINE**. The type of the field.                              |
| **cardinality**      | string | It can be: 1 (mandatory with a single occurence), 0..n (optional with multiple occurence), 1..n (mandatory with multiple occurence). Default value: **1** |
| **description**      | string | The label associated to the input field or the text to be displayed for static text fields. The **LEGISLATION** retrieves the content from eCertis.                                                              |
| **propertydatatype** | string | The data type of this input. The values should come form **BooleanGUIControlType** code list.                                                             |
| _code_               | string | mandatory only for lists - List of possible values for this element                                                                                       |
| _codelist_           | string | mandatory only for fileds associated to a code list. The name of the code list used to populate values in this field.                                     |
| _sellervalue_        | any    | optional - The example value provided by the Economic Operator - for **QUESTION** fields                                                                  |
| _buyervalue_         | any    | optional - The example value provided by the Contracting Authority - for **REQUIREMENT** fields                                                           |
| _requestpath_        | string | optional - concatenate the parent path with the key of the element object                                                                                 |
| _responsepath_       | string | optional - concatenate the parent value with the key of the element object and all **R#** from parent path togehter with its own **R#**                   |
| _contentpath_        | string | optional - the _responsepath_ concatenated with the **RV**, **RAP**                                                                                       |
| _tag_                | string | optional - TO BE DEFINED                                                                                                                                  |

```
C1: {
    tag: "C1_EG",
    type: "CRITERION",
    uuid: "[UUID v4 - source eCertis]",
    code: "[source code list]",
    cardinality: "1",
    components: {
        QG1: {
            type: "QUESTION_GROUP",
            code: "ON*",
            cardinality: "0..n",
            components: {
                Q1:{
                    type: "QUESTION",
                    cardinality: "1",
                    description: "Your answer:",
                    propertydatatype: "INDICATOR",
                    sellervalue: true,
                    requestpath: "C1_EG_code/QG1/Q1",
                    responsepath: "C1_EG_code/QG1/Q1/R1/R1",
                    contentpath: "C1_EG_code/QG1/Q1/R1/R1/RV"
                }
            },
            requestpath: "C1_EG_code/QG1",
            responsepath: "C1_EG_code/QG1"
        }
    },
    name: "[name from eCertis or code list GC/XML]",
    description: "[description from eCertis of code list XML]",
    requestpath: "[tag_code]",
    responsepath: "[tag_code]"
}
```

The content of the following elements must be fetched form eCertis based on the UUID of the Criterion, and the structure of the ESPD EDM must be augmented with those details. In particular for **SUBCRITERION**:

- **LEGISLATION** corresponds to EU directives and regulations that must be observed by all ESPD participants at any moment. This is normally plain text with eventual liks to the actual legislation. User is not required to feed any particular information.
- **SUBCRITERION** corresponds to EU memeber state national legislation and specific conditions. Each EU member state may ask for extra details and documents. It might be paritculary complex to render the entire element. Please note that there are technical limitations of the ESPD EDM. If you encounter any difficulties accomodating your data structure please contact ESPD Team at: [OPESPD@publications.europa.eu](mailto:OPESPD@publications.europa.eu)

The diagram bellow illustrates the structucture of JSON:

![JSON sample](https://www.plantuml.com/plantuml/svg/bPJHQ_em4CVVyrU4FlxmPrVOaq-EAgMmsTdPiI53WZstZffqoTKXul--fBDM8nbRo8DtzxtBvnAlGuLCuhiIdEo85mRUWEu8rSj3zgeDxLgC8wzty6qhQ9nfF1kdSJ9f0tLTv2Ompx9uH3VNz3zLefPBe122n4AzjCgboA5H7kB6fcMXi5CmcHUSbGLkZJ3eCjULuC1H7I4R_pGApXndfDDi_33Je8ieJR9xKwfR7Kmo-MU5R8ghVf_R4WTG1wQvRBS3pohjeWXSkXpKKXOL5e8RtREe9MLSVO8Sk58gAIgGkCqPiXOddepYy6QMfAua1MK9SiFAskXHrk0GIlYeGM75yEtuBrgOw_RrS_dwPfnvgX9SWJFHJyrstfVW21n_pjRxqRl8tvCpgqT-tu-c-KCJ7h6EF9pbSRR-7WtpWwwaMBVJGuNi1eL6eVzqTzlEY_tsynFRAh8wAT9Lk6XkhaU_eJK2ko5ReSF4TB8dG-2v-P1y0G00)

<!--
@startjson
{
"C1": {
    "tag": "C1_EG",
    "type": "CRITERION",
    "uuid": "[UUID v4 - source eCertis]",
    "code": "[source code list]",
    "cardinality": "1",
    "components": {
        "QG1": {
            "type": "QUESTION_GROUP",
            "code": "ON*",
            "cardinality": "0..n",
            "components": {
                "Q1":{
                    "type": "QUESTION",
                    "cardinality": "1",
                    "description": "Your answer:",
                    "propertydatatype": "INDICATOR",
                    "sellervalue": true,
                    "requestpath": "C1_EG_code/QG1/Q1",
                    "responsepath": "C1_EG_code/QG1/Q1/R1/R1",
                    "contentpath": "C1_EG_code/QG1/Q1/R1/R1/RV"
                }
            },
            "requestpath": "C1_EG_code/QG1",
            "responsepath": "C1_EG_code/QG1"
        }
     },
    "name": "[name from eCertis or code list GC/XML]",
    "description": "[description from eCertis of code list XML]",
    "requestpath": "[tag_code]",
    "responsepath": "[tag_code]"
  }
}
@endjson
-->

## Full ESPD Document structure

The ESPD is a document based on [Annex II of Regulation (EU)2016/7](https://eur-lex.europa.eu/eli/reg_impl/2016/7/oj). The overall structure is divided in **Parts** and **Sections**. Each **Section** groups information cells: Exclusion Grounds, Selection Criteria, and Additional Information. The JSON Schema accomodates the Exclusion Grounds and Selection Criteria. The Additional Information is via JSON Schema, some sections are assimilated with previous _Other_ criteria and previously not modelled sections were added. The objective was to modell everything about ESPD form in a single JSON.

```
{
    partI: {
        sectionA: ["PI-SA"],
        sectionB: ["PI-SB"],
        sectionC: ["PI-SC"]
    },
    partII: {
        sectionA: ["PII-SA", "C65", "C57", "C58", "C59"],
        sectionB: ["PII-SB"],
        sectionC: ["C60"],
        sectionD: ["C61"]
    },
    partIII: {
        sectionA: ["C1", "C2", "C3", "C4", "C5", "C6"],
        sectionB: ["C7", "C8"],
        sectionC: ["C9", "C10", "C11", "C12", "C13", "C14",
            "C15", "C16", "C17", "C18", "C19", "C20",
            "C21", "C22", "C23"],
        sectionD: ["C24"]
    },
    partIV: {
        sectionA: ["C25", "C26", "C27", "C28"],
        sectionB: ["C29", "C30", "C31", "C32", "C34", "C35", "C36"],
        sectionC: ["C37","C38", "C39", "C40", "C41", "C42",
            "C43", "C44", "C45", "C46", "C47", "C48",
            "C49", "C50", "C51", "C52", "C53", "C54"],
        sectionD: ["C55", "C56"]
    },
    partV: {
        sectionA: ["C63"]
    }
}
```

where:

- **C#** is the corresponding Critreion from JSON Schema
- **AI#** is the Additional Information section

![ESPD Document](https://img.plantuml.biz/plantuml/svg/RP8zQyCm54Lt_ugWsOMy3wbEfoJkagrGw58o5DgbGrgQRA7_lOgECAaS6zuJr_ZS-nvQ7qzlFwVFuzUXEtVXEvztuM5nxXRv2PjyV0rFkxldJTZtQDj9sqxQE6bZs7U_VGNT81LKd_z8iRHuJnjegvdD3PynBIVbiIhoptTcF4hXQwbMgkD8cCPs9DNG6g-AB4iQJ04gK0Mim9L40oSCAL0KYjPaKDJQoTIl9tkP3QOuAKwAamxjG8gfOMgOMjq7cGsIfNPgoz1SIM-07903Sa1UDmlFuJd9d6GEnQ54A15AX1AXH6zN4UkLILSRcIyasULpVjSVX_VBlVu3)

<!--
@startjson
{
    "partI": {
        "A": ["PI-SA"],
        "B": ["PI-SB"],
        "C": ["PI-SC"]
    },
    "partII": {
        "A": ["PII-SA", "C65", "C57", "C58", "C59"],
        "B": ["PII-SB"],
        "C": ["C60"],
        "D": ["C61"]
    },
    "partIII": {
        "A": ["C1", "C2", "C3", "C4", "C5", "C6"],
        "B": ["C7", "C8"],
        "C": ["C9", "C10", "C11", "C12", "C13", "C14", "C15", "C16", "C17", "C18", "C19", "C20", "C21", "C22", "C23"],
        "D": ["C24"]
    },
    "partIV": {
        "A": ["C25", "C26", "C27", "C28"],
        "B": ["C29", "C30", "C31", "C32", "C34", "C35", "C36"],
        "C": ["C37","C38", "C39", "C40", "C41", "C42", "C43", "C44", "C45", "C46", "C47", "C48", "C49", "C50", "C51", "C52", "C53", "C54"],
        "D": ["C55", "C56"]
    },
    "partV": {
        "A": ["C63"]
    }
}
@endjson
-->

The ESPD Document structure must be maintained and stored in EA.

## Definitions

**ESPD Request**  
ESPD Document created by the Contracting Authority or the Buyer that will express a need for goods or services together with Exclusion Grouds and Selection Criteria.

**LOT Management**  
An ESPD Request contains at least one **LOT**. The Exclusion Grounds apply to all LOTs and Selection Critreria applies only to specified LOTs.

**ESPD Response**  
ESPD Document created by the Economic Operator as a followup of an ESPD Request. An ESPD Response is provided for each _LOT_ from the ESPD Request document. All ESPD Response documents must be assembled together and provided to the Contracting Authority or the Buyer.

## Glossary

| Acronym  | Trem definition                                          |
| -------- | -------------------------------------------------------- |
| ESPD     | European Single Procurement Document                     |
| ESPD-EDM | European Single Procurement Document Exchange Data Model |
| EA       | Enterprise Architect                                     |
| EG       | Exclusion Ground                                         |
| SC       | Selection Criteria                                       |
