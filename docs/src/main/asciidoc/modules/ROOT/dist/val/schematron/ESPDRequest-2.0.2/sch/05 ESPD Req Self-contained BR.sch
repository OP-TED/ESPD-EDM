<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/xpath-functions">
	<title>ESPD Request Self-contained Business Rules</title>
  
	<ns prefix="cac" uri="urn:X-test:UBL:Pre-award:CommonAggregate"/>
	<ns prefix="cbc" uri="urn:X-test:UBL:Pre-award:CommonBasic"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="udt" uri="urn:oasis:names:specification:ubl:schema:xsd:UnqualifiedDataTypes-2"/>
	<ns prefix="espd" uri="urn:X-test:UBL:Pre-award:QualificationApplicationRequest"/>
	<ns prefix="fn" uri="http://www.w3.org/2005/xpath-functions"/>
	
<!--
    Start of synthesis of rules from other constraints ESPD Request

    Illustration of procurer constraints - 05 ESPD Req Self-contained BR.sch
	ESPD Version: 2.0.2
-->
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-REQ-SC">
		
		<rule context="espd:QualificationApplicationRequest[cbc:QualificationApplicationTypeCode='SELFCONTAINED']">
			<!-- BR-SC-10: Information about the procurement procedure MUST be provided. -->
			<assert test="(cbc:ProcedureCode)" role="fatal" id="BR-SC-10">Information about the procurement procedure MUST be provided ('/cbc:ProcedureCode) when the type of ESPD is self-contained.</assert>
			
			<!-- BR-LOT-30-S10: The number of lots into which the procurement procedure is divided MUST be provided. Each cbc:ID must be unique. -->
			<let name="count_procurementIDs" value="count(cac:ProcurementProjectLot/cbc:ID/text())"/>
			<let name="count_equal_procurementIDs" value="count(distinct-values(cac:ProcurementProjectLot/cbc:ID/text()))"/>
			<assert test="($count_procurementIDs &lt;= 1) or ($count_equal_procurementIDs = $count_procurementIDs)" role="fatal" id="BR-LOT-30-S10">Each '/cac:ProcurementProjectLot/cbc:ID' must be unique. Currently there are '<value-of select="$count_procurementIDs - $count_equal_procurementIDs"/>' which are not unique.</assert>
		</rule>
		
		<!-- BR-LOT-40: The lots each criteria applies to MUST be provided. -->
		<rule context="cac:TenderingCriterionPropertyGroup[cbc:ID='a53561d5-6614-4dbe-987e-b96f35387f46']/cac:TenderingCriterionProperty[cbc:TypeCode='REQUIREMENT' and cbc:ValueDataTypeCode='IDENTIFIER']">
			<let name="allLots" value="/*[1]/cac:ProcurementProjectLot/cbc:ID"/>
			<let name="testLots" value="(cbc:ExpectedID) and (/*[1]/cbc:QualificationApplicationTypeCode = 'SELFCONTAINED') and count($allLots)&gt;0"/>
			<let name="currentExpectedID" value="cbc:ExpectedID"/>
			
			<let name="lotsIDs" value="/*[1]/cac:ProcurementProjectLot[cbc:ID = $currentExpectedID]/cbc:ID"/>
			
			<assert test="not($testLots) or ($testLots and count($lotsIDs)=1)" role="fatal" id="BR-LOT-40">The lots each criteria applies to MUST be provided. The lot identifier '/cbc:ExpectedID = <value-of select="cbc:ExpectedID"/>' does not exist.</assert>
		</rule>
		
		<rule context="cac:TenderingCriterion">
			<let name="isSCopen" value="(/*[1]/cbc:QualificationApplicationTypeCode = 'SELFCONTAINED') and (/*[1]/cbc:ProcedureCode != 'OPEN')"/>
			
			<!-- BR-2P-10-S10_01: For two-phased procedure with weighted criteria the information about weighting for each criteria within “Technical and professional ability” MUST be provided -->
			<let name="testWeightNumeric" value="$isSCopen and (cbc:EvaluationMethodTypeCode = 'WEIGHTED') and starts-with(cbc:CriterionTypeCode, 'CRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.')"/>			
			<assert test="not($testWeightNumeric) or  ((cbc:WeightNumeric) and ($testWeightNumeric))" role="fatal" id="BR-2P-10-S10_01">For two-phased procedure with weighted criteria, the information about weighting (cbc:WeightNumeric) for the criteria '<value-of select="cbc:CriterionTypeCode"/>' MUST be provided-</assert>
		
			<!-- BR-2P-10-S10_02: The rest of selection criteria should be always PASS/FAIL. -->
			<let name="testTechnicalCriteria" value="$isSCopen and not(starts-with(cbc:CriterionTypeCode, 'CRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.')) and (cbc:EvaluationMethodTypeCode)"/>	
			<assert test="not($testTechnicalCriteria) or (($testTechnicalCriteria) and not(cbc:EvaluationMethodTypeCode = 'WEIGHTED'))" role="fatal" id="BR-2P-10-S10_02">It is only possible to weight the "Technical and professional ability". The current criteria ('<value-of select="cbc:CriterionTypeCode"/>') should be always PASS/FAIL.</assert>
		
			<!-- BR-2P-10-S20: If evaluation method is pass/fail, weighting is not required. -->
			<let name="testPassFail" value="$isSCopen and (cbc:EvaluationMethodTypeCode != 'WEIGHTED') and not(starts-with(cbc:CriterionTypeCode, 'CRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.'))"/>	
			<assert test="not($testPassFail) or (($testPassFail) and not(cbc:WeightNumeric))" role="fatal" id="BR-2P-10-S20">If evaluation method is pass/fail, weighting is not required (see Tendering Criterion identifier '<value-of select="cbc:ID"/>').</assert>
		
		</rule>
		
	</pattern>
</schema>
