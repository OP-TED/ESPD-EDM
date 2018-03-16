<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<title>ESPD Response Lead Role Business Rules</title>
  
	<ns prefix="cac" uri="urn:X-test:UBL:Pre-award:CommonAggregate"/>
	<ns prefix="cbc" uri="urn:X-test:UBL:Pre-award:CommonBasic"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="espd" uri="urn:X-test:UBL:Pre-award:QualificationApplicationResponse"/>
	
<!--
    Start of synthesis of rules from lead role constraints ESPD Response

    Illustration of procurer constraints - 05 ESPD Resp Lead BR.sch
	ESPD Version: 2.0.2
-->
	
    <xsl:key name="EORoleTest" match="cbc:RoleCode" use="." />
	<xsl:key name="CriterionResponseType" match="cac:TenderingCriterionResponse" use="cbc:ValidatedCriterionPropertyID"/>
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-RESP-LEAD">
		
		<rule context="espd:QualificationApplicationResponse">
			<!-- If /cbc:EconomicOperatorGroupName is not implemented, a warning is thrown to inform that the ESPDResponse is going to be used as Sole contractor and not lead entity. -->
			<assert test="(count(key('EORoleTest', 'SCLE'))=1 and (cbc:EconomicOperatorGroupName)) or not(count(key('EORoleTest', 'SCLE'))=1)" role="warning">The current EO role is 'SCLE', as the group name element ('/cbc:EconomicOperatorGroupName') is not implemented, the ESPDResponse is going to be executed as a Sole Contractor role.</assert>
			
			<!-- Information about the other participants MUST be provided. -->
			<let name="togetherCriterion" value="cac:TenderingCriterion[ starts-with(cbc:CriterionTypeCode, 'CRITERION.OTHER.EO_DATA.TOGETHER_WITH_OTHERS') ]"/>
			<let name="togetherCriterionResponse" value="cac:TenderingCriterion[ starts-with(cbc:CriterionTypeCode, 'CRITERION.OTHER.EO_DATA.TOGETHER_WITH_OTHERS') and not(count( key('CriterionResponseType', cac:TenderingCriterionPropertyGroup[1]/cac:TenderingCriterionProperty[1]/cbc:ID) ) = 0) ]"/>
			
			<assert test="( count(key('EORoleTest', 'SCLE'))=1 and (count($togetherCriterionResponse) = count($togetherCriterion)) ) or not(count(key('EORoleTest', 'SCLE'))=1)" flag="error">Information about the other participants MUST be provided (criteria 'CRITERION.OTHER.EO_DATA.TOGETHER_WITH_OTHERS').</assert>
			
			<!-- Information about all the entities the EO relies on MUST be provided -->
			<let name="relyCriterion" value="cac:TenderingCriterion[ starts-with(cbc:CriterionTypeCode, 'CRITERION.OTHER.EO_DATA.RELIES_ON_OTHER_CAPACITIES') ]"/>
			<let name="relyCriterionResponse" value="cac:TenderingCriterion[ starts-with(cbc:CriterionTypeCode, 'CRITERION.OTHER.EO_DATA.RELIES_ON_OTHER_CAPACITIES') and not(count( key('CriterionResponseType', cac:TenderingCriterionPropertyGroup[1]/cac:TenderingCriterionProperty[1]/cbc:ID) ) = 0) ]"/>
			
			<assert test="( count(key('EORoleTest', 'SCLE'))=1 and (count($relyCriterionResponse) = count($relyCriterion)) ) or not(count(key('EORoleTest', 'SCLE'))=1)" flag="error">Information about all the entities the EO relies on MUST be provided (criteria 'CRITERION.OTHER.EO_DATA.RELIES_ON_OTHER_CAPACITIES').</assert>
			
			<!-- Information about all subcontractors MUST be provided. -->
			<let name="subcontractorCriterion" value="cac:TenderingCriterion[ starts-with(cbc:CriterionTypeCode, 'CRITERION.OTHER.EO_DATA.SUBCONTRACTS_WITH_THIRD_PARTIES') ]"/>
			<let name="subcontractorResponse" value="cac:TenderingCriterion[ starts-with(cbc:CriterionTypeCode, 'CRITERION.OTHER.EO_DATA.SUBCONTRACTS_WITH_THIRD_PARTIES') and not(count( key('CriterionResponseType', cac:TenderingCriterionPropertyGroup[1]/cac:TenderingCriterionProperty[1]/cbc:ID) ) = 0) ]"/>
			
			<assert test="( count(key('EORoleTest', 'SCLE'))=1 and (count($subcontractorResponse) = count($subcontractorCriterion)) ) or not(count(key('EORoleTest', 'SCLE'))=1)" flag="error">Information about all the entities the EO relies on MUST be provided (criteria 'CRITERION.OTHER.EO_DATA.SUBCONTRACTS_WITH_THIRD_PARTIES').</assert>
		</rule>
		
	</pattern>
</schema>
