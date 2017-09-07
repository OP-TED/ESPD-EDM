<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <title>Common Business Rules assertions</title>
  
	<ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
	<ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
	<ns prefix="ccv-cbc" uri="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonBasicComponents-1"/>
	<ns prefix="cev-cbc" uri="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonBasicComponents-1"/>
	<ns prefix="cev" uri="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonAggregateComponents-1"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="ccv" uri="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonAggregateComponents-1"/>
	<ns prefix="espd-cbc" uri="urn:grow:names:specification:ubl:schema:xsd:ESPD-CommonBasicComponents-1"/>
	<ns prefix="gc" uri="http://docs.oasis-open.org/codelist/ns/genericode/1.0/"/>
	<ns prefix="espd" uri="urn:grow:names:specification:ubl:schema:xsd:ESPDResponse-1"/>
	<ns prefix="espd-cac" uri="urn:grow:names:specification:ubl:schema:xsd:ESPD-CommonAggregateComponents-1"/>
  
  <pattern id="common-br-rules">

<!--
    Start of synthesis of rules from identifiers attributes assertions.

    Illustration of codelists attributes constraints - ESPD-Common BR-rules.sch

-->

	<!-- In the element EconomicOperatorParty (EO) the minimum data required are the EO’s identifier (inside PartyIdentification), its name (inside PartyName) and its CountryIdentificationCode. -->
	<rule context="/espd:ESPDResponse/espd-cac:EconomicOperatorParty/cac:Party/cac:PartyIdentification">
		<!-- EO’s identifier (inside PartyIdentification) -->
		<assert test="( not(string(cbc:ID))=false() )">The element 'cac:Party / cac:PartyIdentification / cbc:ID' is mandatory </assert>
	</rule>
	<rule context="/espd:ESPDResponse/espd-cac:EconomicOperatorParty/cac:Party/cac:PartyName">
		<!-- EO’s name (inside PartyName) -->
		<assert test="( not(string(cbc:Name))=false() )">The element 'cac:Party / cac:PartyName / cbc:Name' is mandatory </assert>
	</rule>
	<rule context="/espd:ESPDResponse/espd-cac:EconomicOperatorParty/cac:Party/cac:PostalAddress/cac:Country">
		<!-- CountryIdentificationCode -->
		<assert test="( not(string(cbc:IdentificationCode))=false() )">The element 'cac:Country / cbc:IdentificationCode' is mandatory </assert>
	</rule>
	
	<rule context="ccv:RequirementGroup/ccv:Requirement">
		<!-- In a Response element only one element MUST be provided to respond to a Requirement. The rule is simple: One Requirement à One Response (of one specific type from the ones defined in the schema). -->
		<assert test="not(count( ccv:Response ) &gt; 1)">Only one element MUST be provided to respond to a Requirement. </assert>
		
		<!-- The element used inside the Response to answer a Requirement MUST always match the type of data indicated by the attribute ResponseDataType of the Requirement. -->
		<assert test="(not(@responseDataType='AMOUNT' and not(count(ccv:Response/child::*) = 0) and not(string(ccv:Response/cbc:Amount))))">The element used inside the Response to answer a Requirement MUST always match the type of data indicated by the attribute ResponseDataType of the Requirement. </assert>
		<assert test="(not(@responseDataType='CODE' and not(count(ccv:Response/child::*) = 0) and not(string(ccv:Response/ccv-cbc:Code)))) ">The element used inside the Response to answer a Requirement MUST always match the type of data indicated by the attribute ResponseDataType of the Requirement. </assert>
		<assert test="(not(@responseDataType='CODE_COUNTRY' and not(count(ccv:Response/child::*) = 0) and not(string(ccv:Response/ccv-cbc:Code))))">The element used inside the Response to answer a Requirement MUST always match the type of data indicated by the attribute ResponseDataType of the Requirement. </assert>
		<assert test="(not(@responseDataType='DATE' and not(count(ccv:Response/child::*) = 0) and not(string(ccv:Response/cbc:Date))))">The element used inside the Response to answer a Requirement MUST always match the type of data indicated by the attribute ResponseDataType of the Requirement. </assert>
		<assert test="(not(@responseDataType='DESCRIPTION' and not(count(ccv:Response/child::*) = 0) and not(string(ccv:Response/cbc:Description))))">The element used inside the Response to answer a Requirement MUST always match the type of data indicated by the attribute ResponseDataType of the Requirement. </assert>
		<assert test="(not(@responseDataType='EVIDENCE_URL' and not(count(ccv:Response/child::*) = 0) and not(string(ccv:Response/cev:Evidence))))">The element used inside the Response to answer a Requirement MUST always match the type of data indicated by the attribute ResponseDataType of the Requirement. </assert>
		<assert test="(not(@responseDataType='INDICATOR' and not(count(ccv:Response/child::*) = 0) and not(string(ccv:Response/ccv-cbc:Indicator))))">The element used inside the Response to answer a Requirement MUST always match the type of data indicated by the attribute ResponseDataType of the Requirement. </assert>
		<assert test="(not(@responseDataType='PERCENTAGE' and not(count(ccv:Response/child::*) = 0) and not(string(ccv:Response/cbc:Percent))))">The element used inside the Response to answer a Requirement MUST always match the type of data indicated by the attribute ResponseDataType of the Requirement. </assert>
		<assert test="(not(@responseDataType='PERIOD' and not(count(ccv:Response/child::*) = 0) and not(string(ccv:Response/cac:Period))))">The element used inside the Response to answer a Requirement MUST always match the type of data indicated by the attribute ResponseDataType of the Requirement. </assert>
		<assert test="(not(@responseDataType='QUANTITY_INTEGER' and not(count(ccv:Response/child::*) = 0) and not(string(ccv:Response/cbc:Quantity))))">The element used inside the Response to answer a Requirement MUST always match the type of data indicated by the attribute ResponseDataType of the Requirement. </assert>
		<assert test="(not(@responseDataType='QUANTITY_YEAR' and not(count(ccv:Response/child::*) = 0) and not(string(ccv:Response/cbc:Quantity))))">The element used inside the Response to answer a Requirement MUST always match the type of data indicated by the attribute ResponseDataType of the Requirement. </assert>
		<assert test="(not(@responseDataType='QUANTITY' and not(count(ccv:Response/child::*) = 0) and not(string(ccv:Response/cbc:Quantity))))">The element used inside the Response to answer a Requirement MUST always match the type of data indicated by the attribute ResponseDataType of the Requirement. </assert>
	</rule>
	
</pattern>
</schema>