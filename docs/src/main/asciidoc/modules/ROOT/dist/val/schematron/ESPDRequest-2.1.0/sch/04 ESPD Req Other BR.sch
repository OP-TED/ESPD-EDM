<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<title>ESPD Request Other Business Rules</title>
  
	<ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
	<ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="udt" uri="urn:oasis:names:specification:ubl:schema:xsd:UnqualifiedDataTypes-2"/>
	<ns prefix="espd" uri="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationRequest-2"/>
	
<!--
    Start of synthesis of rules from other constraints ESPD Request

    Illustration of procurer constraints - 04 ESPD Req Other BR.sch
	ESPD Version: 2.1.0
-->
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-REQ-OTHER">
		
		<rule context="cbc:CustomizationID">
			<!-- BR-OTH-06: For the ESPD we use the value “urn:www.cenbii.eu:transaction:biitrdm070:ver3.0 -->
			<assert test="text()='urn:www.cenbii.eu:transaction:biitrdm070:ver3.0'" role="fatal" id="BR-OTH-06-01">The ESPD customization of UBL ('/cbc:CustomizationID = <value-of select="."/>') must use the value 'urn:www.cenbii.eu:transaction:biitrdm070:ver3.0'.</assert>
			
			<!-- BR-OTH-06: Compulsory use of the value "CEN-BII" for the schemeAgencyID attribute. -->
			<assert test="@schemeAgencyID='CEN-BII'" role="fatal" id="BR-OTH-06-02">'/cbc:CustomizationID/@schemeAgencyID' must use the value "CEN-BII" (/cbc:CustomizationID/@schemeAgencyID = '<value-of select="@schemeAgencyID"/>').</assert>
		</rule>
		
	</pattern>
</schema>
