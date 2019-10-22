<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/xpath-functions">
	<title>ESPD Response Self-contained Business Rules</title>
  
	<ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
	<ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="udt" uri="urn:oasis:names:specification:ubl:schema:xsd:UnqualifiedDataTypes-2"/>
	<ns prefix="espd" uri="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationResponse-2"/>
	<ns prefix="fn" uri="http://www.w3.org/2005/xpath-functions"/>
	
<!--
    Start of synthesis of rules from other constraints ESPD Response

    Illustration of procurer constraints - 05 ESPD Resp Self-contained BR.sch
	ESPD Version: 2.1.0
-->
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-RESP-SC">
		
		<rule context="cac:TenderingCriterionResponse/cac:ResponseValue">
			<!-- BR-LOT-10: The list of lots the EO tenders for MUST be provided. Only if it is self-contained. -->
			<let name="ppLot" value="/*[1]/cac:ProcurementProjectLot/cbc:ID"/>
			<let name="isSC" value="/*[1]/cbc:QualificationApplicationTypeCode = 'SELFCONTAINED'"/>
			<let name="TC_lot_ID" value="/*[1]/cac:TenderingCriterion[cbc:CriterionTypeCode = 'CRITERION.OTHER.EO_DATA.LOTS_TENDERED']/cac:TenderingCriterionPropertyGroup[cbc:ID='289f39b3-2a15-421a-8050-a29858031f35']/cac:TenderingCriterionProperty/cbc:ID"/>
			<let name="doTest" value="$isSC and $TC_lot_ID  and ancestor::*[1]/cbc:ValidatedCriterionPropertyID = $TC_lot_ID"/>
			
			<assert test="not($doTest) or ($doTest and cbc:ResponseID = $ppLot)" flag="fatal" id="BR-LOT-10">The list of lots the EO tenders for MUST be provided. The lot '<value-of select="cbc:ResponseID"/>' does not exist.</assert>
			
		</rule>
		
	</pattern>
</schema>
