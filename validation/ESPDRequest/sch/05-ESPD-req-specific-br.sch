<?xml version="1.0" encoding="UTF-8"?>
<!--
  File: 05-ESPD-req-specific-br.sch
  Scope: ESPD Request only
  Version: 5.0.0
  Maintenance: Manual
  Dependencies: None
  Rules: BR-SC-10, BR-LOT-40, BR-LOT-41
  Description: ESPD Request-specific rules: procurement procedure code is mandatory,
               exclusion criteria cannot have lots, selection criteria must have lots.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fn="http://www.w3.org/2005/xpath-functions">
	<title>ESPD Request Business Rules</title>

	<ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
	<ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="espd" uri="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationRequest-2"/>
	<ns prefix="fn" uri="http://www.w3.org/2005/xpath-functions"/>

	<!--
    Start of synthesis of rules from other constraints ESPD Request

    Illustration of procurer constraints - 05-ESPD-req-specific-br.sch
	ESPD Version: 5.0.0
-->

	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-REQ-SC">

		<rule context="espd:QualificationApplicationRequest">
			<!-- BR-SC-10: Information about the procurement procedure MUST be provided. -->
			<assert test="(cbc:ProcedureCode)" role="fatal" id="BR-SC-10">Information about the
				procurement procedure MUST be provided ('/cbc:ProcedureCode).</assert>

		</rule>

		<rule
			context="cac:TenderingCriterion[contains(translate('&#127;exg-crim-part&#127;&#127;exg-crim-corrpt&#127;&#127;exg-crim-fraud&#127;&#127;exg-crim-terror&#127;&#127;exg-crim-laund&#127;&#127;exg-crim-traffick&#127;&#127;exg-pmt-bre-tax&#127;&#127;exg-pmt-bre-ssc&#127;&#127;exg-mis-bre-env-law&#127;&#127;exg-mis-bre-soc-law&#127;&#127;exg-mis-bre-lab-law&#127;&#127;exg-sitn-bankr&#127;&#127;exg-sitn-insolvency&#127;&#127;exg-sitn-cred-arran&#127;&#127;exg-sitn-other&#127;&#127;exg-sitn-liq-admin&#127;&#127;exg-sitn-as-susp&#127;&#127;exg-mis-misconduct&#127;&#127;exg-mis-distortion&#127;&#127;exg-mis-partic-confl&#127;&#127;exg-mis-prep-confl&#127;&#127;exg-mis-sanction&#127;&#127;exg-mis-misrepresent&#127;&#127;exg-natl-bre-nat-law&#127;','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('&#127;',translate(cbc:CriterionTypeCode,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'&#127;'))]">						
			<let name="allLots" value="cac:ProcurementProjectLotReference/cbc:ID"/>
			<let name="testLots" value="count($allLots) &gt; 0"/>
			
					
			<assert test="not($testLots)" role="fatal"
				id="BR-LOT-40">Lots apply only to Selection Criteria. Exclusion Criteria cannot have Lot associated.</assert>
		</rule>
		
		<rule
			context="cac:TenderingCriterion[contains(translate('&#127;slc-suit-reg-prof&#127;&#127;slc-suit-reg-trade&#127;&#127;slc-suit-auth-mbrshp&#127;&#127;slc-suit-auth-mbrshp&#127;&#127;slc-stand-to-gen&#127;&#127;slc-stand-to-avg&#127;&#127;slc-stand-to-spec-avg&#127;&#127;slc-stand-to-spec&#127;&#127;slc-stand-ratio&#127;&#127;slc-stand-ins&#127;&#127;slc-stand-other&#127;&#127;slc-abil-ref-work&#127;&#127;slc-abil-ref-supply&#127;&#127;slc-abil-ref-services&#127;&#127;slc-abil-staff-tech-ctrl&#127;&#127;slc-abil-staff-tech-work&#127;&#127;slc-abil-mgmt-qual&#127;&#127;slc-abil-facil-res&#127;&#127;slc-abil-mgmt-supply&#127;&#127;slc-abil-staff-qual&#127;&#127;slc-abil-mgmt-env&#127;&#127;slc-abil-facil-tools&#127;&#127;slc-abil-check&#127;&#127;slc-abil-staff-yrly-no-mgmt&#127;&#127;slc-abil-staff-yrly-avg-mp&#127;&#127;slc-abil-subc&#127;&#127;slc-abil-qual-smp-wo-autent&#127;&#127;slc-abil-qual-smp-w-autent&#127;&#127;slc-abil-qual-inst&#127;&#127;slc-sche-qu-cert-indep&#127;&#127;slc-sche-env-cert-indep&#127;','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('&#127;',translate(cbc:CriterionTypeCode,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'&#127;'))]">						
			<let name="allLots" value="cac:ProcurementProjectLotReference/cbc:ID"/>
			<let name="testLots" value="count($allLots) &gt; 0"/>
		
					
			<assert test="$testLots" role="fatal"
				id="BR-LOT-41">All Selection Criteria must have associated LOT.</assert>
		</rule>
		
	</pattern>
</schema>
