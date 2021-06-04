<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<title>ESPD Response Cardinality Business Rules</title>
  
	<ns prefix="cac" uri="urn:X-test:UBL:Pre-award:CommonAggregate"/>
	<ns prefix="cbc" uri="urn:X-test:UBL:Pre-award:CommonBasic"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="espd" uri="urn:X-test:UBL:Pre-award:QualificationApplicationResponse"/>
	
<!--
    Start of synthesis of rules from cardinality constraints ESPD Response.

    Illustration of cardinality constraints - 02 ESPD Resp Cardinality BR.sch
	ESPD Version: 2.0.2
-->
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-RESP-CARD">
		<!-- BR-OTH-04: The ESPD-EDM model adds a few more restrictions regarding the cardinalities of some elements. -->
		<rule context="espd:QualificationApplicationResponse">
			<assert test="(cbc:UBLVersionID)" flag="fatal" id="BR-OTH-04-01">The element '/cbc:UBLVersionID' is mandatory.</assert>
			
			<assert test="(cbc:CustomizationID)" flag="fatal" id="BR-OTH-04-02">The element '/cbc:CustomizationID' is mandatory.</assert>
			
			<assert test="(cbc:ID)" flag="fatal" id="BR-OTH-04-03">The element '/cbc:ID' is mandatory.</assert>
			
			<assert test="(cbc:UUID)" flag="fatal" id="BR-OTH-04-04">The element '/cbc:UUID' is mandatory.</assert>
			
			<assert test="(cbc:QualificationApplicationTypeCode)" flag="fatal" id="BR-OTH-04-05">The element '/cbc:QualificationApplicationTypeCode' is mandatory.</assert>
			
			<assert test="(cac:TenderingCriterion)" flag="fatal" id="BR-OTH-04-06">The element '/cac:TenderingCriterion' is mandatory.</assert>
			
			<assert test="(cac:TenderingCriterionResponse)" flag="fatal" id="BR-OTH-04-07">The element '/cac:TenderingCriterionResponse' is mandatory.</assert>
		</rule>
	</pattern>
</schema>
