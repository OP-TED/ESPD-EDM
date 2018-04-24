<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<title>ESPD Request Criterion Business Rules</title>
  
	<ns prefix="cac" uri="urn:X-test:UBL:Pre-award:CommonAggregate"/>
	<ns prefix="cbc" uri="urn:X-test:UBL:Pre-award:CommonBasic"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="espd" uri="urn:X-test:UBL:Pre-award:QualificationApplicationRequest"/>
	
<!--
    Start of synthesis of rules from criterion constraints ESPD Request.

    Illustration of criterion constraints - 03 ESPD Req Criterion BR.sch
	ESPD Version: 2.0.2
-->
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-REQ-CR">
		<!-- Restrictions regarding the Exclusion criterion contraints -->
		<rule context="espd:QualificationApplicationRequest">
			<let name="current_Exclusion" value="cac:TenderingCriterion[starts-with(cbc:CriterionTypeCode, 'CRITERION.EXCLUSION.')]"/>
			<let name="applicationType" value="/*[1]/cbc:QualificationApplicationTypeCode"/>	
			
			<let name="ElementUUID_Exclusion" value="if ($applicationType!='SELFCONTAINED') then document('ESPD-CriteriaTaxonomy-REGULATED.V2.0.2.xml')//cac:TenderingCriterion[starts-with(cbc:CriterionTypeCode, 'CRITERION.EXCLUSION.')] 
				else document('ESPD-CriteriaTaxonomy-SELFCONTAINED.V2.0.2.xml')//cac:TenderingCriterion[starts-with(cbc:CriterionTypeCode, 'CRITERION.EXCLUSION.')]"/>
			
			<!-- BR-REQ-30: Exclusion Criteria -->
			<assert test="count($ElementUUID_Exclusion) &lt;= count($current_Exclusion)" flag="fatal" id="BR-REQ-30">Exclusion criteria MUST be retrieved from e-Certis. The current qualification application request has '<value-of select="count($ElementUUID_Exclusion) - count($current_Exclusion)"/>' exclusion criterion missing.</assert>
		
			<!-- BR-REQ-40: Selection criteria CAN be provided -->	
			<let name="current_Selection" value="cac:TenderingCriterion[starts-with(cbc:CriterionTypeCode, 'CRITERION.SELECTION.')]"/>		
			<assert test="count($current_Selection) != 0" flag="warning" id="BR-REQ-40">The current ESPD request does not provide selection criteria.</assert>
		</rule>
		
	</pattern>
</schema>
