<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<title>ESPD Response Criterion Business Rules</title>
  
	<ns prefix="cac" uri="urn:X-test:UBL:Pre-award:CommonAggregate"/>
	<ns prefix="cbc" uri="urn:X-test:UBL:Pre-award:CommonBasic"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="espd" uri="urn:X-test:UBL:Pre-award:QualificationApplicationResponse"/>
	<ns prefix="fn" uri="http://www.w3.org/2005/xpath-functions"/>
	
<!--
    Start of synthesis of rules from criterion constraints ESPD Response

    Illustration of procurer constraints - 04 ESPD Resp Criterion BR.sch
	ESPD Version: 2.0.2
-->
	
	<xsl:key name="CriterionProperty" match="cac:TenderingCriterionProperty" use="cbc:ID"/>
	<xsl:key name="EvidenceID" match="cac:Evidence" use="cbc:ID"/>
	
	<xsl:key name="CriterionResponseType" match="cac:TenderingCriterionResponse" use="cbc:ValidatedCriterionPropertyID"/>
	<xsl:key name="TenderingCriteria" match="cac:TenderingCriterion" use="cbc:CriterionTypeCode"/>
	
    <xsl:key name="EORoleTest" match="cbc:RoleCode" use="." />
			
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-RESP-CRI">
		<rule context="cac:TenderingCriterionProperty/cbc:ID">
			<let name="responseIDs" value="key('CriterionResponseType', .)"/>
			
			<!-- BR-TCR-01-03: /cac:TenderingCriterionProperty/cbc:ID must have 0 or 1 /cac:TenderingCriterionResponse/cbc:ValidatedCriterionPropertyID -->
			<assert test="count($responseIDs) &lt;= 1" flag="fatal" id="BR-TCR-01-03">The criterion property ('cac:TenderingCriterionProperty/cbc:ID' = '<value-of select="."/>') has '<value-of select="count($responseIDs)"/>' responses.</assert>
			
		</rule>
		
		<rule context="cac:TenderingCriterionResponse">
			<let name="currentDataType" value="key('CriterionProperty', cbc:ValidatedCriterionPropertyID)/cbc:ValueDataTypeCode/text()"/>
						
			<!-- Cardinality constraints -->
			<!-- BR-TCR-01-01: /cbc:ValidatedCriterionPropertyID is mandatory. -->
			<assert test="(cbc:ValidatedCriterionPropertyID)" flag="fatal" id="BR-TCR-01-01">A cross-reference ('/cbc:ValidatedCriterionPropertyID') to the criterion property is mandatory.</assert>
			
			<!-- BR-TCR-03: Only one of the /cac:TenderingCriterionResponse sub elements (/cac:ResponseValue, /cac:ApplicablePeriod or /cac:EvidenceSupplied) is mandatory. -->
			<assert test="(count(cac:ResponseValue) + count(cac:ApplicablePeriod) + count(cac:EvidenceSupplied))=1" flag="fatal" id="BR-TCR-03">One and only one response element ('/cac:ResponseValue', '/cac:ApplicablePeriod' or '/cac:EvidenceSupplied') per criterion response ('/cac:TenderingCriterionResponse/cbc:ValidatedCriterionPropertyID = <value-of select="cbc:ValidatedCriterionPropertyID"/>') is mandatory.</assert>
			
			<!-- BR-TCR-01-02: /cac:TenderingCriterionResponse/cbc:ValidatedCriterionPropertyID must match one of the IDs within /cac:TenderingCriterionProperty/cbc:ID -->
			<assert test="((cbc:ValidatedCriterionPropertyID) and (count(key('CriterionProperty', cbc:ValidatedCriterionPropertyID))=1)) or not(cbc:ValidatedCriterionPropertyID)" flag="fatal" id="BR-TCR-01-02">The criterion response ('cbc:ValidatedCriterionPropertyID' = '<value-of select="cbc:ValidatedCriterionPropertyID"/>') does not have a cross-reference to a criterion property ('cac:TenderingCriterionProperty/cbc:ID').</assert>
			
			<!-- BR-TCR-09: The expected Evidence identifier must match the value of a cac:Evidence/cbc:ID present in the XML document.
				/cac:TenderingCriterionResponse/cac:EvidenceSupplied/cbc:ID must match one of the IDs within /cac:Evidence/cbc:ID -->
			<assert test="((cac:EvidenceSupplied) and (count(key('EvidenceID', cac:EvidenceSupplied/cbc:ID)) = 1)) or not(cac:EvidenceSupplied)" flag="fatal" id="BR-TCR-09">The evidence response ('cac:EvidenceSupplied/cbc:ID' = '<value-of select="cac:EvidenceSupplied/cbc:ID"/>') does not have a corss-reference to the evidence identifier ('cac:Evidence/cbc:ID').</assert>
			
			<!-- BR-TCR-08: The mandatory sub-element within /cac:TenderingCriterionResponse/cac:ResponseValue depends on /cac:TenderingCriterion /cac:TenderingCriterionPropertyGroup /cac:TenderingCriterionProperty /cac:ValueDataTypeCode -->
			<!-- AMOUNT = cac:ResponseValue/cbc:ResponseAmount -->
			<assert test="( ($currentDataType = 'AMOUNT') and (cac:ResponseValue/cbc:ResponseAmount) ) or not($currentDataType = 'AMOUNT')" flag="fatal" id="BR-TCR-08-01">The type of answer expected by the contracting authority is 'AMOUNT' ('cac:ResponseValue/cbc:ResponseAmount' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- CODE = cac:ResponseValue/cbc:ResponseCode -->
			<assert test="( ($currentDataType = 'CODE') and (cac:ResponseValue/cbc:ResponseCode) ) or not($currentDataType = 'CODE')" flag="fatal" id="BR-TCR-08-02">The type of answer expected by the contracting authority is 'CODE' ('cac:ResponseValue/cbc:ResponseCode' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- CODE_COUNTRY = cac:ResponseValue/cbc:ResponseCode -->
			<assert test="( ($currentDataType = 'CODE_COUNTRY') and (cac:ResponseValue/cbc:ResponseCode) ) or not($currentDataType = 'CODE_COUNTRY')" flag="fatal" id="BR-TCR-08-03">The type of answer expected by the contracting authority is 'CODE_COUNTRY' ('cac:ResponseValue/cbc:ResponseCode' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- DATE = cac:ResponseValue/cbc:ResponseDate -->
			<assert test="( ($currentDataType = 'DATE') and (cac:ResponseValue/cbc:ResponseDate) ) or not($currentDataType = 'DATE')" flag="fatal" id="BR-TCR-08-04">The type of answer expected by the contracting authority is 'DATE' ('cac:ResponseValue/cbc:ResponseDate' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- DESCRIPTION = cac:ResponseValue/cbc:Description -->
			<assert test="( ($currentDataType = 'DESCRIPTION') and (cac:ResponseValue/cbc:Description) ) or not($currentDataType = 'DESCRIPTION')" flag="fatal" id="BR-TCR-08-05">The type of answer expected by the contracting authority is 'DESCRIPTION' ('cac:ResponseValue/cbc:Description' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- EVIDENCE_IDENTIFIER = cac:EvidenceSupplied/cbc:ID -->
			<assert test="( ($currentDataType = 'EVIDENCE_IDENTIFIER') and (cac:EvidenceSupplied/cbc:ID) ) or not($currentDataType = 'EVIDENCE_IDENTIFIER')" flag="fatal" id="BR-TCR-08-06">The type of answer expected by the contracting authority is 'EVIDENCE_IDENTIFIER' ('cac:EvidenceSupplied/cbc:ID' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- INDICATOR = cac:ResponseValue/cbc:ResponseIndicator -->
			<assert test="( ($currentDataType = 'INDICATOR') and (cac:ResponseValue/cbc:ResponseIndicator) ) or not($currentDataType = 'INDICATOR')" flag="fatal" id="BR-TCR-08-07">The type of answer expected by the contracting authority is 'INDICATOR' ('cac:ResponseValue/cbc:ResponseIndicator' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- PERCENTAGE = cac:ResponseValue/cbc:ResponseMeasure/unitCode="PERCENTAGE" -->
			<assert test="( ($currentDataType = 'PERCENTAGE') and (cac:ResponseValue/cbc:ResponseMeasure/@unitCode = 'PERCENTAGE') ) or not($currentDataType = 'PERCENTAGE')" flag="fatal" id="BR-TCR-08-08">The type of answer expected by the contracting authority is 'PERCENTAGE' ('cac:ResponseValue/cbc:ResponseMeasure' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- PERIOD = cac:ApplicablePeriod -->
			<assert test="( ($currentDataType = 'PERIOD') and (cac:ApplicablePeriod) ) or not($currentDataType = 'PERIOD')" flag="fatal" id="BR-TCR-08-09">The type of answer expected by the contracting authority is 'PERIOD' ('cac:ApplicablePeriod' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- QUANTITY_INTEGER = cac:ResponseValue/cbc:ResponseMeasure -->
			<assert test="( ($currentDataType = 'QUANTITY_INTEGER') and (cac:ResponseValue/cbc:ResponseMeasure) ) or not($currentDataType = 'QUANTITY_INTEGER')" flag="fatal" id="BR-TCR-08-10">The type of answer expected by the contracting authority is 'QUANTITY_INTEGER' ('cac:ResponseValue/cbc:ResponseMeasure' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- QUANTITY_YEAR = cac:ResponseValue/cbc:ResponseMeasure/@unitCode="YEAR" -->
			<assert test="( ($currentDataType = 'QUANTITY_YEAR') and (cac:ResponseValue/cbc:ResponseMeasure/@unitCode='YEAR') ) or not($currentDataType = 'QUANTITY_YEAR')" flag="fatal" id="BR-TCR-08-11">The type of answer expected by the contracting authority is 'QUANTITY_YEAR' ('cac:ResponseValue/cbc:ResponseMeasure' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- QUANTITY = cac:ResponseValue/cbc:ResponseQuantity/@unitCode -->
			<assert test="( ($currentDataType = 'QUANTITY') and (cac:ResponseValue/cbc:ResponseQuantity) ) or not($currentDataType = 'QUANTITY')" flag="fatal" id="BR-TCR-08-12">The type of answer expected by the contracting authority is 'QUANTITY' ('cac:ResponseValue/cbc:ResponseQuantity' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- IDENTIFIER = cac:ResponseValue/cbc:ResponseID -->
			<assert test="( ($currentDataType = 'IDENTIFIER') and (cac:ResponseValue/cbc:ResponseID) ) or not($currentDataType = 'IDENTIFIER')" flag="fatal" id="BR-TCR-08-13">The type of answer expected by the contracting authority is 'IDENTIFIER' ('ac:ResponseValue/cbc:ResponseID' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- URL = cac:ResponseValue/cbc:ResponseURI -->
			<assert test="( ($currentDataType = 'URL') and (cac:ResponseValue/cbc:ResponseURI) ) or not($currentDataType = 'URL')" flag="fatal" id="BR-TCR-08-14">The type of answer expected by the contracting authority is 'URL' ('cac:ResponseValue/cbc:ResponseURI' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- MAXIMUM_AMOUNT = cac:ResponseValue/cbc:ResponseAmount -->
			<assert test="( ($currentDataType = 'MAXIMUM_AMOUNT') and (cac:ResponseValue/cbc:ResponseAmount) ) or not($currentDataType = 'MAXIMUM_AMOUNT')" flag="fatal" id="BR-TCR-08-15">The type of answer expected by the contracting authority is 'MAXIMUM_AMOUNT' ('cac:ResponseValue/cbc:ResponseAmount' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- MINIMUM_AMOUNT = cac:ResponseValue/cbc:ResponseAmount -->
			<assert test="( ($currentDataType = 'MINIMUM_AMOUNT') and (cac:ResponseValue/cbc:ResponseAmount) ) or not($currentDataType = 'MINIMUM_AMOUNT')" flag="fatal" id="BR-TCR-08-16">The type of answer expected by the contracting authority is 'MINIMUM_AMOUNT' ('cac:ResponseValue/cbc:ResponseAmount' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- MAXIMUM_VALUE_NUMERIC = cac:ResponseValue/cbc:ResponseNumeric -->
			<assert test="( ($currentDataType = 'MAXIMUM_VALUE_NUMERIC') and (cac:ResponseValue/cbc:ResponseNumeric) ) or not($currentDataType = 'MAXIMUM_VALUE_NUMERIC')" flag="fatal" id="BR-TCR-08-17">The type of answer expected by the contracting authority is 'MAXIMUM_VALUE_NUMERIC' ('cac:ResponseValue/cbc:ResponseNumeric' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- TRANSLATION_TYPE_CODE = cac:ResponseValue/cbc:ResponseCode -->
			<assert test="( ($currentDataType = 'TRANSLATION_TYPE_CODE') and (cac:ResponseValue/cbc:ResponseCode) ) or not($currentDataType = 'TRANSLATION_TYPE_CODE')" flag="fatal" id="BR-TCR-08-18">The type of answer expected by the contracting authority is 'TRANSLATION_TYPE_CODE' ('cac:ResponseValue/cbc:ResponseCode' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- CERTIFICATION_LEVEL_DESCRIPTION = cac:ResponseValue/cbc:Description -->
			<assert test="( ($currentDataType = 'CERTIFICATION_LEVEL_DESCRIPTION') and (cac:ResponseValue/cbc:Description) ) or not($currentDataType = 'CERTIFICATION_LEVEL_DESCRIPTION')" flag="fatal" id="BR-TCR-08-19">The type of answer expected by the contracting authority is 'CERTIFICATION_LEVEL_DESCRIPTION' ('cac:ResponseValue/cbc:Description' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- COPY_QUALITY_TYPE_CODE = cac:ResponseValue/cbc:ResponseCode -->
			<assert test="( ($currentDataType = 'COPY_QUALITY_TYPE_CODE') and (cac:ResponseValue/cbc:ResponseCode) ) or not($currentDataType = 'COPY_QUALITY_TYPE_CODE')" flag="fatal" id="BR-TCR-08-20">The type of answer expected by the contracting authority is 'COPY_QUALITY_TYPE_CODE' ('cac:ResponseValue/cbc:ResponseCode' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- TIME = cac:ResponseValue/cbc:ResponseTime -->
			<assert test="( ($currentDataType = 'TIME') and (cac:ResponseValue/cbc:ResponseTime) ) or not($currentDataType = 'TIME')" flag="fatal" id="BR-TCR-08-21">The type of answer expected by the contracting authority is 'TIME' ('cac:ResponseValue/cbc:ResponseTime' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			
		</rule>
		
		<rule context="cac:TenderingCriterionResponse/cac:ResponseValue">
			<!-- BR-TCR-04: Only one sub-element within /cac:TenderingCriterionResponse/cac:ResponseValue is admitted at the same time. -->
			<assert test="count(child::*) &lt;= 2" flag="fatal" id="BR-TCR-04">Only one sub-element within '/cac:TenderingCriterionResponse/cac:ResponseValue' is admitted at the same time. The criteria response ('/cac:TenderingCriterionResponse/cbc:ValidatedCriterionPropertyID = <value-of select="ancestor::*[1]/cbc:ValidatedCriterionPropertyID"/>') has '<value-of select="count(child::*)-1"/>' sub-element(s).</assert>
		</rule>
		
		<rule context="cac:SubsidiaryTenderingCriterionPropertyGroup[cbc:PropertyGroupTypeCode = 'ONTRUE']/cac:TenderingCriterionProperty">
			<!-- BR-TCR-06: Groups codified as ONTRUE must be processed if response is True. -->			
			<let name="parentUUID" value="ancestor::*[1]/ancestor::*[1]/cac:TenderingCriterionProperty/cbc:ID"/>
			<let name="parentTrueResponse" value="key('CriterionResponseType', $parentUUID)/cac:ResponseValue/cbc:ResponseIndicator = true()"/>
			<let name="parentFalseResponse" value="key('CriterionResponseType', $parentUUID)/cac:ResponseValue/cbc:ResponseIndicator = false()"/>
			
			<!-- IF parentResponse=TRUE -> THEN current property must have an answer -->
			<assert test="not($parentTrueResponse) or ($parentTrueResponse and count(key('CriterionResponseType', cbc:ID)) = 1)" flag="fatal" id="BR-TCR-06-01">As the response '<value-of select="$parentUUID"/>' is TRUE and the property group is codified as ONTRUE, 'cbc:ID = <value-of select='cbc:ID'/>' must be answered as well.</assert>
			<!-- IF parentResponse=FALSE -> THEN current property must not have an answer -->
			<assert test="not($parentFalseResponse) or ($parentFalseResponse and count(key('CriterionResponseType', cbc:ID)) = 0)" flag="fatal" id="BR-TCR-06-02">As the response '<value-of select="$parentUUID"/>' is FALSE but the property group is codified as ONTRUE, 'cbc:ID = <value-of select='cbc:ID'/>' must not be answered.</assert>
		</rule>
		
		<rule context="cac:SubsidiaryTenderingCriterionPropertyGroup[cbc:PropertyGroupTypeCode = 'ONFALSE']/cac:TenderingCriterionProperty">
			<!-- BR-TCR-07: Groups codified as ONFALSE must be processed if response is False. -->			
			<let name="parentUUID" value="ancestor::*[1]/ancestor::*[1]/cac:TenderingCriterionProperty/cbc:ID"/>
			<let name="parentTrueResponse" value="key('CriterionResponseType', $parentUUID)/cac:ResponseValue/cbc:ResponseIndicator = true()"/>
			<let name="parentFalseResponse" value="key('CriterionResponseType', $parentUUID)/cac:ResponseValue/cbc:ResponseIndicator = false()"/>
			
			<!-- IF parentResponse=FALSE -> THEN current property must have an answer -->
			<assert test="not($parentFalseResponse) or ($parentFalseResponse and count(key('CriterionResponseType', cbc:ID)) = 1)" flag="fatal" id="BR-TCR-07-01">As the response '<value-of select="$parentUUID"/>' is FALSE and the property group is codified as ONFALSE, 'cbc:ID = <value-of select='cbc:ID'/>' must be answered as well.</assert>
			<!-- IF parentResponse=TRUE -> THEN current property must not have an answer -->
			<assert test="not($parentTrueResponse) or ($parentTrueResponse and count(key('CriterionResponseType', cbc:ID)) = 0)" flag="fatal" id="BR-TCR-07-02">As the response '<value-of select="$parentUUID"/>' is TRUE but the property group is codified as ONFALSE, 'cbc:ID = <value-of select='cbc:ID'/>' must not be answered.</assert>
		</rule>
		
	</pattern>
</schema>
