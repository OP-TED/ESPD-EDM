# ESPD-EDM 5.0.0 Release Notes

This release aligns with ePO model and with eFroms from criterion code lists.

The criterion is migrated from Excel to JSON allowing seeamles integration development tools for ESPD Service implementors.

Main new features:
- Enterprise Architect model centered redesign
- eCertis UUIDs alignment with ESPD

GitHub issues

* **Fix GitHub issue #423**
  * Mapping the SubContractor to the Tenderer

* **Fix GitHub issue #422**
   * Purely national Exclusion Ground - dynamic structure

* **Fix GitHub issue #386**
   * Can the evidence group or subgroup be dropped to follow the ESPD regulation?

* **Fix GitHub issue #424**
   * Where could we find translations for SUBCRITERIONs descriptions

* **Fix GitHub issue #413**
   * Investigate the official list and certificate in the ESPD-EDM OTHER-EO-PQS sheet 

### ESPD-EDM Criterion files - Data Structure 
- Create JSON schema to validate EA exports
- eCertis UUIDs alignment with ESPD
- Update to new version of EG and SC code lists
- Uniformity of descriptions for QUESTION objects
- Potential cardinality inconsistencies
- Missing SUBCRITERION block (EG C24 and SC C34)
- Missing REQUIREMENT_GROUP block (SC C51, C52 and C53)

### Code lists
- Replace Criterion code list with Exclusion Grounds and Selection Criterion code lists
- ResponseDataType codelist list of datatypes is incomplete
- Code list 'docrefcontent-type' - update

### Validation - Interoperability Testbed
- Update Schematron Business Rules for ESPD validation
- Wrong values in //cac:TenderingCriterion/cbc:Name for C41 in XML examples

### Online documentation
- Update business - index.adoc
- Update ROOT section pages
- Update technical section
- Replace images with diagram as code
