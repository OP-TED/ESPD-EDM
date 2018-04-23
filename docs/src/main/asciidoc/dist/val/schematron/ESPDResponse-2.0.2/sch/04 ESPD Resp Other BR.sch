<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<title>ESPD Response Other Business Rules</title>
  
	<ns prefix="cac" uri="urn:X-test:UBL:Pre-award:CommonAggregate"/>
	<ns prefix="cbc" uri="urn:X-test:UBL:Pre-award:CommonBasic"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="udt" uri="urn:oasis:names:specification:ubl:schema:xsd:UnqualifiedDataTypes-2"/>
	
<!--
    Start of synthesis of rules from other constraints ESPD Response

    Illustration of procurer constraints - 04 ESPD Resp Other BR.sch
	ESPD Version: 2.0.2
-->
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-RESP-OTHER">
		
		<rule context="cbc:CustomizationID">
			<!-- BR-OTH-06 -->
			<!-- For the ESPD we use the value “urn:www.cenbii.eu:transaction:biitrdm070:ver3.0”. -->
			<assert test="text()='urn:www.cenbii.eu:transaction:biitrdm092:ver3.0'" flag="error" id="BR-OTH-06-01">For the ESPD customization of UBL ('/cbc:CustomizationID') we use the value “urn:www.cenbii.eu:transaction:biitrdm092:ver3.0”.</assert>
			
			<!-- Compulsory use of the value "CEN-BII" for the schemeAgencyID attribute. -->
			<assert test="@schemeAgencyID='CEN-BII'" flag="error" id="BR-OTH-06-02">Compulsory use of the value "CEN-BII" for the schemeAgencyID attribute.</assert>
		</rule>
		
	</pattern>
</schema>
