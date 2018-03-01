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
	
		<rule context="espd:QualificationApplicationResponse">
			<let name="selectionCriterion" value="cac:TenderingCriterion[ starts-with(cbc:CriterionTypeCode, 'CRITERION.SELECTION.') and (count( key('CriterionResponseType', cac:TenderingCriterionPropertyGroup[1]/cac:TenderingCriterionProperty[1]/cbc:ID) ) = 0) ]"/>
			
			<!-- The entity does not have to provide information about the selection criteria. If EO role is OENRON - Other entity (not relied upon) -. -->
			<assert test="(count(key('EORoleTest', 'OENRON'))=1 and (count($selectionCriterion) = 0 )) or not(count(key('EORoleTest', 'OENRON'))=1)" flag="warning">The entity does not have to provide information about the selection criteria.</assert>
		</rule>
		
		<rule context="cac:TenderingCriterionResponse">
			<let name="currentDataType" value="key('CriterionProperty', cbc:ValidatedCriterionPropertyID)/cbc:ValueDataTypeCode/text()"/>
						
			<!-- Cardinality constraints -->
			<assert test="(cbc:ValidatedCriterionPropertyID)" flag="fatal">A cross-reference ('/cbc:ValidatedCriterionPropertyID') to the criterion property is mandatory.</assert>
			<assert test="(count(cac:ResponseValue) + count(cac:ApplicablePeriod) + count(cac:EvidenceSupplied))=1" flag="fatal">One and only one response element ('/cac:ResponseValue', 'cac:ApplicablePeriod' or 'cac:EvidenceSupplied') per criterion response is mandatory.</assert>
			<assert test="((cac:ResponseValue) and (count(cac:ResponseValue/child::*) = 2)) or not(cac:ResponseValue)" flag="fatal">Only one sub-element within '/cac:TenderingCriterionResponse/cac:ResponseValue' is admitted at the same time. Currently there are '<value-of select="count(cac:ResponseValue/child::*)"/>' sub-element(s).</assert>
		
			<!-- /cac:TenderingCriterionResponse/cbc:ValidatedCriterionPropertyID must match one of the IDs within /cac:TenderingCriterionProperty/cbc:ID -->
			<assert test="((cbc:ValidatedCriterionPropertyID) and (count(key('CriterionProperty', cbc:ValidatedCriterionPropertyID))=1)) or not(cbc:ValidatedCriterionPropertyID)" flag="fatal">The criterion response ('cbc:ValidatedCriterionPropertyID' = '<value-of select="cbc:ValidatedCriterionPropertyID"/>') does not have a cross-reference to the criterion property ('cac:TenderingCriterionProperty/cbc:ID').</assert>
			
			<!-- /cac:TenderingCriterionResponse/cac:EvidenceSupplied/cbc:ID must match one of the IDs within /cac:Evidence/cbc:ID -->
			<assert test="((cac:EvidenceSupplied) and (count(key('EvidenceID', cac:EvidenceSupplied/cbc:ID)) = 1)) or not(cac:EvidenceSupplied)" flag="fatal">The evidence response (' cac:EvidenceSupplied/cbc:ID' = '<value-of select="cac:EvidenceSupplied/cbc:ID"/>') does not have a corss-reference to the evidence identifier ('cac:Evidence/cbc:ID').</assert>
			
			<!-- The mandatory sub-element within /cac:TenderingCriterionResponse/cac:ResponseValue depends on /cac:TenderingCriterion /cac:TenderingCriterionPropertyGroup /cac:TenderingCriterionProperty /cac:ValueDataTypeCode -->
			<!-- AMOUNT = cac:ResponseValue/cbc:ResponseAmount -->
			<assert test="( ($currentDataType = 'AMOUNT') and (cac:ResponseValue/cbc:ResponseAmount) ) or not($currentDataType = 'AMOUNT')" flag="fatal">The type of answer expected by the contracting authority is 'AMOUNT' ('cac:ResponseValue/cbc:ResponseAmount' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- CODE = cac:ResponseValue/cbc:ResponseCode -->
			<assert test="( ($currentDataType = 'CODE') and (cac:ResponseValue/cbc:ResponseCode) ) or not($currentDataType = 'CODE')" flag="fatal">The type of answer expected by the contracting authority is 'CODE' ('cac:ResponseValue/cbc:ResponseCode' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- CODE_COUNTRY = cac:ResponseValue/cbc:ResponseCode -->
			<assert test="( ($currentDataType = 'CODE_COUNTRY') and (cac:ResponseValue/cbc:ResponseCode) ) or not($currentDataType = 'CODE_COUNTRY')" flag="fatal">The type of answer expected by the contracting authority is 'CODE_COUNTRY' ('cac:ResponseValue/cbc:ResponseCode' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- DATE = cac:ResponseValue/cbc:ResponseDate -->
			<assert test="( ($currentDataType = 'DATE') and (cac:ResponseValue/cbc:ResponseDate) ) or not($currentDataType = 'DATE')" flag="fatal">The type of answer expected by the contracting authority is 'DATE' ('cac:ResponseValue/cbc:ResponseDate' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- DESCRIPTION = cac:ResponseValue/cbc:Description -->
			<assert test="( ($currentDataType = 'DESCRIPTION') and (cac:ResponseValue/cbc:Description) ) or not($currentDataType = 'DESCRIPTION')" flag="fatal">The type of answer expected by the contracting authority is 'DESCRIPTION' ('cac:ResponseValue/cbc:Description' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- EVIDENCE_IDENTIFIER = cac:EvidenceSupplied/cbc:ID -->
			<assert test="( ($currentDataType = 'EVIDENCE_IDENTIFIER') and (cac:EvidenceSupplied/cbc:ID) ) or not($currentDataType = 'EVIDENCE_IDENTIFIER')" flag="fatal">The type of answer expected by the contracting authority is 'EVIDENCE_IDENTIFIER' ('cac:EvidenceSupplied/cbc:ID' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- INDICATOR = cac:ResponseValue/cbc:ResponseIndicator -->
			<assert test="( ($currentDataType = 'INDICATOR') and (cac:ResponseValue/cbc:ResponseIndicator) ) or not($currentDataType = 'INDICATOR')" flag="fatal">The type of answer expected by the contracting authority is 'INDICATOR' ('cac:ResponseValue/cbc:ResponseIndicator' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- PERCENTAGE = cac:ResponseValue/cbc:ResponseNumeric -->
			<assert test="( ($currentDataType = 'PERCENTAGE') and (cac:ResponseValue/cbc:ResponseNumeric) ) or not($currentDataType = 'PERCENTAGE')" flag="fatal">The type of answer expected by the contracting authority is 'PERCENTAGE' ('cac:ResponseValue/cbc:ResponseNumeric' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- PERIOD = cac:ApplicablePeriod -->
			<assert test="( ($currentDataType = 'PERIOD') and (cac:ApplicablePeriod) ) or not($currentDataType = 'PERIOD')" flag="fatal">The type of answer expected by the contracting authority is 'PERIOD' ('cac:ApplicablePeriod' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- QUANTITY_INTEGER = cac:ResponseValue/cbc:ResponseQuantity/@unitCode -->
			<assert test="( ($currentDataType = 'QUANTITY_INTEGER') and (cac:ResponseValue/cbc:ResponseQuantity/@unitCode) and (cac:ResponseValue/cbc:ResponseQuantity/@unitCode = 'QUANTITY_INTEGER' ) ) or not($currentDataType = 'QUANTITY_INTEGER')" flag="fatal">The type of answer expected by the contracting authority is 'QUANTITY_INTEGER' ('cac:ResponseValue/cbc:ResponseQuantity/@unitCode' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- QUANTITY_YEAR = cac:ResponseValue/cbc:ResponseQuantity/@unitCode -->
			<assert test="( ($currentDataType = 'QUANTITY_YEAR') and (cac:ResponseValue/cbc:ResponseQuantity/@unitCode) and (cac:ResponseValue/cbc:ResponseQuantity/@unitCode = 'QUANTITY_YEAR' ) ) or not($currentDataType = 'QUANTITY_YEAR')" flag="fatal">The type of answer expected by the contracting authority is 'QUANTITY_YEAR' ('cac:ResponseValue/cbc:ResponseQuantity/@unitCode' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- QUANTITY = cac:ResponseValue/cbc:ResponseQuantity/@unitCode -->
			<assert test="( ($currentDataType = 'QUANTITY') and (cac:ResponseValue/cbc:ResponseQuantity/@unitCode) and (cac:ResponseValue/cbc:ResponseQuantity/@unitCode = 'QUANTITY' ) ) or not($currentDataType = 'QUANTITY')" flag="fatal">The type of answer expected by the contracting authority is 'QUANTITY' ('cac:ResponseValue/cbc:ResponseQuantity/@unitCode' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- IDENTIFIER = cac:ResponseValue/cbc:ResponseID -->
			<assert test="( ($currentDataType = 'IDENTIFIER') and (cac:ResponseValue/cbc:ResponseID) ) or not($currentDataType = 'IDENTIFIER')" flag="fatal">The type of answer expected by the contracting authority is 'IDENTIFIER' ('ac:ResponseValue/cbc:ResponseID' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- URL = cac:ResponseValue/cbc:ResponseURI -->
			<assert test="( ($currentDataType = 'URL') and (cac:ResponseValue/cbc:ResponseURI) ) or not($currentDataType = 'URL')" flag="fatal">The type of answer expected by the contracting authority is 'URL' ('cac:ResponseValue/cbc:ResponseURI' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- MAXIMUM_AMOUNT = cac:ResponseValue/cbc:ResponseAmount -->
			<assert test="( ($currentDataType = 'MAXIMUM_AMOUNT') and (cac:ResponseValue/cbc:ResponseAmount) ) or not($currentDataType = 'MAXIMUM_AMOUNT')" flag="fatal">The type of answer expected by the contracting authority is 'MAXIMUM_AMOUNT' ('cac:ResponseValue/cbc:ResponseAmount' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- MINIMUM_AMOUNT = cac:ResponseValue/cbc:ResponseAmount -->
			<assert test="( ($currentDataType = 'MINIMUM_AMOUNT') and (cac:ResponseValue/cbc:ResponseAmount) ) or not($currentDataType = 'MINIMUM_AMOUNT')" flag="fatal">The type of answer expected by the contracting authority is 'MINIMUM_AMOUNT' ('cac:ResponseValue/cbc:ResponseAmount' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- MAXIMUM_VALUE_NUMERIC = cac:ResponseValue/cbc:ResponseNumeric -->
			<assert test="( ($currentDataType = 'MAXIMUM_VALUE_NUMERIC') and (cac:ResponseValue/cbc:ResponseNumeric) ) or not($currentDataType = 'MAXIMUM_VALUE_NUMERIC')" flag="fatal">The type of answer expected by the contracting authority is 'MAXIMUM_VALUE_NUMERIC' ('cac:ResponseValue/cbc:ResponseNumeric' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- TRANSLATION_TYPE_CODE = cac:ResponseValue/cbc:ResponseCode -->
			<assert test="( ($currentDataType = 'TRANSLATION_TYPE_CODE') and (cac:ResponseValue/cbc:ResponseCode) ) or not($currentDataType = 'TRANSLATION_TYPE_CODE')" flag="fatal">The type of answer expected by the contracting authority is 'TRANSLATION_TYPE_CODE' ('cac:ResponseValue/cbc:ResponseCode' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- CERTIFICATION_LEVEL_DESCRIPTION = cac:ResponseValue/cbc:Description -->
			<assert test="( ($currentDataType = 'CERTIFICATION_LEVEL_DESCRIPTION') and (cac:ResponseValue/cbc:Description) ) or not($currentDataType = 'CERTIFICATION_LEVEL_DESCRIPTION')" flag="fatal">The type of answer expected by the contracting authority is 'CERTIFICATION_LEVEL_DESCRIPTION' ('cac:ResponseValue/cbc:Description' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- COPY_QUALITY_TYPE_CODE = cac:ResponseValue/cbc:ResponseCode -->
			<assert test="( ($currentDataType = 'COPY_QUALITY_TYPE_CODE') and (cac:ResponseValue/cbc:ResponseCode) ) or not($currentDataType = 'COPY_QUALITY_TYPE_CODE')" flag="fatal">The type of answer expected by the contracting authority is 'COPY_QUALITY_TYPE_CODE' ('cac:ResponseValue/cbc:ResponseCode' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			<!-- TIME = cac:ResponseValue/cbc:ResponseTime -->
			<assert test="( ($currentDataType = 'TIME') and (cac:ResponseValue/cbc:ResponseTime) ) or not($currentDataType = 'TIME')" flag="fatal">The type of answer expected by the contracting authority is 'TIME' ('cac:ResponseValue/cbc:ResponseTime' element) - ('cbc:ID' is <value-of select="cbc:ID"/>).</assert>
			
		</rule>
		
	</pattern>
</schema>
