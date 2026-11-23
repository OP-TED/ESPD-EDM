<?xml version="1.0" encoding="UTF-8"?>
<!--
  File: 05-ESPD-resp-role-br.sch
  Scope: ESPD Response only
  Version: 5.0.0
  Maintenance: Manual
  Dependencies: None
  Rules: BR-LEAD-10-S10, BR-LEAD-10-S20, BR-LEAD-10-S30, BR-LAED-10, BR-SUBCONT-01
  Description: Validates EO role-specific rules: group leader must provide group name
               and participant info, relied-upon entities and subcontractors must have
               responses, subcontractors don't need to answer selection criteria.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<title>ESPD Response Role Business Rules</title>
	
	<ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
	<ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="espd" uri="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationResponse-2"/>
	
<!--
    Start of synthesis of rules from role constraints ESPD Response

    Illustration of procurer constraints - 05-ESPD-resp-role-br.sch
	ESPD Version: 3.1.0
-->
	
	<xsl:key name="EOroleTest" match="cbc:RoleCode" use="." />
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-RESP-LEAD">		
		<rule context="espd:QualificationApplicationResponse">
			<!-- BR-LEAD-10-S10: Information about the group MUST be provided. -->
			<!-- If /cbc:EconomicOperatorGroupName is not implemented, a warning is thrown to inform that the ESPDResponse is going to be used as Sole tenderer and not group leader. -->
			<assert test="(count(key('EOroleTest', 'group-lead'))=1 and (exists(cbc:EconomicOperatorGroupName))) or not(count(key('EOroleTest', 'group-lead'))=1)" flag="warning" id="BR-LEAD-10-S10">The current EO role is 'group-lead', the information about the group ('/cbc:EconomicOperatorGroupName') must be provided.</assert>
			
			<!-- BR-SUBCONT-01: The entity does not have to provide information about the selection criteria If EO role is subcont (Subcontractor) -. -->
			<let name="selectionList" value="translate('&#127;slc-suit-reg-prof&#127;&#127;slc-suit-reg-trade&#127;&#127;slc-suit-auth-mbrshp&#127;&#127;slc-suit-auth-mbrshp&#127;&#127;slc-stand-to-gen&#127;&#127;slc-stand-to-avg&#127;&#127;slc-stand-to-spec-avg&#127;&#127;slc-stand-to-spec&#127;&#127;slc-stand-ratio&#127;&#127;slc-stand-ins&#127;&#127;slc-stand-other&#127;&#127;slc-abil-ref-work&#127;&#127;slc-abil-ref-supply&#127;&#127;slc-abil-ref-services&#127;&#127;slc-abil-staff-tech-ctrl&#127;&#127;slc-abil-staff-tech-work&#127;&#127;slc-abil-mgmt-qual&#127;&#127;slc-abil-facil-res&#127;&#127;slc-abil-mgmt-supply&#127;&#127;slc-abil-staff-qual&#127;&#127;slc-abil-mgmt-env&#127;&#127;slc-abil-facil-tools&#127;&#127;slc-abil-check&#127;&#127;slc-abil-staff-yrly-no-mgmt&#127;&#127;slc-abil-staff-yrly-avg-mp&#127;&#127;slc-abil-subc&#127;&#127;slc-abil-qual-smp-wo-autent&#127;&#127;slc-abil-qual-smp-w-autent&#127;&#127;slc-abil-qual-inst&#127;&#127;slc-sche-qu-cert-indep&#127;&#127;slc-sche-env-cert-indep&#127;','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
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
