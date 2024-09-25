# European Single Procurement Document Exchange Data Model - ESPD-EDM

[![EUPL Licence](https://img.shields.io/badge/Licence-EUPL%20v1.2-blue.svg)](https://eupl.eu/1.2/en)

## Introduction

The ESPD-EDM is the technical representation of the legal [European Single Procurement Document - The 2014/24/EC Directive on Public Procurement(Article 59)](https://eur-lex.europa.eu/legal-content/EN/LSU/?uri=celex%3A32014L0024) and [Regulation (EU) 2016/7](https://eur-lex.europa.eu/eli/reg_impl/2016/7/oj). It is used to support interoperability between the ESPD services provided all over Europe. The ESPD document is an **XML** document based on the [OASIS UBL](https://groups.oasis-open.org/communities/tc-community-home2?CommunityKey=556949c8-dac8-40e6-bb16-018dc7ce54d6) standard enhanced with specific ESPD Business Rules and genericode Code Lists. The ESPD documents are:
- **ESPD Request** created by the Contracting Authority
- **ESPD Response** created by the Economic Operator as a direct response to the ESPD Request.

Any feedback will be higly appreciated and can be submitted via the [GitHub issues](https://github.com/OP-TED/ESPD-EDM/issues/new/choose) tab of this repository. You will need to be a registered GitHub user to create an issue, or to contribute actively to an existing one.

<details>

<summary>ESPD EDM - Repository structure</summary>

### Folder structure

The `main` branch has the following folder structure:

| Folder | Content |
| --- | --- |
| **codelists** | The `ESPD-CodeLists.xlsx` file contains the defintion of technical code lists managed by ESPD Team as well as references to the EU Vocabularies code lists. This file can be used in conjunction with `codelists.js` from the `espd-tools` branch to generate and download all ESPD Code List files.<br> `BACH-DataBase-Ratios.xlsx` is the extract of the FinacialRatioType provided by Banque de France. This is used as the basis for generating the genericode `FinancialRationType.gc`.<br>Folder `gc` contains the **Code List** files in geniricode format. These files are used in conjunction with the UBL XML structure and the ESPD Model to generate and validate ESPD Request and ESPD Response XML files.|
| **conceptual-model** | This folder contains the conceptual model of the ESPD in _.eap_ and _.xmi_ format.<br><ol><li>The _.eap_ and _.xmi_ file include two views and diagrams:</li><ul><li>**Business oriented view (BOV)** aimed at facilitating the understanding of the model and the business context, with references to the technical model, and;</li><li>**Technically oriented view (TOV)** providing an UBL based schema with reference to the business oriented view and aligned with the eProcurement Ontology.</li></ul><li>The conceptual model is exported as HTML and is available on the public [Documentation site of ESPD](https://docs.ted.europa.eu/ESPD-EDM/latest/_attachments/ESPD_CM_html/index.html).</li></ol>|
| **criterion** | This folder contains the criterion structure definition.<br> `ESPD-criterion-request-multiple-C25-C32.xlsx` - Request criterion structure with multiple occurrences for criteria C25 and C32.<br>`ESPD-criterion-response-multiple-C1-C25-C32.xlsx` - Response criterion structure with multiple occurrences for criteria C1, C25 and C32.<br>`ESPD-criterion.xlxs` - Data structure of ESPD EDM|
| **ubl-2.3** | This folder contains the **OASIS UBL 2.3** Distribution package. It includes:<ul><li>**mod:** contains files that describe and represent the information</li><li>**xsd:** contains the xsd schemas for the ESPD Request and Response</li><li>**xsdrt:** contains the xsd schemas for ESPD Request and Response required for runtime.</li></ul>|
| **validation** | This folder contains the **ESPD EDM** validation files. These files are created following the procedure described in [ESPD Validation Schematron](https://github.com/OP-TED/espd-validation-schematron/blob/main/README.md) repository, and the resulting XSL files are stored in the corresponding folders in this repository.<br>The required business rules validation files for XSL are uploaded to the [ITB Testbed](https://github.com/ISAITB/validator-resources-espd). The <br>`espd-validation.bat` file can be used to validate the examples files in the `xml-examples` folder.|
| **xml-examples**|  The **ESPD XML** samples folder contains default **ESPDRequest** and **ESPDResponse** XML samples. You can also create your own ESPD XML sample files and run `validation/espd-validatoin.bat` to validate your files.|

### Branch structure

The `main` branch is the latest release branch and should contain the code with the _latest_ tag. The development branch, `vX.X.X` is created from the `main` branch when developement starts. It may be a patch, a minor or a major release. The `espd-tools` is an independent branch that contains JavaScript tools to process, analyse and transform the Criterion and Code List Excel files.

The `espd-tools` branch has its own [README](https://github.com/OP-TED/ESPD-EDM/blob/espd-tools/README.md) file with instructions and details on how to use the tools.

</details>

## Usage

### Testing and Validation

The resources necessary for testing and validating ESPD XML documents can be found in the `validation` folder. You will need `Java SDK v1.8+`, `OpenJDK 1.8+` or similar installed on your environment. Copy your own ESPD XML documents or use the existing ones in the `xml-examples` folder and execute the validation via the command line:
```bash
cd validation
espd-validation.bat
```
The results can be found in the `validation/logs` folder. Check the error reports.

If you want to visualise, validate, and test the ESPD Model or generate more ESPD examples please use the [ESPD Demo](https://docs.ted.europa.eu/espd-demo/) site.

You can validate your ESPD documents directly on the [ITB Testbed](https://www.itb.ec.europa.eu/espd/upload).

### Implementing an ESPD Service

The ESPD Team offers support and answers to your questions via [GitHub issues](https://github.com/OP-TED/ESPD-EDM/issues/new/choose), during [Open User Community Regular Meetings](https://docs.ted.europa.eu/espd-wgm/monthly.html), and [Annual Seminar Meetings](https://docs.ted.europa.eu/espd-wgm/annual.html). Bilateral meetings can be scheduled upon request. We are commited to assisting and supporting you in your journey towards a successful ESPD Service implementation.

The following artefacts provided in this repository may be used to design and implement an ESPD Service:
- Code Lists - in the `coldelists/gc` folder
- Conceptual Model - in the `conceptual-model/ESPD_CM.eapx`
- Criterion Excel file - in the `criterion/ESPD-criterion.xlsx`
- UBL distribution files - in the `ubl-2.3` folder, and
- Public TED Documentation site - https://docs.ted.europa.eu/ESPD-EDM/latest/index.html

## Release Notes

Please find the Release Notes for each release on [GitHub releases](https://github.com/OP-TED/ESPD-EDM/releases). The distribution package for each release is attached to the corresponding release and the source code is tagged in the GitHub repository.

## Documentation

Documentation for the latest version can be found here: https://docs.ted.europa.eu/ESPD-EDM/latest/index.html

## Licence  
The project is developed and distributed under the [European Union Public Licence (EUPL) version 1.2](https://joinup.ec.europa.eu/collection/eupl/eupl-text-eupl-12).
