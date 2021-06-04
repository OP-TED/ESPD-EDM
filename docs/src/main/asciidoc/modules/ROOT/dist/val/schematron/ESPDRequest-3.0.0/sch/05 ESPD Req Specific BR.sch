<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fn="http://www.w3.org/2005/xpath-functions">
	<title>ESPD Request Extended Business Rules</title>

	<ns prefix="cac"
		uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
	<ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
	<ns prefix="ext"
		uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="udt" uri="urn:oasis:names:specification:ubl:schema:xsd:UnqualifiedDataTypes-2"/>
	<ns prefix="espd"
		uri="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationRequest-2"/>
	<ns prefix="fn" uri="http://www.w3.org/2005/xpath-functions"/>

	<!--
    Start of synthesis of rules from other constraints ESPD Request

    Illustration of procurer constraints - 05 ESPD Req Extended BR.sch
	ESPD Version: 3.0.0
-->

	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-REQ-SC">

		<rule context="espd:QualificationApplicationRequest">
			<!-- BR-SC-10: Information about the procurement procedure MUST be provided. -->
			<assert test="(cbc:ProcedureCode)" role="fatal" id="BR-SC-10">Information about the
				procurement procedure MUST be provided ('/cbc:ProcedureCode).</assert>

		</rule>

		<rule
			context="cac:TenderingCriterion[contains(translate('&#127;crime-org&#127;&#127;corruption&#127;&#127;fraud&#127;&#127;terr-offence&#127;&#127;finan-laund&#127;&#127;human-traffic&#127;&#127;tax-pay&#127;&#127;socsec-pay&#127;&#127;envir-law&#127;&#127;socsec-law&#127;&#127;labour-law&#127;&#127;bankruptcy&#127;&#127;insolvency&#127;&#127;cred-arran&#127;&#127;bankr-nat&#127;&#127;liq-admin&#127;&#127;susp-act&#127;&#127;prof-misconduct&#127;&#127;distorsion&#127;&#127;partic-confl&#127;&#127;prep-confl&#127;&#127;sanction&#127;&#127;misinterpr&#127;&#127;nati-ground&#127;','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('&#127;',translate(cbc:CriterionTypeCode,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'&#127;'))]">						
			<let name="allLots" value="cac:ProcurementProjectLotReference/cbc:ID"/>
			<let name="testLots" value="count($allLots) &gt; 0"/>
			
					
			<assert test="not($testLots)" role="fatal"
				id="BR-LOT-40">Lots apply only to Selection Criteria. Exclusion Criteria cannot have Lot associated.</assert>
		</rule>
		
		<rule
			context="cac:TenderingCriterion[contains(translate('&#127;prof-regist&#127;&#127;trade-regist&#127;&#127;autorisation&#127;&#127;membership&#127;&#127;gen-year-to&#127;&#127;aver-year-to&#127;&#127;spec-aver-to&#127;&#127;spec-year-to&#127;&#127;finan-rat&#127;&#127;indem-insu&#127;&#127;finan-requ&#127;&#127;work-perform&#127;&#127;supply-perform&#127;&#127;service-perform&#127;&#127;qual-cont-tech&#127;&#127;work-tech&#127;&#127;qual-facil&#127;&#127;research-fac&#127;&#127;chain-manage&#127;&#127;qualification&#127;&#127;envir-measure&#127;&#127;tech-equip&#127;&#127;spec-req-check&#127;&#127;manage-staff&#127;&#127;year-manpower&#127;&#127;suncont-port&#127;&#127;wo-autent&#127;&#127;w-autent&#127;&#127;qa-certif-inst&#127;&#127;qu-certif-indep&#127;&#127;envir-certif-indep&#127;','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('&#127;',translate(cbc:CriterionTypeCode,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'&#127;'))]">						
			<let name="allLots" value="cac:ProcurementProjectLotReference/cbc:ID"/>
			<let name="testLots" value="count($allLots) &gt; 0"/>
		
					
			<assert test="$testLots" role="fatal"
				id="BR-LOT-41">All Selection Criteria must have associated LOT.</assert>
		</rule>
		
	</pattern>
</schema>
