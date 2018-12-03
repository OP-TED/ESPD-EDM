<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<title>ESPD Response pre-qualification system Business Rules</title>
  
	<ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
	<ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="espd" uri="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationResponse-2"/>
	
<!--
    Start of synthesis of rules from pre-qualification system ESPD Response

    Illustration of procurer constraints - 05 ESPD Resp Qualification BR.sch
	ESPD Version: 2.1.0
-->
    <xsl:key name="EOrole" match="cbc:RoleCode" use="." />
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-RESP-QUAL">
		
		<rule context="espd:QualificationApplicationResponse">
			<!-- Common variables -->
			<let name="isPQS" value="(cac:EconomicOperatorParty/cac:QualifyingParty/cac:Party/cac:PartyIdentification/cbc:ID)"/>
			<let name="isOENRON" value="count(key('EOrole', 'OENRON'))=1"/>
			<let name="allResponses" value="cac:TenderingCriterionResponse/cbc:ValidatedCriterionPropertyID"/>
			
			<!-- BR-RESP-30: Information about compliance of exclusion grounds MUST be provided - when not registered pre-qualification system. -->
			<let name="exclusionCriteria" value="cac:TenderingCriterion[starts-with(cbc:CriterionTypeCode, 'CRITERION.EXCLUSION.')]"/>
			<let name="exclusionResponses" value="$exclusionCriteria[cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty[cbc:ID = $allResponses]]/cbc:CriterionTypeCode"/>
			<let name="exclusionNotResponses" value="$exclusionCriteria[cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty[not(cbc:ID = $allResponses)]]/cbc:CriterionTypeCode/text()"/>
			
			<assert test="($isPQS) or(not($isPQS) and (count($exclusionCriteria) = count($exclusionResponses)) )" flag="fatal" id="BR-RESP-30">Information about compliance of exclusion grounds MUST be provided. The following exclusion criterion are not provided: <value-of select="$exclusionNotResponses"/></assert>
		
			<!-- BR-RESP-40: Information about compliance of selection criteria MUST be provided - when not registered pre-qualification system and role different to OENRON -->
			<let name="selectionCriteria" value="cac:TenderingCriterion[starts-with(cbc:CriterionTypeCode, 'CRITERION.SELECTION.')]"/>
			<let name="selectionResponses" value="$selectionCriteria[cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty[cbc:ID = $allResponses]]/cbc:CriterionTypeCode"/>
			<let name="selectionNotResponses" value="$selectionCriteria[cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty[not(cbc:ID = $allResponses)]]/cbc:CriterionTypeCode"/>
			
			<assert test="(($isPQS) and not($isOENRON)) or (not(($isPQS) and not($isOENRON)) and (count($selectionCriteria) = count($selectionResponses)) )" flag="warning" id="BR-RESP-40">Information about compliance of selection criteria MUST be provided. The following selection criterion are not provided: <value-of select="$selectionNotResponses"/></assert>
			
			<!-- BR-RESP-80-S10: When the pre-qualification system the EO is registered on does not cover all the selection criteria, information about compliance of selection criteria MUST be provided. -->
			<!-- isPQS = true + isOENRON = false +  hasServiceProvider = true -->
			<let name="hasServiceProvider" value="(cac:ContractingParty/cac:Party/cac:ServiceProviderParty)"/>
			<let name="testS10" value="$isPQS and not($isOENRON) and $hasServiceProvider"/>
			<assert test="not($testS10) or ($testS10 and (count($selectionCriteria) = count($selectionResponses)) )" flag="warning" id="BR-RESP-80-S10">When the pre-qualification system the EO is registered on does not cover all the selection criteria, information about compliance of selection criteria MUST be provided. The following selection criterion are not provided: <value-of select="$selectionNotResponses"/></assert>

			<!-- BR-RESP-80-S20: When the pre-qualification system the EO is registered on covers all the selection criteria, information about compliance of selection criteria IS NOT required. -->
			<!-- isPQS = true + isOENRON = false +  hasServiceProvider = false + isSelfcontained = true -->
			<let name="testS20" value="$isPQS and not($isOENRON) and not($hasServiceProvider)"/>
			<assert test="not($testS20) or ($testS20 and (count($selectionResponses) = 0) )" flag="warning" id="BR-RESP-80-S20">When the pre-qualification system the EO is registered on covers all the selection criteria, information about compliance of selection criteria IS NOT required.</assert>
					
		</rule>
	</pattern>
</schema>
