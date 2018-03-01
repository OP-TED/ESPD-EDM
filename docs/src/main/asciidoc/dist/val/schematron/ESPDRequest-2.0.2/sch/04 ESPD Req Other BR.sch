<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<title>ESPD Request Other Business Rules</title>
  
	<ns prefix="cac" uri="urn:X-test:UBL:Pre-award:CommonAggregate"/>
	<ns prefix="cbc" uri="urn:X-test:UBL:Pre-award:CommonBasic"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="udt" uri="urn:oasis:names:specification:ubl:schema:xsd:UnqualifiedDataTypes-2"/>
	<ns prefix="espd" uri="urn:X-test:UBL:Pre-award:QualificationApplicationRequest"/>
	
<!--
    Start of synthesis of rules from other constraints ESPD Request

    Illustration of procurer constraints - 04 ESPD Req Other BR.sch
	ESPD Version: 2.0.2
-->
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-REQ-OTHER">
	
		<rule context="espd:QualificationApplicationRequest">
			<!-- Information about the procurement procedure MUST be provided. -->
			<assert test="(cac:ProcurementProject)" role="error">Information about the procurement procedure ('/cacProcurementProject') MUST be provided.</assert>
		</rule>
		
		<rule context="cbc:CustomizationID">
			<!-- For the ESPD we use the value “urn:www.cenbii.eu:transaction:biitrdm070:ver3.0”. -->
			<assert test="text()='urn:www.cenbii.eu:transaction:biitrdm070:ver3.0'" role="error">For the ESPD customization of UBL ('/cbc:CustomizationID'), the value is “urn:www.cenbii.eu:transaction:biitrdm070:ver3.0”.</assert>
			
			<!-- Compulsory use of the value "CEN-BII" for the schemeAgencyID attribute. -->
			<assert test="@schemeAgencyID='CEN-BII'" role="error">Compulsory use of the value "CEN-BII" for the schemeAgencyID attribute.</assert>
		</rule>
		
	</pattern>
</schema>
