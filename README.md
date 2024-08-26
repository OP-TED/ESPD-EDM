# ESPD-EDM Tools  
ESPD-EMD branch contains JavaScript tools that will process Excel files associated with ESPD-EDM.

[![EUPL Licence](https://img.shields.io/badge/Licence-EUPL%20v1.2-blue.svg)](https://eupl.eu/1.2/en)

**Audience** 

This is a technical branch of ESPD-EDM repository and is intended to be used as a tool that gets as input:  
- ESPD-EDM Excel Criterion file
- Code Lists Excel file 

and processes them producing usable output files for ESPD.

## Usage

The JavaScrpit utility check.js is a NodeJS command line application and is delivered as an integrated package.
Minumum NodeJS version: 18.X
All libraries and commands are contained in package.json file - this is a standard npm file.
All commands have to be launched in the root folder from the command line (CMD, PowerShell or any terminal)

To setup and install all necessary JavaScript libraries:

```npm install```

To cleanup the libraries:

```npm run clean```

The Excel files: ESPD-criterion-request-multiple-C25-C32.xlsx and ESPD-criterion-response-multiple-C1-C25-C32.xlsx are the files that contain the fixes for tags and
especially for Response multiple occurence examples.

To check the TAGS for both Excel files:

```npm run checkjs check_tag > tag_check.txt```

The results will be in tag_check.txt file and if there is a tag that does not fit the rules then the [NOK] label is present at the begginign or the report line.

To check the XML Like path IDs for both Excel files:

```npm run checkjs check_UUID > path_check.txt```

The results will be in tag_check.txt file and if there is a tag that does not fit the rules then the [NOK] label is present at the begginign or the report line.
For Response file the QUESTION extra XML like IDs paths are checked too - there are 2 extra lines for all QUESTION tags.


## Licence

This software is shared using the [European Union Public Licence (EUPL) version 1.2](https://joinup.ec.europa.eu/collection/eupl/eupl-text-eupl-12).
