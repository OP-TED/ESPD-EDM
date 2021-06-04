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
	ESPD Version: 2.0.2
-->
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-COM-CR">
		<!-- A tendering criterion describes a fact or a condition that is used by the contracting body to evaluate and compare tenders by economic operators and which will be used for the 
		exclusion and the selection of candidate tenderers to the award decision. -->
		<rule context="cac:TenderingCriterion">
			<!-- Common variables -->
			<let name="currentID" value="cbc:ID"/>
			<let name="currentIDExist" value="(cbc:ID) and not(normalize-space(cbc:ID) = '')"/>
			<let name="applicationType" value="/*[1]/cbc:QualificationApplicationTypeCode"/>
			
			<let name="ElementUUID" value="if ($applicationType!='SELFCONTAINED') then document('ESPD-CriteriaTaxonomy-REGULATED.V2.0.2.xml')//cac:TenderingCriterion[cbc:ID = $currentID] 
				else document('ESPD-CriteriaTaxonomy-SELFCONTAINED.V2.0.2.xml')//cac:TenderingCriterion[cbc:ID = $currentID]"/>
			<let name="ElementUUIDExists" value="(count($ElementUUID/cbc:ID) = 1)"/>
			
			<!-- Cardinality constraints -->
			<!-- BR-TC-02#01: /cac:TenderingCriterion/cbc:ID is mandatory -->
			<assert test="$currentIDExist" flag="fatal" id="BR-TC-02-01">The identifier of the criterion ('/cac:TenderingCriterion/cbc:ID') is mandatory.</assert>
			<!-- BR-TC-03: /cac:TenderingCriterion /cbc:CriterionTypeCode is mandatory -->
			<assert test="(cbc:CriterionTypeCode)" flag="fatal" id="BR-TC-03">Classification code ('/cac:TenderingCriterion/cbc:CriterionTypeCode') to represent the criterion in the ESPD taxonomy of criteria is mandatory.</assert>
			<!-- BR-TC-05: /cac:TenderingCriterion/cbc:Name is mandatory -->
			<assert test="(cbc:Name)" flag="fatal" id="BR-TC-05">The name of the criterion ('/cac:TenderingCriterion/cbc:Name') is mandatory.</assert>
			<!-- BR-TC-06: /cac:TenderingCriterion/cbc:Description is mandatory -->
			<assert test="(cbc:Description)" flag="fatal" id="BR-TC-06">An extended description of the criterion ('/cac:TenderingCriterion/cbc:Description') is mandatory.</assert>
			
			<!-- BT-TC-07: Number of /cac:TenderingCriterion/cac:TenderingCriterionPropertyGroup must match the number of QUESTION_GROUP from [RD03] -->
			<assert test="not($ElementUUIDExists) or ((count($ElementUUID/cac:TenderingCriterionPropertyGroup) &lt;= count(cac:TenderingCriterionPropertyGroup)) and ($ElementUUIDExists))" flag="fatal" id="BR-TC-07">The Tendering Criterion, which 'cac:TenderingCriterion/cbc:ID = <value-of select="cbc:ID"/>', has '<value-of select="count($ElementUUID/cac:TenderingCriterionPropertyGroup) - count(cac:TenderingCriterionPropertyGroup)"/>' missing 'cac:TenderingCriterionPropertyGroup' element(s).</assert>
			
			<!-- /cac:TenderingCriterion/cbc:ID, cbc:CriterionTypeCode must match the document [RD03] -->
			<let name="currentCode" value="cbc:CriterionTypeCode"/>
			
			<!-- BR-TC-02#02: /cac:TenderingCriterion/cbc:ID must match the “Element UUID” column from [RD03] -->
			<assert test="not($currentIDExist) or ($ElementUUIDExists and ($currentIDExist))" flag="fatal" id="BR-TC-02-02">Each criterion must use the UUID supplied by e-Certis. The '/cac:TenderingCriterion/cbc:ID = <value-of select="$currentID"/>' is not defined in e-Certis.</assert>
			<!-- BR-TC-04: /cac:TenderingCriterion /cbc:CriterionTypeCode must match the “Element Code” column from [RD03] -->
			<assert test="not($ElementUUIDExists) or ($ElementUUID/cbc:CriterionTypeCode = $currentCode and ($ElementUUIDExists))" flag="fatal" id="BR-TC-04">The criterion type code should match the one from e-Certis. The code '/cac:TenderingCriterion/cbc:CriterionTypeCode = <value-of select="$currentCode"/>' is not defined in e-Certis.</assert>
		</rule>
		
		<!-- A reference to the legislation related to the Criterion. -->
		<rule context="cac:Legislation">
			<!-- Cardinality constraints -->
			<!-- BR-TC-09: Title of the legislation is mandatory -->
			<assert test="(cbc:Title)" flag="fatal" id="BR-TC-09">The complete title of the legislation (/cac:TenderingCriterion/cac:Legislation/cbc:Title') provided is mandatory.</assert>
			<!-- BR-TC-10: The description of the legislation provided in the original legal text SHOULD be provided -->
			<assert test="(cbc:Description)" flag="warning" id="BR-TC-10">The description of the legislation (/cac:TenderingCriterion/cac:Legislation/cbc:Description') provided in the original legal text SHOULD be provided.</assert>
			<!-- BR-TC-11: Other articles where the Criterion is referred to SHOULD also be provided -->
			<assert test="(cbc:Article)" flag="warning" id="BR-TC-11">Other articles where the Criterion is referred to (/cac:TenderingCriterion/cac:Legislation/cbc:Article') SHOULD also be provided.</assert>
		</rule>
		
		<!-- N-level group of sub-groups of properties in the structure of a criterion. -->
		<!-- A tendering criterion describes a fact or a condition that is used by the contracting body to evaluate and compare tenders by economic operators and which will be used for the 
		exclusion and the selection of candidate tenderers to the award decision. -->
		<rule context="cac:TenderingCriterionPropertyGroup | cac:SubsidiaryTenderingCriterionPropertyGroup">	
			<!-- Common variables -->
			<let name="currentID" value="cbc:ID"/>
			<let name="currentCode" value="cbc:PropertyGroupTypeCode"/>
			<let name="parentID" value="ancestor::*[1]/cbc:ID"/>
			
			<!-- cac:SubsidiaryTenderingCriterionPropertyGroup -->
			<let name="applicationType" value="/*[1]/cbc:QualificationApplicationTypeCode"/>
			
			<let name="ElementUUID_SUB" value="if ($applicationType!='SELFCONTAINED') then document('ESPD-CriteriaTaxonomy-REGULATED.V2.0.2.xml')//cac:SubsidiaryTenderingCriterionPropertyGroup[cbc:ID = $currentID] 
				else document('ESPD-CriteriaTaxonomy-SELFCONTAINED.V2.0.2.xml')//cac:SubsidiaryTenderingCriterionPropertyGroup[cbc:ID = $currentID]"/>
			<let name="ParentUUID_SUB" value="$ElementUUID_SUB[parent::*[cbc:ID = $parentID]][1]"/>
			
			<!-- cac:TenderingCriterionPropertyGroup -->
			<let name="ElementUUID_T" value="if ($applicationType!='SELFCONTAINED') then document('ESPD-CriteriaTaxonomy-REGULATED.V2.0.2.xml')//cac:TenderingCriterionPropertyGroup[cbc:ID = $currentID] 
				else document('ESPD-CriteriaTaxonomy-SELFCONTAINED.V2.0.2.xml')//cac:TenderingCriterionPropertyGroup[cbc:ID = $currentID]"/>
			<let name="ParentUUID_T" value="$ElementUUID_T[parent::*[cbc:ID = $parentID]][1]"/>
			
			<let name="ElementUUID_TExists" value="(count($ParentUUID_T/cbc:ID) &gt; 0)"/>
			<let name="ElementUUID_SUBExists" value="(count($ParentUUID_SUB/cbc:ID) &gt; 0)"/>
			
			<let name="ElementUUIDExists" value="$ElementUUID_SUBExists or $ElementUUID_TExists"/>
			<let name="currentIDExist" value="(cbc:ID) and not(normalize-space(cbc:ID) = '') and ($ElementUUIDExists)"/>
			
			<!-- Cardinality constraints -->
			<!-- BR-TC-12: The ID which identifies one specific property is mandatory -->
			<assert test="(cbc:ID)" flag="fatal" id="BR-TC-12">The identifier of a group of requirements ('<value-of select="name()"/>/cbc:ID') is mandatory.</assert>
			<!-- BR-TC-14: Code addressed to control the behaviour of the group of criteria is mandatory. -->
			<assert test="(cbc:PropertyGroupTypeCode)" flag="fatal" id="BR-TC-14">Code addressed to control the behavior of the group of criteria ('<value-of select="name()"/>/cbc:PropertyGroupTypeCode') is mandatory.</assert>
			
			<!-- BR-TC-16: Number of /cac:TenderingCriterionProperty must match the number of QUESTION from [RD03] -->
			<assert test="not($currentIDExist) or (($currentIDExist) and not($ElementUUID_TExists)) or (count($ParentUUID_T/cac:TenderingCriterionProperty) &lt;= count(cac:TenderingCriterionProperty) and ($currentIDExist) and ($ElementUUID_TExists))" flag="fatal" id="BR-TC-16-01">The tendering criterion property group ('<value-of select="name(ancestor::*[1])"/>[cbc:ID = '<value-of select="$parentID"/>']/<value-of select="name()"/>[cbc:ID = '<value-of select="$currentID"/>']') has '<value-of select="count($ParentUUID_T/cac:TenderingCriterionProperty) - count(cac:TenderingCriterionProperty)"/>' missing 'cac:TenderingCriterionProperty' element(s).</assert>
			<assert test="not($currentIDExist) or (($currentIDExist) and not($ElementUUID_SUBExists)) or (count($ParentUUID_SUB/cac:TenderingCriterionProperty) &lt;= count(cac:TenderingCriterionProperty) and ($currentIDExist) and ($ElementUUID_SUBExists))" flag="fatal" id="BR-TC-16-02">The subtendering criterion property group ('<value-of select="name(ancestor::*[1])"/>[cbc:ID = '<value-of select="$parentID"/>']/<value-of select="name()"/>[cbc:ID = '<value-of select="$currentID"/>']') has '<value-of select="count($ParentUUID_SUB/cac:TenderingCriterionProperty) - count(cac:TenderingCriterionProperty)"/>' missing 'cac:TenderingCriterionProperty' element(s).</assert>
						
			<!-- BR-TC-17: Number of /cac:SubsidiaryTenderingCriterionPropertyGroup must match the number of QUESTION from [RD03] -->
			<assert test="not($currentIDExist) or (($currentIDExist) and not($ElementUUID_TExists)) or (count($ParentUUID_T/cac:SubsidiaryTenderingCriterionPropertyGroup) &lt;= count(cac:SubsidiaryTenderingCriterionPropertyGroup) and ($currentIDExist) and ($ElementUUID_TExists))" flag="fatal" id="BR-TC-17-01">The tendering criterion property group ('<value-of select="name(ancestor::*[1])"/>[cbc:ID = '<value-of select="$parentID"/>']/<value-of select="name()"/>[cbc:ID = '<value-of select="$currentID"/>']') has '<value-of select="count($ParentUUID_T/cac:SubsidiaryTenderingCriterionPropertyGroup) - count(cac:SubsidiaryTenderingCriterionPropertyGroup)"/>' missing 'cac:SubsidiaryTenderingCriterionPropertyGroup' element(s).</assert>
			<assert test="not($currentIDExist) or (($currentIDExist) and not($ElementUUID_SUBExists)) or (count($ParentUUID_SUB/cac:SubsidiaryTenderingCriterionPropertyGroup) &lt;= count(cac:SubsidiaryTenderingCriterionPropertyGroup) and ($currentIDExist) and ($ElementUUID_SUBExists))" flag="fatal" id="BR-TC-17-02">The subtendering criterion property group ('<value-of select="name(ancestor::*[1])"/>[cbc:ID = '<value-of select="$parentID"/>']/<value-of select="name()"/>[cbc:ID = '<value-of select="$currentID"/>']') has '<value-of select="count($ParentUUID_SUB/cac:SubsidiaryTenderingCriterionPropertyGroup) - count(cac:SubsidiaryTenderingCriterionPropertyGroup)"/>' missing 'cac:SubsidiaryTenderingCriterionPropertyGroup' element(s).</assert>
						
			<!-- Subsidiary Tendering Criterion Property Group (identifier, type) exists in the data_structure, and within the same tendering criterion property. -->
			<!-- BR-TC-13: Each Criterion is defined in e-Certis and must use the UUID supplied by e-Certis. -->
			<assert test="(($ElementUUIDExists) and ((cbc:ID) and not(normalize-space(cbc:ID) = ''))) or not((cbc:ID) and not(normalize-space(cbc:ID) = ''))" flag="fatal" id="BR-TC-13">Compulsory use of the UUIDs supplied by e-Certis. The <value-of select="name()"/> ('<value-of select="name(ancestor::*[1])"/>[cbc:ID = '<value-of select="$parentID"/>']/<value-of select="name()"/>[cbc:ID = '<value-of select="$currentID"/>']') does not exist in e-Certis.</assert>
			<!-- BR-TC-15: Compulsory use of the group of criteria supplied by e-Certis. -->
			<assert test="not($currentIDExist) or (($currentIDExist) and not($ElementUUID_TExists)) or ($ParentUUID_T/cbc:PropertyGroupTypeCode = $currentCode and ($currentIDExist) and ($ElementUUID_TExists))" flag="fatal" id="BR-TC-15-01">The property group type code should match the one from e-Certis. The tendering criterion property group ('<value-of select="$currentCode"/>') does not exisit in the e-Certis for the following element '<value-of select="name(ancestor::*[1])"/>[cbc:ID = '<value-of select="$parentID"/>']/<value-of select="name()"/>[cbc:ID = '<value-of select="$currentID"/>'].</assert>
			<assert test="not($currentIDExist) or (($currentIDExist) and not($ElementUUID_SUBExists)) or ($ParentUUID_SUB/cbc:PropertyGroupTypeCode = $currentCode and ($currentIDExist) and ($ElementUUID_SUBExists))" flag="fatal" id="BR-TC-15-02">The property group type code should match the one from e-Certis. The subtendering criterion property group ('<value-of select="$currentCode"/>') does not exisit in the e-Certis for the following element '<value-of select="name(ancestor::*[1])"/>[cbc:ID = '<value-of select="$parentID"/>']/<value-of select="name()"/>[cbc:ID = '<value-of select="$currentID"/>'].</assert>
		</rule>	
		
		<!-- Caption, specific MS or contracting authority requirement -->
		<rule context="cac:TenderingCriterionProperty">
			<!-- Common variables -->			
			<let name="currentID" value="cbc:ID"/>
			<let name="currentDescr" value="cbc:Description"/>
			<let name="currentType" value="cbc:TypeCode"/>
			<let name="currentValueData" value="cbc:ValueDataTypeCode"/>
			
			<let name="TCPropertyGroupID" value="ancestor::*[1]/cbc:ID"/>		
			<let name="applicationType" value="/*[1]/cbc:QualificationApplicationTypeCode"/>	
			
			<!-- cac:SubsidiaryTenderingCriterionPropertyGroup -->
			<let name="ElementUUIDSTC" value="if ($applicationType!='SELFCONTAINED') then document('ESPD-CriteriaTaxonomy-REGULATED.V2.0.2.xml')//cac:SubsidiaryTenderingCriterionPropertyGroup[cbc:ID = $TCPropertyGroupID][1]/cac:TenderingCriterionProperty 
				else document('ESPD-CriteriaTaxonomy-SELFCONTAINED.V2.0.2.xml')//cac:SubsidiaryTenderingCriterionPropertyGroup[cbc:ID = $TCPropertyGroupID][1]/cac:TenderingCriterionProperty"/>
			<let name="ElementUUID_STCExists" value="(count($ElementUUIDSTC) &gt; 0)"/>
			
			<!-- cac:TenderingCriterionPropertyGroup -->
			<let name="ElementUUIDTC" value="if ($applicationType!='SELFCONTAINED') then document('ESPD-CriteriaTaxonomy-REGULATED.V2.0.2.xml')//cac:TenderingCriterionPropertyGroup[cbc:ID = $TCPropertyGroupID][1]/cac:TenderingCriterionProperty 
				else document('ESPD-CriteriaTaxonomy-SELFCONTAINED.V2.0.2.xml')//cac:TenderingCriterionPropertyGroup[cbc:ID = $TCPropertyGroupID][1]/cac:TenderingCriterionProperty"/>		
			<let name="ElementUUID_TCExists" value="(count($ElementUUIDTC) &gt; 0)"/>
			
			<let name="ElementUUIDExists" value="$ElementUUID_TCExists or $ElementUUID_STCExists"/>
			<let name="currentTypeExist" value="(cbc:TypeCode) and not(normalize-space(cbc:TypeCode) = '') and ($ElementUUIDExists)"/>
			<let name="currentValueTypeExist" value="(cbc:ValueDataTypeCode) and not(normalize-space(cbc:ValueDataTypeCode) = '') and ($ElementUUIDExists)"/>
			
			<!-- Cardinality constraints -->
			<!-- BR-TC-18: The ID which identifies one specific property is mandatory -->
			<assert test="(cbc:ID)" flag="fatal" id="BR-TC-18">The identifier of a specific property ('<value-of select="name()"/>/cbc:ID') is mandatory.</assert>
			<!-- BR-TC-19: The text of the caption, requirement or question is mandatory -->
			<assert test="(cbc:Description)" flag="fatal" id="BR-TC-19">The text of the caption, requirement or question ('<value-of select="name()"/>/cbc:Description') is mandatory.</assert>
			<!-- BR-TC-20-01: The type of property is mandatory -->
			<assert test="(cbc:TypeCode)" flag="fatal" id="BR-TC-20">The type of property ('<value-of select="name()"/>/cbc:TypeCode') is mandatory.</assert>
			<!-- BR-TC-21-01: ../cbc:ValueDataTypeCode is mandatory -->
			<assert test="(cbc:ValueDataTypeCode)" flag="fatal" id="BR-TC-21-01">The type of answer expected by the contracting authority ('<value-of select="name()"/>/cbc:ValueDataTypeCode') is mandatory.</assert>
						
			<!-- Other rules -->
			<!-- BR-TC-20-02 / BR-TC-21-03: /cac:TenderingCriterionProperty/cbc:TypeCode, cbc:ValueDataTypeCode must match the document [RD03] -->
			<assert test="not($currentTypeExist) or ((count($ElementUUIDTC[cbc:TypeCode = $currentType])&gt;=1 or count($ElementUUIDSTC[cbc:TypeCode = $currentType])&gt;=1) and ($currentTypeExist))" flag="fatal" id="BR-TC-20-02">The tendering criterion property group ('<value-of select="name(ancestor::*[1])"/>The tendering criterion property type code should match the one from e-Certis. The <value-of select="name(ancestor::*[1])"/>, which 'cbc:ID = <value-of select="$TCPropertyGroupID"/>', does not have a '<value-of select="name(ancestor::*[1])"/>/cac:TenderingCriterionProperty[cbc:ID = <value-of select="$currentID"/>]/cbc:TypeCode = <value-of select="$currentType"/>' defined in e-Certis.</assert>
			<assert test="not($currentValueTypeExist) or ((count($ElementUUIDTC[cbc:ValueDataTypeCode = $currentValueData])&gt;=1 or count($ElementUUIDSTC[cbc:ValueDataTypeCode = $currentValueData])&gt;=1) and ($currentValueTypeExist))" flag="fatal" id="BR-TC-21-03">The tendering criterion property value data type should match the one from e-Certis. The <value-of select="name(ancestor::*[1])"/>, which 'cbc:ID = <value-of select="$TCPropertyGroupID"/>', does not have a '<value-of select="name(ancestor::*[1])"/>/cac:TenderingCriterionProperty[cbc:ID = <value-of select="cbc:ID"/>]/cbc:ValueDataTypeCode = <value-of select="cbc:ValueDataTypeCode"/>' defined in e-Certis.</assert>			
			
			<!-- BR-TC-21-02: Verify that the value is different to NONE for properties of type QUESTION. -->
			<assert test="not($currentTypeExist and $currentValueTypeExist) or ( (cbc:TypeCode='CAPTION' and cbc:ValueDataTypeCode='NONE') or ((cbc:TypeCode='QUESTION' or cbc:TypeCode='REQUIREMENT') and not(cbc:ValueDataTypeCode='NONE')) and ($currentTypeExist and $currentValueTypeExist))" flag="fatal" id="BR-TC-21-02">The type of answer ('cbc:ValueDataTypeCode') must be different to NONE for properties ('cbc:TypeCode') of type QUESTION; or equal to NONE for properties of type CAPTION and REQUIREMENT. The current value is 'cbc:ValueDataTypeCode'='<value-of select="cbc:ValueDataTypeCode"/>' and 'cbc:TypeCode'='<value-of select="cbc:TypeCode"/>'</assert>
		
		</rule>
		
	</pattern>
</schema>
