# ESPD-EDM Tools  
ESPD-EMD branch contains JavaScript tools that will process Excel files associated with ESPD-EDM.

[![EUPL Licence](https://img.shields.io/badge/Licence-EUPL%20v1.2-blue.svg)](https://eupl.eu/1.2/en)

**Audience** 

This is a technical branch of ESPD-EDM repository and is intended to be used as a tool that gets as input:  
- ESPD-EDM Excel Criterion file
- Code Lists Excel file 

and processes them producing usable output files for ESPD-EDM.

## Usage

The main utility tools are in the root folder and they are build in NodeJS.

Minumum required NodeJS version: 18.X  
All libraries and commands are contained in `package.json` file - this is a standard `npm` file. All commands have to be launched in the root folder from the command line (CMD, PowerShell or any terminal) using Windows Operating System. Tools work with Linux or OS X Operating Systems too, except some of utility commands, mentioned bellow.

To setup and install all necessary JavaScript libraries:  
```npm install```

To cleanup the libraries folders (this works only under Windows):  
```npm run clean```

The folder `XSLT` contains the XSL Tranform files that were used until ESPD-EDM v4.0.0 to process and transform the Excel files.  
`XSLT/xslx-codelists-to-genericode/excel-to-gc-multilang-v1.0.xls` was used to transfor the Excel Codelists file to genericode XML files.  
`XSLT/xslx-criterion-to-UBL/ODS-Data-Structures-to-ESPD-XML/ESPDRequest-Annotated.xslt` was used to process the Excel Criterion file and produce the ESPD Request XML file, and `XSLT/xslx-criterion-to-UBL/ODS-Data-Structures-to-ESPD-XML/From-RESQUEST-to-RESDPONSE.xslt` was used to process the ESPD Request XML and produce the ESPD Response XML file.  
All auxiliary support files are in `XSLT/xslx-criterion-to-UBL/ODS-Data-Structures-to-ESPD-XML/inc` folder.  
The XSLT tools were deprecated starting with ESPD-EDM v4.0.0 and replaced by JavaScript tools. The XSLT scripts were preserved for archiving.

The folder `xslx-criterion-VBA` contains the VBA code that was used for ESPD-EDM v4.0.0 to generate the tags for each element in Excel Criterion files and to produce the XML Path like IDs. The code can only be used in conjunction with those specific Excel files.

The folder `criterion` contains Excel criterion files that are used by JavaScript tools. Those files are from corresponding tags for each ESPD-EDM release from GitHub ESPD-EDM repository.

The folder `codelists` contains Excel Codelists file that is used by JavaScript tools to process and produce genericode XML files. The Excel files belong to a specific ESPD-EDM version.

In order to run a JavaScript utility using **NodeJS**, use the command line and type the name of the utility file, e.g:  `node check.js`
For a list of avaiable commands for each tool use `--help` option: `node check.js --help`.

| Tool | Description | Commands
|---|---| --- |
| `check.js` | Tool to process and check Excel Criterion file for v4.0.0 |        **all_JSON** - Print all spreadsheets as JSON<br>**full_structures** - Print full structure of each spreadsheet <br>**each_structure** - Print the element and child structure<br>**check_tag** - Check the TAGS for each element<br>**check_UUID** - Check the XML like path IDs for each element<br>**extract_codelists** - List elements that have a Code List associated with|
| `codelist.js` | Tool to process Excel Codelists to generate genericode XML files, and downloading EU Vocabularies codelists. This uses the internal proxy for downloads, please adjust according to your network environment. | **process_code_lists** - Process Code Lists |
| `convert_to.js` | Tool to convert Excel Criterion file to other formats.  | **excel2vue** - Generate BootstrapVue components for each criteria<br>**excel2salt** - Transform Excel to PlantUML Salt UI mockups<br>**excel2treetrable** - Transform Excel to PlantUML tree table diagram|
| `excel2espd.js` | Tool to transform Excel Criterion file v3.3.0 and v4.0.0 and generate ESPD Request XML file and ESPD Response XML file | **espd_XML** - Generate ESPD Request and Response XML files |

The Excel files are specified inside each script and should be modfied accordingly.

## Licence

This software is shared using the [European Union Public Licence (EUPL) version 1.2](https://joinup.ec.europa.eu/collection/eupl/eupl-text-eupl-12).
