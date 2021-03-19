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
	ESPD Version: 3.0.0
-->
	
	<xsl:key name="EOroleTest" match="cbc:RoleCode" use="." />
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-RESP-LEAD">		
		<rule context="espd:QualificationApplicationResponse">
			<!-- BR-LEAD-10-S10: Information about the group MUST be provided. -->
			<!-- If /cbc:EconomicOperatorGroupName is not implemented, a warning is thrown to inform that the ESPDResponse is going to be used as Sole tenderer and not group leader. -->
			<assert test="(count(key('EOroleTest', 'group-lead'))=1 and (exists(cbc:EconomicOperatorGroupName))) or not(count(key('EOroleTest', 'group-lead'))=1)" flag="warning" id="BR-LEAD-10-S10">The current EO role is 'group-lead', the information about the group ('/cbc:EconomicOperatorGroupName') must be provided.</assert>
			
			<!-- BR-SUBCONT-01: The entity does not have to provide information about the selection criteria If EO role is subcont (Subcontractor) -. -->
			<let name="selectionList" value="translate('&#127;prof-regist&#127;&#127;trade-regist&#127;&#127;autorisation&#127;&#127;membership&#127;&#127;gen-year-to&#127;&#127;aver-year-to&#127;&#127;spec-aver-to&#127;&#127;spec-year-to&#127;&#127;finan-rat&#127;&#127;indem-insu&#127;&#127;finan-requ&#127;&#127;work-perform&#127;&#127;supply-perform&#127;&#127;service-perform&#127;&#127;qual-cont-tech&#127;&#127;work-tech&#127;&#127;qual-facil&#127;&#127;research-fac&#127;&#127;chain-manage&#127;&#127;qualification&#127;&#127;envir-measure&#127;&#127;tech-equip&#127;&#127;spec-req-check&#127;&#127;manage-staff&#127;&#127;year-manpower&#127;&#127;suncont-port&#127;&#127;wo-autent&#127;&#127;w-autent&#127;&#127;qa-certif-inst&#127;&#127;qu-certif-indep&#127;&#127;envir-certif-indep&#127;','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
			<let name="currentSelection"
				value="cac:TenderingCriterion[contains($selectionList,concat('&#127;',translate(cbc:CriterionTypeCode,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'&#127;'))]"/>
			<let name="selectionResponse" value="cac:TenderingCriterionResponse[ cbc:ValidatedCriterionPropertyID = $currentSelection]"/>
			
			<assert test="(count(key('EOroleTest', 'subcont'))=1 and (count($selectionResponse) = 0 )) or not(count(key('EOroleTest', 'subcont'))=1)" flag="warning" id="BR-SUBCONT-01">If EO role is 'subcont - Subcontractor', the entity does not have to provide information about the selection criteria.</assert>
		</rule>
		
		<rule context="cac:TenderingCriterion[ starts-with(cbc:CriterionTypeCode, 'eo-group') ]">
			<!-- BR-LAED-10: When the EO is participating in the procurement procedure together with others, information about the other participants MUST be provided -->
			<!-- Information about the other participants MUST be provided. -->
			<let name="togetherCriterion" value="cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty/cbc:ID"/>
			<let name="togetherCriterionResponse" value="/*[1]/cac:TenderingCriterionResponse[ cbc:ValidatedCriterionPropertyID = $togetherCriterion ]"/>
			
			<assert test="( count(key('EOroleTest', 'group-lead'))=1 and (count($togetherCriterionResponse) &gt; 0) ) or not(count(key('EOroleTest', 'group-lead'))=1)" flag="fatal" id="BR-LAED-10">Information about the other participants MUST be provided (criteria 'eo-group').</assert>
		</rule>
		
		<rule context="cac:TenderingCriterion[ starts-with(cbc:CriterionTypeCode, 'relied') ]">
			<!-- BR-LEAD-10-S20: Information about all the entities the EO relies on MUST be provided -->
			<let name="relyCriterion" value="cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty/cbc:ID"/>
			<let name="relyCriterionResponse" value="/*[1]/cac:TenderingCriterionResponse[ cbc:ValidatedCriterionPropertyID = $relyCriterion ]"/>
			
			<assert test="( count(key('EOroleTest', 'group-lead'))=1 and (count($relyCriterionResponse) &gt; 0) ) or not(count(key('EOroleTest', 'group-lead'))=1)" flag="fatal" id="BR-LEAD-10-S20">Information about all the entities the EO relies on MUST be provided (criteria 'relied').</assert>
		</rule>
		
		<rule context="cac:TenderingCriterion[ starts-with(cbc:CriterionTypeCode, 'subco-ent') ]">
			<!-- BR-LEAD-10-S30: Information about all subcontractors MUST be provided -->
			<let name="subcontractorCriterion" value="cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty/cbc:ID"/>
			<let name="subcontractorResponse" value="/*[1]/cac:TenderingCriterionResponse[ cbc:ValidatedCriterionPropertyID = $subcontractorCriterion ]"/>
			
			<assert test="( count(key('EOroleTest', 'group-lead'))=1 and (count($subcontractorResponse) &gt; 0) ) or not(count(key('EOroleTest', 'group-lead'))=1)" flag="fatal" id="BR-LEAD-10-S30">Information about all the entities the EO relies on MUST be provided (criteria 'subco-ent').</assert>
		</rule>
		
	</pattern>
</schema>
