<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<title>ESPD Request Criterion Business Rules</title>

	<ns prefix="cac"
		uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
	<ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
	<ns prefix="ext"
		uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="espd"
		uri="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationRequest-2"/>

	<!--
    Start of synthesis of rules from criterion constraints ESPD Request.

    Illustration of criterion constraints - 03 ESPD Req Criterion BR.sch
	ESPD Version: 3.0.0
-->

	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-REQ-CR">
		<!-- Restrictions regarding the Exclusion criterion contraints -->
		<rule context="espd:QualificationApplicationRequest">
			
			<!-- BR-REQ-30: Exclusion Criteria -->
			<assert test="cac:TenderingCriterion[cbc:CriterionTypeCode='crime-org'] 
			and cac:TenderingCriterion[cbc:CriterionTypeCode='corruption']
			and cac:TenderingCriterion[cbc:CriterionTypeCode='fraud']
			and cac:TenderingCriterion[cbc:CriterionTypeCode='terr-offence']
			and cac:TenderingCriterion[cbc:CriterionTypeCode='finan-laund']
			and cac:TenderingCriterion[cbc:CriterionTypeCode='human-traffic']
			and cac:TenderingCriterion[cbc:CriterionTypeCode='tax-pay']
			and cac:TenderingCriterion[cbc:CriterionTypeCode='socsec-pay']"
			flag="fatal" id="BR-REQ-30">Both 'Part III, A – Criminal convictions' and 'Part III and B – Payment of taxes' exclusion criterion are REQUIRED.</assert>

			<!-- BR-REQ-40: Selection criteria CAN be provided -->
			<let name="current_Selection"
				value="cac:TenderingCriterion[contains(translate('&#127;prof-regist&#127;&#127;trade-regist&#127;&#127;autorisation&#127;&#127;membership&#127;&#127;gen-year-to&#127;&#127;aver-year-to&#127;&#127;spec-aver-to&#127;&#127;spec-year-to&#127;&#127;finan-rat&#127;&#127;indem-insu&#127;&#127;finan-requ&#127;&#127;work-perform&#127;&#127;supply-perform&#127;&#127;service-perform&#127;&#127;qual-cont-tech&#127;&#127;work-tech&#127;&#127;qual-facil&#127;&#127;research-fac&#127;&#127;chain-manage&#127;&#127;qualification&#127;&#127;envir-measure&#127;&#127;tech-equip&#127;&#127;spec-req-check&#127;&#127;manage-staff&#127;&#127;year-manpower&#127;&#127;suncont-port&#127;&#127;wo-autent&#127;&#127;w-autent&#127;&#127;qa-certif-inst&#127;&#127;qu-certif-indep&#127;&#127;envir-certif-indep&#127;','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('&#127;',translate(cbc:CriterionTypeCode,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'&#127;'))]"/>						
			<assert test="count($current_Selection) != 0" flag="warning" id="BR-REQ-40">The current
				ESPD request does not provide selection criteria.</assert>

		</rule>

	</pattern>
</schema>
