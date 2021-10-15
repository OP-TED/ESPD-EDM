<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/xpath-functions">
	<title>ESPD Response Business Rules</title>
  
	<ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
	<ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="udt" uri="urn:oasis:names:specification:ubl:schema:xsd:UnqualifiedDataTypes-2"/>
	<ns prefix="espd" uri="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationResponse-2"/>
	<ns prefix="fn" uri="http://www.w3.org/2005/xpath-functions"/>
	
<!--
    Start of synthesis of rules from other constraints ESPD Response

    Illustration of procurer constraints - 05 ESPD Resp BR.sch
	ESPD Version: 3.0.0
-->
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-RESP-SC">
		<rule context="espd:QualificationApplicationResponse">
			<!-- BR-LOT-10: The EO should specify only one procurement project Lot to which the ESPD applies -->
			<let name="ppLot" value="count(cac:ProcurementProjectLot/cbc:ID)"/>
			<assert test="$ppLot = 1" flag="fatal" id="BR-LOT-10">The lot the EO tenders for MUST be provided.</assert>
			
		</rule>
		
	</pattern>
</schema>
