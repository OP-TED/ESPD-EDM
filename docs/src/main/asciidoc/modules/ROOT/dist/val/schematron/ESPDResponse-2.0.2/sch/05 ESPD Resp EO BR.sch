<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<title>ESPD Response Economic Operator Business Rules</title>
  
	<ns prefix="cac" uri="urn:X-test:UBL:Pre-award:CommonAggregate"/>
	<ns prefix="cbc" uri="urn:X-test:UBL:Pre-award:CommonBasic"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="udt" uri="urn:oasis:names:specification:ubl:schema:xsd:UnqualifiedDataTypes-2"/>
	
<!--
    Start of synthesis of rules from Economic Operator (EO) constraints ESPD Response

    Illustration of EO constraints - 05 ESPD Resp EO BR.sch
	ESPD Version: 2.0.2
-->
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-RESP-EO">
		<!-- BR-RESP-10: Information about the economic operator MUST be provided. -->
		<rule context="cac:EconomicOperatorParty">	
			<let name="isSC" value="/*[1]/cbc:QualificationApplicationTypeCode='SELFCONTAINED'"/>	
			
			<!-- BR-RESP-10-02: This element is compulsory in the ESPD-EDM V02.00.00 because depending on it different sets of data will be required or not, shown or hidden, processed or skipped. -->
			<assert test="not($isSC) or ($isSC and (cac:EconomicOperatorRole))" flag="error" id="BR-RESP-10-02">The function of the economic operator ('/cac:EconomicOperatorParty/cac:EconomicOperatorRole') is mandatory.</assert>
			
			<!-- BR-RESP-10-03: Identifies the role of the economic operator in the bid. -->
			<assert test="not($isSC) or ($isSC and (cac:EconomicOperatorRole/cbc:RoleCode))" flag="error" id="BR-RESP-10-03">The role of the economic operator ('/cac:EconomicOperatorParty/cac:EconomicOperatorRole/cbc:RoleCode') is mandatory.</assert>	
		</rule>
		
		<!-- Main set of data used to identify and contact the economic operator, such as official identifiers, name, address, contact person, representatives, etc. -->
		<rule context="cac:EconomicOperatorParty/cac:Party">
			<!-- BR-RESP-10-04: An identifier that identifies the economic operator is mandatory. -->
			<assert test="(cac:PartyIdentification/cbc:ID)" flag="error" id="BR-RESP-10-04">An identifier that identifies the economic operator ('/cac:EconomicOperatorParty/cac:Party/cac:PartyIdentification/cbc:ID') is mandatory.</assert>
			
			<!-- BR-RESP-10-05: The name of the economic operator is mandatory. -->
			<assert test="(cac:PartyName/cbc:Name)" flag="error" id="BR-RESP-10-05">The name of the economic operator ('/cac:EconomicOperatorParty/cac:Party/cac:PartyName/cbc:Name') is mandatory.</assert>
			
			<!-- BR-RESP-10-06: Used to indicate the size of the company. -->
			<assert test="(cbc:IndustryClassificationCode)" flag="error" id="BR-RESP-10-06">The size of the company ('/cac:EconomicOperatorParty/cac:Party/cbc:IndustryClassificationCode') is mandatory.</assert>
			
			<!-- BR-RESP-10-07: The country of the contracting body must always be specified. -->
			<assert test="(cac:PostalAddress/cac:Country/cbc:IdentificationCode)" flag="error" id="BR-RESP-10-07">The size of the company ('/cac:EconomicOperatorParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode') is mandatory.</assert>
		</rule>
		
		<!-- Main information about the service provider. -->
		<rule context="cac:ServiceProviderParty/cac:Party">
			<!-- BR-RESP-10-09: The name of the service provider must always be specified. -->
			<assert test="(cac:PartyName/cbc:Name)" flag="error" id="BR-RESP-10-09">The name of the service provider ('/cac:ServiceProviderParty/cac:Party/cac:PartyName/cbc:Name') must always be specified.</assert>
			
			<!-- BR-RESP-10-10: The country of the service provider must always be specified. -->
			<assert test="(cac:PostalAddress/cac:Country/cbc:IdentificationCode)" flag="error" id="BR-RESP-10-10">The country of the service provider ('/cac:ServiceProviderParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode') must always be specified.</assert>
			
			<!-- BR-RESP-10-11: An identifier for the service provider must always be provided. -->
			<assert test="(cac:PartyIdentification/cbc:ID)" flag="error" id="BR-RESP-10-11">An identifier for the service provider ('/cac:ServiceProviderParty/cac:Party/cac:PartyIdentification/cbc:ID') must always be provided.</assert>
		</rule>
		
		<!-- BR-RESP-20: Official or legal mandate issued by an authority (e.g. an attorney or a notary) to represent the economic operator as a representative of the economic operator in public procurement procedures. -->
		<rule context="cac:PowerOfAttorney">
			<!-- BR-RESP-20-01: Name of the natural person is mandatory. -->
			<assert test="(cac:AgentParty/cac:Person/cbc:FirstName)" flag="error" id="BR-RESP-20-01">Name of the natural person ('/cac:PowerOfAttorney/cac:AgentParty/cac:Person/cbc:FirstName') must always be provided.</assert>
			
			<!-- BR-RESP-20-02: Family Name of the natural person is mandatory. -->
			<assert test="(cac:AgentParty/cac:Person/cbc:FamilyName)" flag="error" id="BR-RESP-20-02">Family Name of the natural person ('/cac:PowerOfAttorney/cac:AgentParty/cac:Person/cbc:FamilyName') must always be provided.</assert>
			
			<!-- BR-RESP-20-03: A code that identifies the country is mandatory. -->
			<assert test="(cac:AgentParty/cac:Person/cac:ResidenceAddress/cac:Country/cbc:IdentificationCode)" flag="error" id="BR-RESP-20-03">A code that identifies the country ('/cac:PowerOfAttorney/cac:AgentParty/cac:Person/cac:ResidenceAddress/cac:Country/cbc:IdentificationCode') must always be provided.</assert>
		</rule>
		
	</pattern>
</schema>
