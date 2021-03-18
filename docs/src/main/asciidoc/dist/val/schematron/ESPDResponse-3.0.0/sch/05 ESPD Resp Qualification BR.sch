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
	ESPD Version: 3.0.0
-->
    <xsl:key name="EOrole" match="cbc:RoleCode" use="." />
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-RESP-QUAL">
		
		<rule context="espd:QualificationApplicationResponse">
			<!-- Common variables -->
			<let name="isPQS" value="(cac:EconomicOperatorParty/cac:QualifyingParty/cac:Party/cac:PartyIdentification/cbc:ID)"/>
			<let name="issubcont" value="count(key('EOrole', 'subcont'))=1"/>
			<let name="allResponses" value="cac:TenderingCriterionResponse/cbc:ValidatedCriterionPropertyID"/>
			
			<!-- BR-RESP-30: Information about compliance of exclusion grounds MUST be provided - when not registered pre-qualification system. -->
			
			<let name="exclusionList" value="translate('&#127;crime-org&#127;&#127;corruption&#127;&#127;fraud&#127;&#127;terr-offence&#127;&#127;finan-laund&#127;&#127;human-traffic&#127;&#127;tax-pay&#127;&#127;socsec-pay&#127;&#127;envir-law&#127;&#127;socsec-law&#127;&#127;labour-law&#127;&#127;bankruptcy&#127;&#127;insolvency&#127;&#127;cred-arran&#127;&#127;bankr-nat&#127;&#127;liq-admin&#127;&#127;susp-act&#127;&#127;prof-misconduct&#127;&#127;distorsion&#127;&#127;partic-confl&#127;&#127;prep-confl&#127;&#127;sanction&#127;&#127;misinterpr&#127;&#127;nati-ground&#127;','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
			
			<let name="selectionList" value="translate('&#127;prof-regist&#127;&#127;trade-regist&#127;&#127;autorisation&#127;&#127;membership&#127;&#127;gen-year-to&#127;&#127;aver-year-to&#127;&#127;spec-aver-to&#127;&#127;spec-year-to&#127;&#127;finan-rat&#127;&#127;indem-insu&#127;&#127;finan-requ&#127;&#127;work-perform&#127;&#127;supply-perform&#127;&#127;service-perform&#127;&#127;qual-cont-tech&#127;&#127;work-tech&#127;&#127;qual-facil&#127;&#127;research-fac&#127;&#127;chain-manage&#127;&#127;qualification&#127;&#127;envir-measure&#127;&#127;tech-equip&#127;&#127;spec-req-check&#127;&#127;manage-staff&#127;&#127;year-manpower&#127;&#127;suncont-port&#127;&#127;wo-autent&#127;&#127;w-autent&#127;&#127;qa-certif-inst&#127;&#127;qu-certif-indep&#127;&#127;envir-certif-indep&#127;','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
			
			<let name="currentExclusion"
				value="cac:TenderingCriterion[contains($exclusionList,concat('&#127;',translate(cbc:CriterionTypeCode,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'&#127;'))]"/>
			<let name="exclusionResponses" value="$currentExclusion[cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty[cbc:ID = $allResponses and cbc:TypeCode='QUESTION']]/cbc:CriterionTypeCode"/>
			<let name="exclusionReqResponses" value="$currentExclusion[cac:TenderingCriterionPropertyGroup[cac:TenderingCriterionProperty[cbc:TypeCode='REQUIREMENT'] 
				and cac:SubsidiaryTenderingCriterionPropertyGroup/cac:TenderingCriterionProperty[cbc:ID = $allResponses and cbc:TypeCode='QUESTION'] ]]/cbc:CriterionTypeCode"/>
			<let name="exclusionNotResponses" value="$currentExclusion[cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty[not(cbc:ID = $allResponses) and cbc:TypeCode='QUESTION']]/cbc:CriterionTypeCode/text()"/>
			<let name="exclusionNotReqResponses" value="$currentExclusion[cac:TenderingCriterionPropertyGroup[cac:TenderingCriterionProperty[cbc:TypeCode='REQUIREMENT'] 
				and cac:SubsidiaryTenderingCriterionPropertyGroup/cac:TenderingCriterionProperty[not(cbc:ID = $allResponses) and cbc:TypeCode='QUESTION'] ]]/cbc:CriterionTypeCode"/>

			<assert test="($isPQS) or(not($isPQS) and (count($currentExclusion) = (count($exclusionResponses) + count($exclusionReqResponses))) )" flag="fatal" id="BR-RESP-30">Information about compliance of exclusion grounds MUST be provided. The following exclusion criterion are not provided: <value-of select="$exclusionNotResponses"/>, <value-of select="$exclusionNotReqResponses"/></assert>
		
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
