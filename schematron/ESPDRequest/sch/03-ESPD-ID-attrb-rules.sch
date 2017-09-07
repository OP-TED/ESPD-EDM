<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron">
  <title>Identifier elements - mandatory attributes</title>
  
	<ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
	<ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
	<ns prefix="ccv-cbc" uri="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonBasicComponents-1"/>
	<ns prefix="cev-cbc" uri="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonBasicComponents-1"/>
	<ns prefix="cev" uri="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonAggregateComponents-1"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="ccv" uri="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonAggregateComponents-1"/>
	<ns prefix="espd-req" uri="urn:grow:names:specification:ubl:schema:xsd:ESPDRequest-1"/>
  
  <pattern id="id-attrb-rules">

<!--
    Start of synthesis of rules from identifiers attributes assertions.

    Illustration of codelists attributes constraints - ESPD-ID-attrb-rules.sch

-->

	<!-- Identifier Elements: 1st level -->
	<rule context="cbc:ID | cbc:UUID | cbc:VersionID | cbc:PreviousVersionID | cbc:ContractFolderID">
		<!-- The attributes schemeAgencyID must be provided and filled in. -->
		<assert test="( not(string(@schemeAgencyID))=false() )">The attribute 'schemeAgencyID' is mandatory and must be provided and filled in </assert>
	</rule>
	
	<!-- Identifier Elements: Extension components -->
	<rule context="ext:ExtensionAgencyID | ext:ExtensionVersionID ">
		<!-- The attributes schemeAgencyID must be provided and filled in. -->
		<assert test="( not(string(@schemeAgencyID))=false() )">The attribute 'schemeAgencyID' is mandatory and must be provided and filled in </assert>
	</rule>

	<!-- Identifier Elements: cac:Party -->
	<rule context="cbc:LogoReferenceID | cbc:EndpointID | cbc:CompanyID | cbc:NationalityID | cbc:LanguageID">
		<!-- The attributes schemeAgencyID must be provided and filled in. -->
		<assert test="( not(string(@schemeAgencyID))=false() )">The attribute 'schemeAgencyID' is mandatory and must be provided and filled in </assert>
	</rule>

	<!-- Identifier Elements: cac:ProcurementProjectLot -->
	<rule context="cbc:ValidatorID | cbc:PaymentMeansID | cbc:PrepaidPaymentReferenceID | cbc:TenderEnvelopeID | cbc:OpenTenderID">
		<!-- The attributes schemeAgencyID must be provided and filled in. -->
		<assert test="( not(string(@schemeAgencyID))=false() )">The attribute 'schemeAgencyID' is mandatory and must be provided and filled in </assert>
	</rule>
	
	<!-- Mandatory values of the Identifiers -->
	<rule context="cbc:UBLVersionID">
		<!-- The attributes schemeAgencyID must be provided and filled in. -->
		<assert test="( not(string(@schemeAgencyID))=false() )">The attribute 'schemeAgencyID' is mandatory and must be provided and filled in </assert>
		
		<!-- Value must be 2.1 -->
		<assert test="( not(string(.)!='2.1') )">The value must be '2.1' </assert>
	</rule>
	
	<!-- Mandatory values of the Identifiers -->
	<rule context="cbc:CustomizationID">
		<!-- The attributes schemeAgencyID must be provided and filled in. -->
		<assert test="( not(string(@schemeAgencyID))=false() )">The attribute 'schemeAgencyID' is mandatory and must be provided and filled in </assert>
		
		<!-- Value must be 2.1 -->
		<assert test="( string(.)='urn:www.cenbii.eu:transaction:biitrns070:ver3.0' )">The value must be 'urn:www.cenbii.eu:transaction:biitrns070:ver3.0' </assert>
	</rule>
	
	<!-- Mandatory values of the Identifiers -->
	<rule context="cbc:ProfileID">
		<!-- The attributes schemeAgencyID must be provided and filled in. -->
		<assert test="( not(string(@schemeAgencyID))=false() )">The attribute 'schemeAgencyID' is mandatory and must be provided and filled in </assert>
		
		<!-- Value must be 2.1 -->
		<assert test="( string(.)='ESPD' )">The value must be 'ESPD' </assert>
	</rule>
	
	<!-- Mandatory values of the Identifiers -->
	<rule context="cbc:ProfileExecutionID">
		<!-- The attributes schemeAgencyID must be provided and filled in. -->
		<assert test="( not(string(@schemeAgencyID))=false() )">The attribute 'schemeAgencyID' is mandatory and must be provided and filled in </assert>
		
		<!-- Value must be 2.1 -->
		<assert test="( string(.)='QT' )">The value must be 'QT' </assert>
	</rule>
	
</pattern>
</schema>