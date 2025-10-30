# `validation` folder 

This folder contains the Schematron and XSL files that represent the Business Rules that are applied on top of UBL XSD for ESPD Documents validation.  
(_NOTE: Most of these files should be generated automatically as the result of Point 2. of Objectives automation_)

- `common/cva` - this folder contains the CVA file for code lists: 01-ESPD-codelist-values.cva
- `common/sch` - this folder contains the Schematron files that are used for common elements and structure validation: code lists values, attributes, values restrictions, criterion, and other.
- `ESPDRequest/sch` - contains specific Schmematron files for ESPD Request Business Rules: code lists values, cardinality, criterion, other, procurer, and specific. Those files are maintained by hand, except code lists values.
- `ESPDRequest/xsl` - contains the transformed Schematron files from the above folder into XSL files.
- `ESPDResponse/sch` - contains specific Schematron files for ESPD Response Business Rules: code lists values, cardinality, criterion, other, economic operator, qualification, role, and specific business rules. Those files are maintained by hand, except code lists values.
- `ESPDResponse/xsl` - contains the transformed Schematron files from the above folder into XSL files.
