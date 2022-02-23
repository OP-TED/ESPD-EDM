# ESPD Exchange Data Model (EDM)
# Version 3.0.1 (February 2022)

## Introduction

The ESPD Exchange Data Model is the technical representation of the legal European Single Procurement Document. It is used to support interoperability between ESPD services provided all over Europe.

## ESPD Wiki

To have a comprehensive view of what ESPD-EDM is and how to use it, we strongly recommend visiting the [ESPD-EDM Wiki](https://github.com/ESPD/ESPD-EDM/wiki), that aims to be the **Unique Access Point** for all of its resources: tools, assets, etc.

## Documentation

* [v3.0.1](https://docs.ted.europa.eu/ESPD-EDM/3.0.1/index.html)
* [v2.1.1](https://docs.ted.europa.eu/ESPD-EDM/2.1.1/index.html)
* [v2.1.0](https://docs.ted.europa.eu/ESPD-EDM/2.1.0/index.html)
* [v2.0.2](https://docs.ted.europa.eu/ESPD-EDM/2.0.2/index.html)
* [v1.0.2](https://docs.ted.europa.eu/ESPD-EDM/1.0.2/index.html)

## Version Content
This new version of the ESPD-EDM includes:
* Reorganisation of the distribution package folders

  ![Distribution_package](https://user-images.githubusercontent.com/67598083/154658178-422f2c59-99b8-452d-85ee-f1b7964b3e95.jpg)


  * **\_\_ESPDTeam__**: contains files for ESPD Team internal use in maintenance tasks of the ESPD-EDM;
  * **codelists**: contains the different code lists used in ESPD in Genericode format and the criterion structure definition.
  * **conceptual-model**: contains the UML conceptual model of the ESPD in .eap, .xmi and HTML format.
  * **java-library**: contains the XML schemas used to generate the JAXB annotated Java classes.
  * **ubl-2.3**: contains a redistribution package from UBL 2.3.
  * **validation**: contains business rules validation files for Schematron and Testbed.
  * **xml-examples**: contains default ESPDRequest and ESPDResponse xml samples and the criterion xml schema.
* Documented handbook migration to [Ted Developer Docs](https://docs.ted.europa.eu/home/index.html).
* Updated ESPD-EDM conceptual model:
  * [_.eap_ and _.xmi_ files](https://github.com/OP-TED/ESPD-EDM/tree/v3.0.1/conceptual-model) with two views and diagrams: 
    * **Business oriented view (BOV)** aimed at facilitating the understanding of the model and the business context, with references to the technical model, and;
    * **Technically oriented view (TOV)** providing an UBL based schema with references to business oriented view and aligned with the eProcurement ontology.
  * [_HTML_ version](https://github.com/OP-TED/ESPD-EDM/tree/v3.0.1/conceptual-model/ESPD_CM_html) of the UML conceptual model.If you do not want to download the folder to view the model you can view it on the documentation page under [ESPD-EDM CONCEPTUAL MODEL HTML](https://docs.ted.europa.eu/ESPD-EDM/3.0.1/_attachments/ESPD_CM_html/index.html).
* EU Vocabularies code lists version update (specific files can be found in folder [codelists/gc](https://github.com/OP-TED/ESPD-EDM/tree/v3.0.1/codelists/gc))
  * **access-right** version updated to	20211208-0.
  * **country**	version updated to 20211208-0.
  * **criterion**	version updated to 20210616-0.
  * **currency** version updated to 20211208-0.
  * **economic-operator-size** version updated to 20210317-0.
  * **eo-role-type** version updated to 20211208-0.
  * **language** version updated to 20211208-0.
* Update of Interoperability Testbed [ESPD validator](https://www.itb.ec.europa.eu/espd/upload)
  * Updated v3.0.1 on the validator.
  * Removed v3.0.0 from the validator.

For more information regarding the release, please refer to the [release notes](https://docs.ted.europa.eu/ESPD-EDM/3.0.1/release_notes.html).

## Use
The ESPD-EDM is made publicly available through GitHub. 
* To browse or access the model, there is no need to be registered in Github.
* To create issues concerning the ESPD-EDM a GitHub registered user is needed.
