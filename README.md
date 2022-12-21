# ESPD Exchange Data Model (EDM)
# Version 3.1.0 (December 2022)

## Introduction

The ESPD-EDM v3.0.1 was focused on the ESPD-EDM online documentation updates. This current version v3.1.0 provides changes and fixes suggested by the Member States and stakeholders via the GitHub repositories issues workspace, mostly related to the data structure. 
 
## Documentation

* [v3.1.0](https://docs.ted.europa.eu/ESPD-EDM/latest/index.html)
* [v3.0.1](https://docs.ted.europa.eu/ESPD-EDM/3.0.1/index.html)
* [v2.1.1](https://docs.ted.europa.eu/ESPD-EDM/2.1.1/index.html)
* [v2.1.0](https://docs.ted.europa.eu/ESPD-EDM/2.1.0/index.html)
* [v2.0.2](https://docs.ted.europa.eu/ESPD-EDM/2.0.2/index.html)
* [v1.0.2](https://docs.ted.europa.eu/ESPD-EDM/1.0.2/index.html)


## Version content

This new version of the ESPD-EDM includes:

Distribution_package:

* __ESPDTeam__: contains files for ESPD Team internal use in maintenance tasks of the ESPD-EDM;
* __codelists:__ contains the different code lists used in ESPD in Genericode format and the criterion structure definition.
* __conceptual-model:__ contains the UML conceptual model of the ESPD in .eap, .xmi and HTML format.
* __java-library:__ contains the XML schemas used to generate the JAXB annotated Java classes. __*This artefact is not maintained for version 3.1.0!!*__
* __ubl-2.3:__ contains a redistribution package from UBL 2.3.
* __validation:__ contains business rules validation files for Schematron and Testbed.
* __xml-examples:__ contains default ESPDRequest and ESPDResponse xml samples and the criterion xml schema.


### ESPD-EDM conceptual model

* [_.eap_ and _.xmi_ files](https://github.com/OP-TED/ESPD-EDM/tree/v3.1.0/conceptual-model) with two views and diagrams: 
  * **Business oriented view (BOV)** aimed at facilitating the understanding of the model and the business context, with references to the technical model, and;
  * **Technically oriented view (TOV)** providing an UBL-based schema with references to business-oriented view and aligned with the eProcurement ontology.

* [_HTML_ version](https://github.com/OP-TED/ESPD-EDM/tree/v3.1.0/conceptual-model/ESPD_CM_html) of the UML conceptual model.If you do not want to download the folder to view the model you can view it on the documentation page under [ESPD-EDM CONCEPTUAL MODEL HTML](https://docs.ted.europa.eu/ESPD-EDM/3.1.0/_attachments/ESPD_CM_html/index.html).

### ESPD-EDM Code Lists

EU Vocabularies code lists version updated (specific files can be found in the folder [codelists/gc](https://github.com/OP-TED/ESPD-EDM/tree/v3.1.0/codelists/gc))

* **AccessRight** version updated to	 20220316-0.
* **country**	version updated to  20221019-0.
* **criterion**	version updated to 20210616-0.
* **currency** version updated to 20220928-0.
* **EconomicOperatorSize** version updated to 20220316-0.
* **EoRoleType** version updated to 20211208-0.
* **language** version updated to 20220928-0.

ESPD version has also been updated in the related files to match the current version. 

  * **Fix GitHub issue [#332](https://github.com/OP-TED/ESPD-EDM/issues/332) - Question regarding the DATE Response Data Type** 
      * There was a mistake in the codelist ResponseDataType with one date format YYYY-DD-MM.
      * The codelist was updated to the right date format YYYY-MM-DD.

  * **Fix GitHub issue [#337](https://github.com/OP-TED/ESPD-EDM/issues/337) - Financial ratio type translations** 
      * There were some erros in the translations in the FinancialRatioType codelist, due  to some problems in the XLST transformation file and in the Excel Codelists file.
      * The XLST transformation file and Excel Codelists file has been updated to fix the errors.

### ESPD-EDM Interoperability Testbed

Update of Interoperability Testbed [ESPD validator](https://www.itb.ec.europa.eu/espd/upload)

* Updated v3.1.0 on the validator.
* Removed v3.0.1 from the validator.


For more information regarding the release, please refer to the [release notes](https://github.com/OP-TED/ESPD-EDM/releases/tag/v3.1.0).

## Use
The ESPD-EDM is made publicly available through GitHub. 
* To browse or access the model, there is no need to be registered in Github.
* To create issues concerning the ESPD-EDM a GitHub registered user is needed.
