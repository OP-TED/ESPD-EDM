<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<title>ESPD Response Economic Operator Business Rules</title>
  
	<ns prefix="cac" uri="urn:X-test:UBL:Pre-award:CommonAggregate"/>
	<ns prefix="cbc" uri="urn:X-test:UBL:Pre-award:CommonBasic"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="udt" uri="urn:oasis:names:specification:ubl:schema:xsd:UnqualifiedDataTypes-2"/>
	
<!--
    Start of synthesis of rules from Economic Operator (EO) constraints ESPD Response

    Illustration of EO constraints - 04 ESPD Resp EO BR.sch
	ESPD Version: 2.0.0
-->
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-RESP-EO">
		<!-- Information about the economic operator MUST be provided. -->
		<rule context="cac:EconomicOperatorParty">
			<!-- Qualifying party is compulsory in the ESPD-EDM V02.00.00 as it is the natural placeholder for several relevant data about the Economic Operator. -->
			<assert test="(cac:QualifyingParty)" role="error">The characteristics qualifying an economic operator ('/cac:EconomicOperatorParty/cac:QualifyingParty') is mandatory.</assert>
		
			<!-- This element is compulsory in the ESPD-EDM V02.00.00 because depending on it different sets of data will be required or not, shown or hidden, processed or skipped. -->
			<assert test="(cac:EconomicOperatorRole)" role="error">The function of the economic operator ('/cac:EconomicOperatorParty/cac:EconomicOperatorRole') is mandatory.</assert>
			
			<!-- Identifies the role of the economic operator in the bid. -->
			<assert test="(cac:EconomicOperatorRole/cbc:RoleCode)" role="error">The role of the economic operator ('/cac:EconomicOperatorParty/cac:EconomicOperatorRole/cbc:RoleCode') is mandatory.</assert>	
		</rule>
		
		<!-- Main set of data used to identify and contact the economic operator, such as official identifiers, name, address, contact person, representatives, etc. -->
		<rule context="cac:EconomicOperatorParty/cac:Party">
			<!-- An identifier that identifies the economic operator is mandatory. -->
			<assert test="(cac:PartyIdentification/cbc:ID)" role="error">An identifier that identifies the economic operator ('/cac:EconomicOperatorParty/cac:Party/cac:PartyIdentification/cbc:ID') is mandatory.</assert>
			
			<!-- The name of the economic operator is mandatory. -->
			<assert test="(cac:PartyName/cbc:Name)" role="error">The name of the economic operator ('/cac:EconomicOperatorParty/cac:Party/cac:PartyName/cbc:Name') is mandatory.</assert>
			
			<!-- Used to indicate the size of the company. -->
			<assert test="(cbc:IndustryClassificationCode)" role="error">The size of the company ('/cac:EconomicOperatorParty/cac:Party/cbc:IndustryClassificationCode') is mandatory.</assert>
			
			<!-- The country of the contracting body must always be specified. -->
			<assert test="(cac:PostalAddress/cac:Country/cbc:IdentificationCode)" role="error">The size of the company ('/cac:EconomicOperatorParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode') is mandatory.</assert>
		</rule>
		
		<!-- Main information about the service provider. -->
		<rule context="cac:ServiceProviderParty/cac:Party">
			<!-- An end-point identifier MUST have a scheme identifier attribute (e.g.eSENSParty Identifier Scheme). -->
			<assert test="(cbc:EndpointID/@schemeID)" role="error">An end-point identifier MUST have a scheme identifier attribute ('/cac:ServiceProviderParty/cac:Party/cbc:EndpointID/@schemeID').</assert>
			
			<!-- The name of the service provider must always be specified. -->
			<assert test="(cac:PartyName/cbc:Name)" role="error">The name of the service provider ('/cac:ServiceProviderParty/cac:Party/cac:PartyName/cbc:Name') must always be specified.</assert>
			
			<!-- The country of the service provider must always be specified. -->
			<assert test="(cac:PostalAddress/cac:Country/cbc:IdentificationCode)" role="error">The country of the service provider ('/cac:ServiceProviderParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode') must always be specified.</assert>
			
			<!-- An identifier for the service provider must always be provided. -->
			<assert test="(cac:PartyIdentification/cbc:ID)" role="error">An identifier for the service provider ('/cac:ServiceProviderParty/cac:Party/cac:PartyIdentification/cbc:ID') must always be provided.</assert>
		</rule>
		
		<!-- Official or legal mandate issued by an authority (e.g. an attorney or a notary) to represent the economic operator as a representative of the economic operator in public procurement procedures. -->
		<rule context="cac:PowerOfAttorney">
			<!-- Name of the natural person is mandatory. -->
			<assert test="(cac:AgentParty/cac:Person/cbc:FirstName)" role="error">Name of the natural person ('/cac:PowerOfAttorney/cac:AgentParty/cac:Person/cbc:FirstName') must always be provided.</assert>
			
			<!-- Family Name of the natural person is mandatory. -->
			<assert test="(cac:AgentParty/cac:Person/cbc:FamilyName)" role="error">Family Name of the natural person ('/cac:PowerOfAttorney/cac:AgentParty/cac:Person/cbc:FamilyName') must always be provided.</assert>
			
			<!-- A code that identifies the country is mandatory. -->
			<assert test="(cac:AgentParty/cac:Person/cac:ResidenceAddress/cac:Country/cbc:IdentificationCode)" role="error">A code that identifies the country ('/cac:PowerOfAttorney/cac:AgentParty/cac:Person/cac:ResidenceAddress/cac:Country/cbc:IdentificationCode') must always be provided.</assert>
		</rule>
		
	</pattern>
</schema>
