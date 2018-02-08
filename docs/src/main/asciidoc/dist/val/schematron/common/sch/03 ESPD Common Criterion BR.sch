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

    Illustration of criterion constraints - 03 ESPD Common Criterion BR.sch
	ESPD Version: 2.0.0
-->
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-COM-CRI">
		<!-- A tendering criterion describes a fact or a condition that is used by the contracting body to evaluate and compare tenders by economic operators and which will be used for the 
		exclusion and the selection of candidate tenderers to the award decision. -->
		<rule context="cac:TenderingCriterion">
			<!-- Cardinality constraints -->
			<assert test="(cbc:ID)" role="error">The identifier of the criterion ('/cac:TenderingCriterion/cbc:ID') is mandatory.</assert>
			<assert test="(cbc:CriterionTypeCode)" role="error">Classification code ('/cac:TenderingCriterion/cbc:CriterionTypeCode') to represent the criterion in the ESPD taxonomy of criteria is mandatory.</assert>
			<assert test="(cbc:Name)" role="error">The name of the criterion ('/cac:TenderingCriterion/cbc:Name') is mandatory.</assert>
			<assert test="(cbc:Description)" role="error">An extended description of the criterion ('/cac:TenderingCriterion/cbc:Description') is mandatory.</assert>
			
			<!-- /cac:TenderingCriterion/cbc:ID must match the “Element UUID” column from [RD03] -->
			<let name="ElementUUID" value="document('ESPD-CriteriaTaxonomy-REGULATED.V02.00.01.xml')/espd:QualificationApplicationRequest"/>
			<let name="currentID" value="cbc:ID"/>
			<let name="currentCode" value="cbc:CriterionTypeCode"/>
			<let name="currentName" value="cbc:Name"/>
			<let name="currentDesc" value="cbc:Description"/>
			
			<assert test="count($ElementUUID/cac:TenderingCriterion[cbc:ID = $currentID]/cbc:ID) = 1" role="error">Each Criterion is defined in e-Certis and must use the UUID supplied by e-Certis. The UUID '<value-of select="$currentID"/>' is not defined in e-Certis.</assert>
			<assert test="$ElementUUID/cac:TenderingCriterion[cbc:ID = $currentID]/cbc:CriterionTypeCode = $currentCode" role="error">The criterion type code should match the one from e-Certis. The code '<value-of select="$currentCode"/>' is not defined in e-Certis.</assert>
			<assert test="$ElementUUID/cac:TenderingCriterion[cbc:ID = $currentID]/cbc:Name = $currentName" role="warning">The name should match the one from e-Certis. The name '<value-of select="$currentName"/>' is not defined in e-Certis.</assert>
			<assert test="$ElementUUID/cac:TenderingCriterion[cbc:ID = $currentID]/cbc:Description = $currentDesc" role="warning">The description should match the one from e-Certis. The description '<value-of select="$currentDesc"/>' is not defined in e-Certis.</assert>
			
		</rule>
		
		<!-- A reference to the legislation related to the Criterion. -->
		<rule context="cac:Legislation">
			<!-- Cardinality constraints -->
			<assert test="(cbc:Title)" role="error">The complete title of the legislation (/cac:TenderingCriterion/cac:Legislation/cbc:Title') provided is mandatory.</assert>
			<assert test="(cbc:Description)" role="warning">The description of the legislation (/cac:TenderingCriterion/cac:Legislation/cbc:Description') provided in the original legal text SHOULD be provided.</assert>
			<assert test="(cbc:Article)" role="warning">Other articles where the Criterion is referred to (/cac:TenderingCriterion/cac:Legislation/cbc:Article') SHOULD also be provided.</assert>
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
			<assert test="(cbc:ValueDataTypeCode)" role="error">The type of answer expected by the contracting authority ('<value-of select="name()"/>/cbc:ValueDataTypeCode') is mandatory.</assert>
			
			<!-- Verify that the value is different to NONE for properties of type QUESTION. -->
			<assert test="( (cbc:TypeCode='CAPTION' or cbc:TypeCode='REQUIREMENT') and cbc:ValueDataTypeCode='NONE') or (cbc:TypeCode='QUESTION' and not(cbc:ValueDataTypeCode='NONE'))" role="error">The type of answer ('cbc:ValueDataTypeCode') must be different to NONE for properties ('cbc:TypeCode') of type QUESTION; or equal to NONE for properties of type CAPTION and REQUIREMENT. The current value are 'cbc:ValueDataTypeCode'='<value-of select="cbc:ValueDataTypeCode"/>' and 'cbc:TypeCode'='<value-of select="cbc:TypeCode"/>'</assert>
			<assert test="(cbc:TypeCode='QUESTION' and not(cbc:ValueDataTypeCode = 'NONE') and (count(cac:TemplateEvidence) + count(cac:ApplicablePeriod) + count(cbc:CertificationLevelDescription) + count(cbc:MinimumValueNumeric) + count(cbc:MaximumValueNumeric) + count(cbc:ExpectedValueNumeric) + count(cbc:ExpectedCode) + count(cbc:ValueCurrencyCode) + count(cbc:ValueUnitCode) + count(cbc:ExpectedID))&lt;2)
			or ( (cbc:TypeCode='CAPTION' or cbc:TypeCode='REQUIREMENT') and cbc:ValueDataTypeCode='NONE')">For properties of type QUESTION, a maximum of one subelement can be filled-in.</assert>
		</rule>
		
	</pattern>
</schema>
