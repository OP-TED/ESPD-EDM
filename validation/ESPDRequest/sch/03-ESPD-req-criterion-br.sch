<?xml version="1.0" encoding="UTF-8"?>
<!--
  File: 03-ESPD-req-criterion-br.sch
  Scope: ESPD Request only
  Version: 5.0.0
  Maintenance: Manual
  Dependencies: None
  Rules: BR-REQ-30, BR-REQ-40
  Description: Validates mandatory exclusion criteria (8 criminal/tax types must be present)
               and warns if no selection criteria are provided.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<title>ESPD Request Criterion Business Rules</title>

	<ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
	<ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="espd" uri="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationRequest-2"/>

	<!--
    Start of synthesis of rules from criterion constraints ESPD Request.

    Illustration of criterion constraints - 03-ESPD-req-criterion-br.sch
	ESPD Version: 5.0.0-->

	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-REQ-CR">
		<!-- Restrictions regarding the Exclusion criterion contraints -->
		<rule context="espd:QualificationApplicationRequest">
			
			<!-- BR-REQ-30: Exclusion Criteria -->
			<assert test="cac:TenderingCriterion[cbc:CriterionTypeCode='exg-crim-part'] 
			and cac:TenderingCriterion[cbc:CriterionTypeCode='exg-crim-corrpt']
			and cac:TenderingCriterion[cbc:CriterionTypeCode='exg-crim-fraud']
			and cac:TenderingCriterion[cbc:CriterionTypeCode='exg-crim-terror']
			and cac:TenderingCriterion[cbc:CriterionTypeCode='exg-crim-laund']
			and cac:TenderingCriterion[cbc:CriterionTypeCode='exg-crim-traffick']
			and cac:TenderingCriterion[cbc:CriterionTypeCode='exg-pmt-bre-tax']
			and cac:TenderingCriterion[cbc:CriterionTypeCode='exg-pmt-bre-ssc']"
			flag="fatal" id="BR-REQ-30">Both 'Part III, A – Criminal convictions' and 'Part III and B – Payment of taxes' exclusion criterion are REQUIRED.</assert>

			<!-- BR-REQ-40: Selection criteria CAN be provided -->
			<let name="current_Selection"
				value="cac:TenderingCriterion[contains(translate('&#127;slc-suit-reg-prof&#127;&#127;slc-suit-reg-trade&#127;&#127;slc-suit-auth-mbrshp&#127;&#127;slc-suit-auth-mbrshp&#127;&#127;slc-stand-to-gen&#127;&#127;slc-stand-to-avg&#127;&#127;slc-stand-to-spec-avg&#127;&#127;slc-stand-to-spec&#127;&#127;slc-stand-ratio&#127;&#127;slc-stand-ins&#127;&#127;slc-stand-other&#127;&#127;slc-abil-ref-work&#127;&#127;slc-abil-ref-supply&#127;&#127;slc-abil-ref-services&#127;&#127;slc-abil-staff-tech-ctrl&#127;&#127;slc-abil-staff-tech-work&#127;&#127;slc-abil-mgmt-qual&#127;&#127;slc-abil-facil-res&#127;&#127;slc-abil-mgmt-supply&#127;&#127;slc-abil-staff-qual&#127;&#127;slc-abil-mgmt-env&#127;&#127;slc-abil-facil-tools&#127;&#127;slc-abil-check&#127;&#127;slc-abil-staff-yrly-no-mgmt&#127;&#127;slc-abil-staff-yrly-avg-mp&#127;&#127;slc-abil-subc&#127;&#127;slc-abil-qual-smp-wo-autent&#127;&#127;slc-abil-qual-smp-w-autent&#127;&#127;slc-abil-qual-inst&#127;&#127;slc-sche-qu-cert-indep&#127;&#127;slc-sche-env-cert-indep&#127;','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('&#127;',translate(cbc:CriterionTypeCode,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'&#127;'))]"/>						
			<assert test="count($current_Selection) != 0" flag="warning" id="BR-REQ-40">The current
				ESPD request does not provide selection criteria.</assert>

		</rule>

	</pattern>
</schema>
