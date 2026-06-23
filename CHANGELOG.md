# ESPD-EDM 5.0.0-alpha.2 Release Notes

This release aligns with ePO model and with eForms from criterion code lists.

The data model is migrated from Excel to JSON allowing seamless integration development tools for ESPD Service implementors.

Main new features:
- Enterprise Architect (EA) model centered redesign
- Harmonisation with eCertis UUIDs

GitHub issues

* **Fix GitHub issue #356** (reopened)
  * Inconsistency between eCertis and ESPD

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
- ResponseDataType codelist list of datatypes is incomplete
- Code list 'docrefcontent-type' - update

### Validation - Interoperability Testbed
- Update Schematron validation to align with code lists changes
- Update Schematron Business Rules for ESPD validation - ONGOING

### Online documentation
- Update business - index.adoc
- Update ROOT section pages - ONGOING
- Update technical section - ONGOING
- Replace images with diagram as code
