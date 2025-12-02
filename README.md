# European Single Procurement Document Exchange Data Model - ESPD-EDM

[![EUPL Licence](https://img.shields.io/badge/Licence-EUPL%20v1.2-blue.svg)](https://eupl.eu/1.2/en)

## Introduction

The ESPD-EDM is the technical representation of the legal [European Single Procurement Document - The 2014/24/EC Directive on Public Procurement(Article 59)](https://eur-lex.europa.eu/legal-content/EN/LSU/?uri=celex%3A32014L0024) and [Regulation (EU) 2016/7](https://eur-lex.europa.eu/eli/reg_impl/2016/7/oj). It is used to support interoperability between the ESPD services provided all over Europe. The ESPD document is an **XML** document based on the [OASIS UBL](https://groups.oasis-open.org/communities/tc-community-home2?CommunityKey=556949c8-dac8-40e6-bb16-018dc7ce54d6) standard enhanced with specific ESPD Business Rules and genericode Code Lists. The ESPD documents are:
- **ESPD Request** created by the Buyer / Contracting Authority
- **ESPD Response** created by the Economic Operator as a direct response to the ESPD Request.

Any feedback will be higly appreciated and can be submitted via the [GitHub issues](https://github.com/OP-TED/ESPD-EDM/issues/new/choose) tab of this repository. You will need to be a registered GitHub user to create an issue, or to contribute actively to an existing one.


## ESPD EDM - Repository structure

### Folder structure

The `main` branch has the following folder structure:

| Folder | Content |
| --- | --- |
| **codelists** | The folder contains the defintion of technical code lists managed by ESPD Team as well as references to the EU Vocabularies code lists. <br>The folder contains the **Code List** files in geniricode format. These files are used in conjunction with the UBL XML structure and the ESPD Model to generate and validate ESPD Request and ESPD Response XML files.|
| **criterion** | This folder contains the criterion structure definition.<br> The file `espd-edm.json` contains the  data structure of ESPD EDM in JSON format.|
| **schemas** | This folder contains the **OASIS UBL 2.4** Distribution package. It includes:<ul><li>**common:** contains files that describe and represent the common elements and structures.</li><li>**maindoc:** contains the xsd schemas for the ESPD Request and Response</li></ul>|
| **validation** | This folder contains the **ESPD EDM** validation files. These files are created following the procedure described in [ESPD Validation Schematron](https://github.com/OP-TED/espd-validation-schematron/blob/main/README.md) repository, and the resulting XSL files are stored in the corresponding folders in this repository.<br>The required business rules validation files for XSL are uploaded to the [ITB Testbed](https://github.com/ISAITB/validator-resources-espd).|

### Branch structure

The `main` branch is the latest release branch and should contain the code with the _latest_ tag. The development branch, `vX.X.X` is created from the `main` branch when developement starts. It may be a patch, a minor or a major release.

## Usage

### Implementing an ESPD Service

The ESPD Team offers support and answers to your questions via [GitHub issues](https://github.com/OP-TED/ESPD-EDM/issues/new/choose), during [Open User Community Regular Meetings](https://docs.ted.europa.eu/espd-wgm/monthly.html), and [Annual Seminar Meetings](https://docs.ted.europa.eu/espd-wgm/annual.html). Bilateral meetings can be scheduled upon request. We are commited to assisting and supporting you in your journey towards a successful ESPD Service implementation.

The following artefacts provided in this repository may be used to design and implement an ESPD Service:
- Code Lists - in the `coldelists` folder
- Criterion JSON file - in the `criterion/espd-edm.json`
- UBL distribution files - in the `schemas` folder, 
- Business Rules files - in the `validation` folder there are specific XSL files that implement ESPD EDM validation rules for the XML document, and
- Public TED Documentation site - https://docs.ted.europa.eu/ESPD-EDM/latest/index.html

You can validate your ESPD documents directly on the [ITB Testbed](https://www.itb.ec.europa.eu/espd/upload).

## Release Notes

Please find the Release Notes for each release on [GitHub releases](https://github.com/OP-TED/ESPD-EDM/releases). The distribution package for each release is attached to the corresponding release and the source code is tagged in the GitHub repository.

## Documentation

Documentation for the latest version can be found here: https://docs.ted.europa.eu/ESPD-EDM/latest/index.html

## Licence  
The project is developed and distributed under the [European Union Public Licence (EUPL) version 1.2](https://joinup.ec.europa.eu/collection/eupl/eupl-text-eupl-12).
