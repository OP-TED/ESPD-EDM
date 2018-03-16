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
		<!-- The ESPD-EDM model adds a few more restrictions regarding the cardinalities of some elements. -->
		<rule context="espd:QualificationApplicationResponse">
			<assert test="(cbc:UBLVersionID)" role="error">The element '/cbc:UBLVersionID' is mandatory.</assert>
			
			<assert test="(cbc:CustomizationID)" role="error">The element '/cbc:CustomizationID' is mandatory.</assert>
			
			<assert test="(cbc:ID)" role="error">The element '/cbc:ID' is mandatory.</assert>
			
			<assert test="(cbc:UUID)" role="error">The element '/cbc:UUID' is mandatory.</assert>
			
			<assert test="(cbc:QualificationApplicationTypeCode)" role="error">The element '/cbc:QualificationApplicationTypeCode' is mandatory.</assert>
			
			<assert test="(cac:TenderingCriterion)" role="error">The element '/cac:TenderingCriterion' is mandatory.</assert>
			
			<assert test="(cac:TenderingCriterionResponse)" role="error">The element '/cac:TenderingCriterionResponse' is mandatory.</assert>
		</rule>
	</pattern>
</schema>
