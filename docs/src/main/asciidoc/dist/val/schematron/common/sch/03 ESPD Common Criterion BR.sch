<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<title>Common Criterion Business Rules</title>
  
	<ns prefix="cac" uri="urn:X-test:UBL:Pre-award:CommonAggregate"/>
	<ns prefix="cbc" uri="urn:X-test:UBL:Pre-award:CommonBasic"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="udt" uri="urn:oasis:names:specification:ubl:schema:xsd:UnqualifiedDataTypes-2"/>
	<ns prefix="espd" uri="urn:X-test:UBL:Pre-award:QualificationApplicationRequest"/>
	
<!--
    Start of synthesis of rules from criterion ('/cac:TenderingCriterion') constraints ESPD Request and ESPD Response
	Currently, the rules implemented are those related to the obligatory nature of an element.

    Illustration of criterion constraints - 03 ESPD Common Criterion BR.sch
	ESPD Version: 2.0.2
-->
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-COM-CR">
		<!-- A tendering criterion describes a fact or a condition that is used by the contracting body to evaluate and compare tenders by economic operators and which will be used for the 
		exclusion and the selection of candidate tenderers to the award decision. -->
		<rule context="cac:TenderingCriterion">
			<!-- Cardinality constraints -->
			<assert test="(cbc:ID)" role="error">The identifier of the criterion ('/cac:TenderingCriterion/cbc:ID') is mandatory.</assert>
			<assert test="(cbc:CriterionTypeCode)" role="error">Classification code ('/cac:TenderingCriterion/cbc:CriterionTypeCode') to represent the criterion in the ESPD taxonomy of criteria is mandatory.</assert>
			<assert test="(cbc:Name)" role="error">The name of the criterion ('/cac:TenderingCriterion/cbc:Name') is mandatory.</assert>
			<assert test="(cbc:Description)" role="error">An extended description of the criterion ('/cac:TenderingCriterion/cbc:Description') is mandatory.</assert>			
		</rule>
		
		<!-- A reference to the legislation related to the Criterion. -->
		<rule context="cac:Legislation">
			<!-- Cardinality constraints -->
			<assert test="(cbc:Title)" role="error">The complete title of the legislation (/cac:TenderingCriterion/cac:Legislation/cbc:Title') provided is mandatory.</assert>
			<assert test="(cbc:Description)" role="warning">The description of the legislation (/cac:TenderingCriterion/cac:Legislation/cbc:Description') provided in the original legal text SHOULD be provided.</assert>
			<assert test="(cbc:Article)" role="warning">Other articles where the Criterion is referred to (/cac:TenderingCriterion/cac:Legislation/cbc:Article') SHOULD be provided.</assert>
		</rule>
		
		<!-- The first level group of properties and sub-groups of properties in the structure of a criterion. -->
		<rule context="cac:TenderingCriterionPropertyGroup | cac:SubsidiaryTenderingCriterionPropertyGroup">
			<!-- Cardinality constraints -->
			<assert test="(cbc:ID)" role="error">The identifier of a group of requirements ('<value-of select="name()"/>/cbc:ID') is mandatory.</assert>
			<assert test="(cbc:PropertyGroupTypeCode)" role="error">Code addressed to control the behavior of the group of criteria ('<value-of select="name()"/>/cbc:PropertyGroupTypeCode') is mandatory.</assert>			
		</rule>
		
		<!-- Caption, specific MS or contracting authority requirement -->
		<rule context="cac:TenderingCriterionProperty">
			<!-- Cardinality constraints -->
			<assert test="(cbc:ID)" role="error">The identifier of a specific property ('<value-of select="name()"/>/cbc:ID') is mandatory.</assert>
			<assert test="(cbc:Description)" role="error">The text of the caption, requirement or question ('<value-of select="name()"/>/cbc:Description') is mandatory.</assert>
			<assert test="(cbc:TypeCode)" role="error">The type of property ('<value-of select="name()"/>/cbc:Description') is mandatory.</assert>
			<assert test="(cbc:ValueDataTypeCode)" role="error">The type of answer expected by the contracting authority ('<value-of select="name()"/>/cbc:ValueDataTypeCode') is mandatory.</assert>		</rule>
		
	</pattern>
</schema>
