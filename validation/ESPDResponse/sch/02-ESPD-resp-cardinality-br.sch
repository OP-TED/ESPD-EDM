<?xml version="1.0" encoding="UTF-8"?>
<!--
  File: 02-ESPD-resp-cardinality-br.sch
  Scope: ESPD Response only
  Version: 5.0.0
  Maintenance: Manual
  Dependencies: None
  Rules: BR-OTH-04-01, BR-OTH-04-03, BR-OTH-04-04, BR-OTH-04-06, BR-OTH-04-07
  Description: Cardinality constraints for ESPD Response — mandatory elements
               beyond what the UBL XSD enforces (includes TenderingCriterionResponse).
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<title>ESPD Response Cardinality Business Rules</title>
	
	<ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
	<ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="espd" uri="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationResponse-2"/>
	
<!--
    Start of synthesis of rules from cardinality constraints ESPD Response.

    Illustration of cardinality constraints - 02-ESPD-resp-cardinality-br.sch
	ESPD Version: 3.1.0
-->
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-RESP-CARD">
		<!-- BR-OTH-04: The ESPD-EDM model adds a few more restrictions regarding the cardinalities of some elements. -->
		<rule context="espd:QualificationApplicationResponse">
			<assert test="(cbc:UBLVersionID)" flag="fatal" id="BR-OTH-04-01">The element '/cbc:UBLVersionID' is mandatory.</assert>
			
			<assert test="(cbc:ID)" flag="fatal" id="BR-OTH-04-03">The element '/cbc:ID' is mandatory.</assert>
			
			<assert test="(cbc:UUID)" flag="fatal" id="BR-OTH-04-04">The element '/cbc:UUID' is mandatory.</assert>
			
			<assert test="(cac:TenderingCriterion)" flag="fatal" id="BR-OTH-04-06">The element '/cac:TenderingCriterion' is mandatory.</assert>
			
			<assert test="(cac:TenderingCriterionResponse)" flag="fatal" id="BR-OTH-04-07">The element '/cac:TenderingCriterionResponse' is mandatory.</assert>
		</rule>
	</pattern>
</schema>
