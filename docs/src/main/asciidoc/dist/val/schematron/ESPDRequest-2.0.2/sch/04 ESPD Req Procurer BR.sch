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

    Illustration of procurer constraints - 04 ESPD Req Procurer BR.sch
	ESPD Version: 2.0.2
-->
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-REQ-PROC">
	
		<rule context="espd:QualificationApplicationRequest">
			<!-- The ESPD only expects data about one buyer. -->
			<assert test="count(cac:ContractingParty) = 1" role="warning">The ESPD only expects data about one buyer. There are currently '<value-of select="count(cac:ContractingParty)"/>' buyers.</assert>
		</rule>
	
		<rule context="cac:ContractingParty/cac:Party">
			<!-- Use the official name of the contracting body. Mandatory. -->
			<assert test="(cac:PartyName/cbc:Name)" role="error">The use of the official name of the contracting body is mandatory.</assert>
			
			<!-- The country of the contracting body must always be specified. -->
			<assert test="(cac:PostalAddress/cac:Country/cbc:IdentificationCode)" role="error">The country of the contracting body must always be specified.</assert>
			
			<!-- More than one identifier can be specified. -->
			<assert test="count(cac:PartyIdentification/cbc:ID) = 1" role="warning">At least one identifier should be specified.</assert>
		</rule>
	
		<rule context="cac:ServiceProviderParty/cac:Party">
			<!-- An identifier for the service provider must always be provided. -->
			<assert test="(cac:PartyIdentification/cbc:ID)" role="error">An identifier for the service provider must always be provided.</assert>
			
			<!-- The name of the service provider must always be specified. -->
			<assert test="(cac:PartyName/cbc:Name)" role="error">The name of the service provider must always be specified.</assert>
			
			<!-- The country of the service provider must always be specified. -->
			<assert test="(cac:PostalAddress/cac:Country/cbc:IdentificationCode)" role="error">The country of the service provider must always be specified.</assert>
		</rule>
		
	</pattern>
</schema>
