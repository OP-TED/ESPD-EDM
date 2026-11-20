<?xml version="1.0" encoding="UTF-8"?>
<!--
  File: 05-ESPD-resp-qualification-br.sch
  Scope: ESPD Response only
  Version: 5.0.0
  Maintenance: Manual
  Dependencies: None
  Rules: BR-RESP-40, BR-RESP-80-S10, BR-RESP-80-S20
  Description: Validates rules related to pre-qualification systems: selection criteria
               responses are required unless the EO is registered on a system that covers them.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<title>ESPD Response pre-qualification system Business Rules</title>
  
	<ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
	<ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="espd" uri="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationResponse-2"/>
	
<!--
    Start of synthesis of rules from pre-qualification system ESPD Response

    Illustration of procurer constraints - 05-ESPD-resp-qualification-br.sch
	ESPD Version: 5.0.0
-->
    <xsl:key name="EOrole" match="cbc:RoleCode" use="." />
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-RESP-QUAL">
		
		<rule context="espd:QualificationApplicationResponse">
			<!-- Common variables -->
			<let name="isPQS" value="(cac:EconomicOperatorParty/cac:QualifyingParty/cac:Party/cac:PartyIdentification/cbc:ID)"/>
			<let name="issubcont" value="count(key('EOrole', 'subcont'))=1"/>
			<let name="allResponses" value="cac:TenderingCriterionResponse/cbc:ValidatedCriterionPropertyID"/>
			
			<!-- BR-RESP-30: Information about compliance of exclusion grounds MUST be provided - when not registered pre-qualification system. -->
			
			<let name="exclusionList" value="translate('&#127;exg-crim-part&#127;&#127;exg-crim-corrpt&#127;&#127;exg-crim-fraud&#127;&#127;exg-crim-terror&#127;&#127;exg-crim-laund&#127;&#127;exg-crim-traffick&#127;&#127;exg-pmt-bre-tax&#127;&#127;exg-pmt-bre-ssc&#127;&#127;exg-mis-bre-env-law&#127;&#127;exg-mis-bre-soc-law&#127;&#127;exg-mis-bre-lab-law&#127;&#127;exg-sitn-bankr&#127;&#127;exg-sitn-insolvency&#127;&#127;exg-sitn-cred-arran&#127;&#127;exg-sitn-other&#127;&#127;exg-sitn-liq-admin&#127;&#127;exg-sitn-as-susp&#127;&#127;exg-mis-misconduct&#127;&#127;exg-mis-distortion&#127;&#127;exg-mis-partic-confl&#127;&#127;exg-mis-prep-confl&#127;&#127;exg-mis-sanction&#127;&#127;exg-mis-misrepresent&#127;&#127;exg-natl-bre-nat-law&#127;','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
			
			<let name="selectionList" value="translate('&#127;slc-suit-reg-prof&#127;&#127;slc-suit-reg-trade&#127;&#127;slc-suit-auth-mbrshp&#127;&#127;slc-suit-auth-mbrshp&#127;&#127;slc-stand-to-gen&#127;&#127;slc-stand-to-avg&#127;&#127;slc-stand-to-spec-avg&#127;&#127;slc-stand-to-spec&#127;&#127;slc-stand-ratio&#127;&#127;slc-stand-ins&#127;&#127;slc-stand-other&#127;&#127;slc-abil-ref-work&#127;&#127;slc-abil-ref-supply&#127;&#127;slc-abil-ref-services&#127;&#127;slc-abil-staff-tech-ctrl&#127;&#127;slc-abil-staff-tech-work&#127;&#127;slc-abil-mgmt-qual&#127;&#127;slc-abil-facil-res&#127;&#127;slc-abil-mgmt-supply&#127;&#127;slc-abil-staff-qual&#127;&#127;slc-abil-mgmt-env&#127;&#127;slc-abil-facil-tools&#127;&#127;slc-abil-check&#127;&#127;slc-abil-staff-yrly-no-mgmt&#127;&#127;slc-abil-staff-yrly-avg-mp&#127;&#127;slc-abil-subc&#127;&#127;slc-abil-qual-smp-wo-autent&#127;&#127;slc-abil-qual-smp-w-autent&#127;&#127;slc-abil-qual-inst&#127;&#127;slc-sche-qu-cert-indep&#127;&#127;slc-sche-env-cert-indep&#127;','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
			
			<let name="currentExclusion"
				value="cac:TenderingCriterion[contains($exclusionList,concat('&#127;',translate(cbc:CriterionTypeCode,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'&#127;'))]"/>
			<let name="exclusionResponses" value="$currentExclusion[cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty[cbc:ID = $allResponses and cbc:TypeCode='QUESTION']]/cbc:CriterionTypeCode"/>
			<let name="exclusionReqResponses" value="$currentExclusion[cac:TenderingCriterionPropertyGroup[cac:TenderingCriterionProperty[cbc:TypeCode='REQUIREMENT'] 
				and cac:SubsidiaryTenderingCriterionPropertyGroup/cac:TenderingCriterionProperty[cbc:ID = $allResponses and cbc:TypeCode='QUESTION'] ]]/cbc:CriterionTypeCode"/>
			<let name="exclusionNotResponses" value="$currentExclusion[cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty[not(cbc:ID = $allResponses) and cbc:TypeCode='QUESTION']]/cbc:CriterionTypeCode/text()"/>
			<let name="exclusionNotReqResponses" value="$currentExclusion[cac:TenderingCriterionPropertyGroup[cac:TenderingCriterionProperty[cbc:TypeCode='REQUIREMENT'] 
				and cac:SubsidiaryTenderingCriterionPropertyGroup/cac:TenderingCriterionProperty[not(cbc:ID = $allResponses) and cbc:TypeCode='QUESTION'] ]]/cbc:CriterionTypeCode"/>

			<!-- This BR should be redesigned in the context of v5.0.0 there was a change in the specific criterion concerning registration in a national pre-qualifiication system -->
			<!--
			<assert test="($isPQS) or(not($isPQS) and (count($currentExclusion) = (count($exclusionResponses) + count($exclusionReqResponses))) )" flag="fatal" id="BR-RESP-30">Information about compliance of exclusion grounds MUST be provided. The following exclusion criterion are not provided: <value-of select="$exclusionNotResponses"/>, <value-of select="$exclusionNotReqResponses"/></assert>
		    -->

			<!-- BR-RESP-40: Information about compliance of selection criteria MUST be provided - when not registered pre-qualification system and role different to subcont -->
			<let name="currentSelection"
				value="cac:TenderingCriterion[contains($selectionList,concat('&#127;',translate(cbc:CriterionTypeCode,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'&#127;'))]"/>
			<let name="selectionResponses" value="$currentSelection[cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty[cbc:ID = $allResponses and cbc:TypeCode='QUESTION']]/cbc:CriterionTypeCode"/>
			<let name="selectionReqResponses" value="$currentSelection[cac:TenderingCriterionPropertyGroup[cac:TenderingCriterionProperty[cbc:TypeCode!='QUESTION'] 
				and cac:SubsidiaryTenderingCriterionPropertyGroup//cac:TenderingCriterionProperty[cbc:ID = $allResponses and cbc:TypeCode='QUESTION'] ]]/cbc:CriterionTypeCode"/>
			<let name="selectionNotResponses" value="$currentSelection[cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty[not(cbc:ID = $allResponses) and cbc:TypeCode='QUESTION']]/cbc:CriterionTypeCode"/>
			<let name="selectionNotReqResponses" value="$currentSelection[cac:TenderingCriterionPropertyGroup[cac:TenderingCriterionProperty[cbc:TypeCode!='QUESTION'] 
				and count(cac:SubsidiaryTenderingCriterionPropertyGroup//cac:TenderingCriterionProperty[cbc:ID = $allResponses and cbc:TypeCode='QUESTION'])=0 ]]/cbc:CriterionTypeCode"/>

			<assert test="(($isPQS) and not($issubcont)) or (not(($isPQS) and not($issubcont)) and (count($currentSelection) = (count($selectionResponses) + count($selectionReqResponses))) )" flag="warning" id="BR-RESP-40">Information about compliance of selection criteria MUST be provided. The following selection criterion are not provided:<value-of select="$selectionNotResponses"/>, <value-of select="$selectionNotReqResponses"/></assert>
			
			<!-- BR-RESP-80-S10: When the pre-qualification system the EO is registered on does not cover all the selection criteria, information about compliance of selection criteria MUST be provided. -->
			<!-- isPQS = true + issubcont = false +  hasServiceProvider = true -->
			<let name="hasServiceProvider" value="(cac:ContractingParty/cac:Party/cac:ServiceProviderParty)"/>
			<let name="testS10" value="$isPQS and not($issubcont) and $hasServiceProvider"/>
			<assert test="not($testS10) or ($testS10 and (count($currentSelection) = (count($selectionResponses) + count($selectionReqResponses))) )" flag="warning" id="BR-RESP-80-S10">When the pre-qualification system the EO is registered on does not cover all the selection criteria, information about compliance of selection criteria MUST be provided. The following selection criterion are not provided: <value-of select="$selectionNotResponses"/>, <value-of select="$selectionNotReqResponses"/></assert>

			<!-- BR-RESP-80-S20: When the pre-qualification system the EO is registered on covers all the selection criteria, information about compliance of selection criteria IS NOT required. -->
			<!-- isPQS = true + issubcont = false +  hasServiceProvider = false + isExtended = true -->
			<let name="testS20" value="$isPQS and not($issubcont) and not($hasServiceProvider)"/>
			<assert test="not($testS20) or ($testS20 and (count($selectionResponses) = 0) )" flag="warning" id="BR-RESP-80-S20">When the pre-qualification system the EO is registered on covers all the selection criteria, information about compliance of selection criteria IS NOT required.</assert>
					
		</rule>
	</pattern>
</schema>
