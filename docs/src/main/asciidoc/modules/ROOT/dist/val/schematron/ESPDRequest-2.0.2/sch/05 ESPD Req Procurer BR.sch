<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<title>ESPD Request Procurer Business Rules</title>
  
	<ns prefix="cac" uri="urn:X-test:UBL:Pre-award:CommonAggregate"/>
	<ns prefix="cbc" uri="urn:X-test:UBL:Pre-award:CommonBasic"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="udt" uri="urn:oasis:names:specification:ubl:schema:xsd:UnqualifiedDataTypes-2"/>
	<ns prefix="espd" uri="urn:X-test:UBL:Pre-award:QualificationApplicationRequest"/>
	
<!--
    Start of synthesis of rules from procurer constraints ESPD Request

    Illustration of procurer constraints - 05 ESPD Req Procurer BR.sch
	ESPD Version: 2.0.2
-->
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-REQ-PROC">
	
		<rule context="espd:QualificationApplicationRequest">
			<!-- BR-REQ-20#1: The ESPD only expects data about one buyer. -->
			<assert test="count(cac:ContractingParty) = 1" flag="warning" id="BR-REQ-20-01">The ESPD only expects data about one buyer ('/cac:ContractingParty'). There are currently '<value-of select="count(cac:ContractingParty)"/>' buyers.</assert>
		</rule>
		
		<rule context="cac:ContractingParty/cac:Party">
			<!-- BR-REQ-20#2: Use the official name of the contracting body. Mandatory. -->
			<assert test="(cac:PartyName/cbc:Name)" flag="fatal" id="BR-REQ-20-02">The use of the official name of the contracting body ('/cac:ContractingParty/cac:Party/cac:PartyName/cbc:Name') is mandatory.</assert>
			
			<!-- BR-REQ-20#3: The country of the contracting body must always be specified. -->
			<assert test="(cac:PostalAddress/cac:Country/cbc:IdentificationCode)" flag="fatal" id="BR-REQ-20-03">The country of the contracting body ('/cac:ContractingParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode') must always be specified.</assert>
			
			<!-- BR-REQ-20#4: More than one identifier can be specified. -->
			<assert test="(cac:PartyIdentification/cbc:ID)" flag="warning" id="BR-REQ-20-04">At least one identifier ('cac:ContractingParty/cac:Party/cac:PartyIdentification/cbc:ID') should be specified.</assert>
		</rule>
	
		<rule context="cac:ServiceProviderParty/cac:Party">
			<!-- BR-REQ-20#5: An identifier for the service provider must always be provided. -->
			<assert test="(cac:PartyIdentification/cbc:ID)" flag="fatal" id="BR-REQ-20-05">An identifier for the service provider ('/cac:ServiceProviderParty/cac:Party/cac:PartyIdentification/cbc:ID') must always be provided.</assert>
			
			<!-- BR-REQ-20#6: The name of the service provider must always be specified. -->
			<assert test="(cac:PartyName/cbc:Name)" flag="fatal" id="BR-REQ-20-06">The name of the service provider ('/cac:ServiceProviderParty/cac:Party/cac:PartyName/cbc:Name') must always be specified.</assert>
			
			<!-- BR-REQ-20#7: The country of the service provider must always be specified. -->
			<assert test="(cac:PostalAddress/cac:Country/cbc:IdentificationCode)" flag="fatal" id="BR-REQ-20-07">The country of the service provider ('/cac:ServiceProviderParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode') must always be specified.</assert>
		</rule>
		
	</pattern>
</schema>
