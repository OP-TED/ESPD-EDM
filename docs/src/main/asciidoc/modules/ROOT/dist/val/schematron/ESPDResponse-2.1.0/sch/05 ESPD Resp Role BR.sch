<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<title>ESPD Response Role Business Rules</title>
	
	<ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
	<ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="espd" uri="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationResponse-2"/>
	
<!--
    Start of synthesis of rules from role constraints ESPD Response

    Illustration of procurer constraints - 05 ESPD Resp Role BR.sch
	ESPD Version: 2.1.0
-->
	
	<xsl:key name="EOroleTest" match="cbc:RoleCode" use="." />
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-RESP-LEAD">		
		<rule context="espd:QualificationApplicationResponse">
			<!-- BR-LEAD-10-S10: Information about the group MUST be provided. -->
			<!-- If /cbc:EconomicOperatorGroupName is not implemented, a warning is thrown to inform that the ESPDResponse is going to be used as Sole contractor and not lead entity. -->
			<assert test="(count(key('EOroleTest', 'LE'))=1 and (exists(cbc:EconomicOperatorGroupName))) or not(count(key('EOroleTest', 'LE'))=1)" flag="warning" id="BR-LEAD-10-S10">The current EO role is 'LE', the information about the group ('/cbc:EconomicOperatorGroupName') must be provided.</assert>
			
			<!-- BR-OENRON-01: The entity does not have to provide information about the selection criteria If EO role is OENRON - Other entity (not relied upon) -. -->
			<let name="selectionCriterion" value="cac:TenderingCriterion[ starts-with(cbc:CriterionTypeCode, 'CRITERION.SELECTION.') ]/cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty/cbc:ID"/>
			<let name="selectionResponse" value="cac:TenderingCriterionResponse[ cbc:ValidatedCriterionPropertyID = $selectionCriterion ]"/>
			
			<assert test="(count(key('EOroleTest', 'OENRON'))=1 and (count($selectionResponse) = 0 )) or not(count(key('EOroleTest', 'OENRON'))=1)" flag="warning" id="BR-OENRON-01">If EO role is 'OENRON - Other entity (not relied upon)', the entity does not have to provide information about the selection criteria.</assert>
		</rule>
		
		<rule context="cac:TenderingCriterion[ starts-with(cbc:CriterionTypeCode, 'CRITERION.OTHER.EO_DATA.TOGETHER_WITH_OTHERS') ]">
			<!-- BR-LAED-10: When the EO is participating in the procurement procedure together with others, information about the other participants MUST be provided -->
			<!-- Information about the other participants MUST be provided. -->
			<let name="togetherCriterion" value="cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty/cbc:ID"/>
			<let name="togetherCriterionResponse" value="/*[1]/cac:TenderingCriterionResponse[ cbc:ValidatedCriterionPropertyID = $togetherCriterion ]"/>
			
			<assert test="( count(key('EOroleTest', 'LE'))=1 and (count($togetherCriterionResponse) &gt; 0) ) or not(count(key('EOroleTest', 'LE'))=1)" flag="fatal" id="BR-LAED-10">Information about the other participants MUST be provided (criteria 'CRITERION.OTHER.EO_DATA.TOGETHER_WITH_OTHERS').</assert>
		</rule>
		
		<rule context="cac:TenderingCriterion[ starts-with(cbc:CriterionTypeCode, 'CRITERION.OTHER.EO_DATA.RELIES_ON_OTHER_CAPACITIES') ]">
			<!-- BR-LEAD-10-S20: Information about all the entities the EO relies on MUST be provided -->
			<let name="relyCriterion" value="cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty/cbc:ID"/>
			<let name="relyCriterionResponse" value="/*[1]/cac:TenderingCriterionResponse[ cbc:ValidatedCriterionPropertyID = $relyCriterion ]"/>
			
			<assert test="( count(key('EOroleTest', 'LE'))=1 and (count($relyCriterionResponse) &gt; 0) ) or not(count(key('EOroleTest', 'LE'))=1)" flag="fatal" id="BR-LEAD-10-S20">Information about all the entities the EO relies on MUST be provided (criteria 'CRITERION.OTHER.EO_DATA.RELIES_ON_OTHER_CAPACITIES').</assert>
		</rule>
		
		<rule context="cac:TenderingCriterion[ starts-with(cbc:CriterionTypeCode, 'CRITERION.OTHER.EO_DATA.SUBCONTRACTS_WITH_THIRD_PARTIES') ]">
			<!-- BR-LEAD-10-S30: Information about all subcontractors MUST be provided -->
			<let name="subcontractorCriterion" value="cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty/cbc:ID"/>
			<let name="subcontractorResponse" value="/*[1]/cac:TenderingCriterionResponse[ cbc:ValidatedCriterionPropertyID = $subcontractorCriterion ]"/>
			
			<assert test="( count(key('EOroleTest', 'LE'))=1 and (count($subcontractorResponse) &gt; 0) ) or not(count(key('EOroleTest', 'LE'))=1)" flag="fatal" id="BR-LEAD-10-S30">Information about all the entities the EO relies on MUST be provided (criteria 'CRITERION.OTHER.EO_DATA.SUBCONTRACTS_WITH_THIRD_PARTIES').</assert>
		</rule>
		
	</pattern>
</schema>
