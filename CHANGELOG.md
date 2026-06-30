# ESPD-EDM 5.0.0-beta Release Notes

The release v5.0.0 and its corresponding technical files can be found in [ESPD-EDM](https://github.com/OP-TED/ESPD-EDM).

This release aligns with ePO model and with eForms from criterion code lists.

The data model is migrated from Excel to JSON allowing seamless integration development tools for ESPD Service implementors.

Main new features:
- Enterprise Architect (EA) model centered redesign
- Replaced Criterion code list with Exclusion Ground and Selection Criterion code lists
- Harmonisation with eCertis UUIDs
- GitHub restructuring

GitHub issues

* **Fix GitHub issue #356** (reopened)
  * Inconsistency between eCertis and ESPD

* **Fix GitHub issue #386**
   * Can the evidence group or subgroup be dropped to follow the ESPD regulation?

* **Fix GitHub issue #413**
   * Investigate the official list and certificate in the ESPD-EDM OTHER-EO-PQS sheet 

* **Fix GitHub issue #422**
   * Purely national Exclusion Ground - dynamic structure

* **Fix GitHub issue #423**
  * Mapping the SubContractor to the Tenderer

* **Fix GitHub issue #424**
   * Where could we find translations for SUBCRITERIONs descriptions

### ESPD-EDM Criterion files - Data Structure 
- Created JSON schema to validate EA exports
- eCertis UUIDs harmonisation with ESPD-EDM
- Update to new version of Exclusion Ground (EG) and Selection Criterion (SC) code lists
- Uniformity of descriptions for QUESTION objects
- Missing SUBCRITERION block (EG C24 and SC C34)
- Missing REQUIREMENT_GROUP block (SC C51, C52 and C53)
- Deprecated SC "authorisation" (C27) and "membership" (C28)
- Added EG "exg-mis-unrel-sec" (C67) and SC "slc-suit-auth-mbrshp" (C66)

### UBL 2.4
- UBL 2.4 distribution files updated. The folder ubl-2.4 contains the official distribution files from OASIS - UBL Project
 
### Code lists
- Replaced Criterion code list with Exclusion Ground and Selection Criterion code lists
- The [codelists.json](https://github.com/OP-TED/ESPD-EDM/tree/v5.0.0/codelists/codelists.json) file provides a machine-readable reference of all code lists used by the ESPD-EDM, including their identifiers, versions, and the agency responsible for their maintenance

### Validation - Interoperability Testbed
- Update Schematron validation to align with code lists changes
- Update Schematron Business Rules for ESPD validation - ONGOING

### Online documentation
The full documentation for v5.0.0 can be found on the [TED Documentation ESPD V5.0.0 site](https://docs.ted.europa.eu/ESPD-EDM/4.0.0/index.html).
- Replaced diagram images with code-generated diagrams and updated their content
- Updated technical section
- Update business section
