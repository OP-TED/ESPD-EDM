<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<title>Common Other Business Rules</title>
  
	<ns prefix="cac" uri="urn:X-test:UBL:Pre-award:CommonAggregate"/>
	<ns prefix="cbc" uri="urn:X-test:UBL:Pre-award:CommonBasic"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="udt" uri="urn:oasis:names:specification:ubl:schema:xsd:UnqualifiedDataTypes-2"/>
	<ns prefix="fn" uri="http://www.w3.org/2005/xpath-functions"/>
	
<!--
    Start of synthesis of rules from cardinality constraints ESPD Request and ESPD Response

    Illustration of cardinality constraints - 04 ESPD Common Other BR.sch
	ESPD Version: 2.0.2
-->
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-COM-OTH">
		<!-- BR-COM-10: Information about publication CAN be provided. -->
		<rule context="cac:AdditionalDocumentReference">
			<!-- BR-COM-10#1: If the document referenced is a Contract Notice published on TED the ID must follow the scheme defined by the Publications Office: [][][][]/S [][][]-[][][][][][] (e.g. 2015/S 252-461137). If at the time of drafting the ESPD document the Publication Office has not published yet the Contract Notice the value 0000/S 000-000000 value must be used to indicate that a temporary identifier is being used. -->
			<assert test="(count(cbc:ID)=0) or not(cbc:DocumentTypeCode/text() = 'TED_CN') or ((count(cbc:ID))=1 and fn:matches(normalize-space(cbc:ID/text()), '^[0-9]{4}/S [0-9]{3}\-[0-9]{6}$'))" flag="fatal" id="BR-COM-10-01">If the document referenced is a Contract Notice published on TED the ID must follow the scheme defined by the Publications Office: [][][][]/S [][][]-[][][][][][] (cbc:ID = '<value-of select="cbc:ID"/>').</assert>
		
			<!-- BR-COM-10#2: If the document being referenced is a Notice being published on TED, use two description lines. Use the second description line to place therein the temporary number received from TED. -->
			<assert test="(cbc:DocumentTypeCode/text() = 'TED_CN' and (count(cac:Attachment/cac:ExternalReference/cbc:Description) = 2)) or not(cbc:DocumentTypeCode/text() = 'TED_CN')" flag="warning" id="BR-COM-10-02">If the document being referenced is a Notice being published on TED, use two description lines ('/cac:AdditionalDocumentReference/cac:Attachment/cac:ExternalReference/cbc:Description'). Use the second description line to place therein the temporary number received from TED (cbc:ID = '<value-of select="cbc:ID"/>').</assert>
			
			<!-- BR-COM-10#3: The type of document being referenced, expressed as a code is mandatory. -->
			<assert test="(cbc:DocumentTypeCode)" flag="fatal"  id="BR-COM-10-03">The type of document being referenced, expressed as a code ('/cac:AdditionalDocumentReference/cbc:DocumentTypeCode') is mandatory (cbc:ID = '<value-of select="cbc:ID"/>').</assert>
		</rule>
		
		<!-- BR-OTH-05: Identifies the earliest version of the UBL 2 schema. Use the value "2.2". Use also "OASIS-UBL-TC" for the schemeAgencyID attribute. -->
		<rule context="cbc:UBLVersionID">
			<assert test="text()='2.2'" flag="fatal" id="BR-OTH-05-01">'cbc:UBLVersionID' must use the value "2.2" (cbc:UBLVersionID = '<value-of select="."/>').</assert>
			<assert test="@schemeAgencyID = 'OASIS-UBL-TC'" flag="fatal" id="BR-OTH-05-02">'cbc:UBLVersionID/@schemeAgencyID' must use the value "OASIS-UBL-TC" (cbc:UBLVersionID/@schemeAgencyID = '<value-of select="@schemeAgencyID"/>').</assert>
		</rule>
		
		<!-- BR-OTH-07: Identification of the specification. Use the value "4.1". Use also "CEN-BII" for the schemeAgencyID attribute. -->
		<rule context="cbc:ProfileID">
			<assert test="text()='4.1'" flag="fatal" id="BR-OTH-07-01">'cbc:ProfileID' must use the value "4.1" (cbc:ProfileID = '<value-of select="."/>').</assert>
			<assert test="@schemeAgencyID = 'CEN-BII'" flag="fatal" id="BR-OTH-07-02">'cbc:ProfileID/@schemeAgencyID' must use the value "CEN-BII" (cbc:ProfileID/@schemeAgencyID = '<value-of select="@schemeAgencyID"/>').</assert>
		</rule>
		
		<!-- BR-OTH-01: For codes, this ESPD V02.00.00 specification requires always three mandatory attributes: listID, listAgencyID, and listVersionID. -->
		<rule context="cbc:ExpectedCode | cbc:IdentificationCode | cbc:ValueCurrencyCode | cbc:ProcedureCode | cbc:ProcurementTypeCode | cbc:ProcurementSubTypeCode">
			<assert test="@listID" flag="fatal" id="BR-OTH-01-10">The attribute listID is mandatory for the element: '<value-of select="name()"/>').</assert>
			<assert test="@listAgencyID" flag="fatal" id="BR-OTH-01-20">The attribute listAgencyID is mandatory for the element: '<value-of select="name()"/>').</assert>
			<assert test="@listVersionID" flag="fatal"  id="BR-OTH-01-30">The attribute listVersionID is mandatory for the element: '<value-of select="name()"/>').</assert>
		</rule>
		
		<!-- BR-OTH-01: Code types listVersionID validation: starts with 2. -->
		<rule context="cbc:ConfidentialityLevelCode | cbc:TypeCode | cbc:DocumentTypeCode | cbc:IndustryClassificationCode | cbc:RoleCode | cbc:EvaluationMethodTypeCode | cbc:PropertyGroupTypeCode |
			cbc:QualificationApplicationTypeCode | cbc:ValueDataTypeCode | cbc:CriterionTypeCode | cbc:WeightingTypeCode">
			<assert test="@listID" flag="fatal" id="BR-OTH-01-11">The attribute listID is mandatory for the element: '<value-of select="name()"/>').</assert>
			<assert test="@listAgencyID" flag="fatal" id="BR-OTH-01-21">The attribute listAgencyID is mandatory for the element: '<value-of select="name()"/>').</assert>
			<assert test="@listVersionID" flag="fatal" id="BR-OTH-01-31">The attribute listVersionID is mandatory for the element: '<value-of select="name()"/>').</assert>
			
			<assert test="starts-with(@listVersionID, '2.') or starts-with(@listVersionID, '02.')" flag="fatal" id="BR-OTH-01-40">List version identifier '<value-of select="name()"/>/listVersionID = <value-of select="@listVersionID"/>' is not correct. ListVersionID should be '2.x.y' or '02.xx.yy'.</assert>
		</rule>
		
		<!-- BR-OTH-02: For identifiers, this ESPD V02.00.00 specification requires at least (and always) the mandatory attribute schemeAgencyID. -->
		<rule context="ext:ExtensionAgencyID | ext:ExtensionVersionID | cbc:AccountID| cbc:AdditionalAccountID|cbc:AgencyID| cbc:AircraftID| cbc:AttributeID| cbc:AwardID| cbc:AwardingCriterionID| cbc:BarcodeSymbologyID| cbc:BrokerAssignedID| cbc:BusinessClassificationEvidenceID| 
		cbc:BusinessIdentityEvidenceID| cbc:BuyerEventID| cbc:CV2ID| cbc:CarrierAssignedID| cbc:ChipApplicationID| cbc:CompanyID| cbc:ConsigneeAssignedID| cbc:ConsignorAssignedID| cbc:ConsumptionID| cbc:ConsumptionReportID| cbc:ContractFolderID| cbc:ContractedCarrierAssignedID|
		cbc:CustomerAssignedAccountID| cbc:CustomizationID| cbc:DocumentID| cbc:ExchangeMarketID| cbc:ExpectedID| cbc:ExtendedID| cbc:FormatID| cbc:FreightForwarderAssignedID| cbc:HazardClassID| cbc:ID| cbc:IdentificationID| cbc:ImmobilizationCertificateID|
		cbc:InstructionID| cbc:IssueNumberID| cbc:IssuerID| cbc:JourneyID| cbc:LanguageID| cbc:LicensePlateID| cbc:LineID| cbc:LoadingSequenceID| cbc:LocationID| cbc:LogoReferenceID| cbc:LotNumberID| cbc:LowerOrangeHazardPlacardID| cbc:MarkingID| cbc:MinimumImprovementBid|
		cbc:NationalityID| cbc:NetworkID| cbc:OID| cbc:OpenTenderID| cbc:OriginalContractingSystemID| cbc:OriginalJobID| cbc:ParentDocumentID| cbc:ParentDocumentLineReferenceID| cbc:ParentDocumentVersionID| cbc:ParticipantID| cbc:PaymentID| cbc:PaymentMeansID|
		cbc:PerformingCarrierAssignedID| cbc:PrepaidPaymentReferenceID| cbc:PreviousJobID| cbc:PreviousVersionID| cbc:PrimaryAccountNumberID| cbc:ProductTraceID| cbc:ProfileExecutionID| cbc:ProfileID| cbc:ProtocolID| cbc:RadioCallSignID| cbc:RailCarID| cbc:ReferenceID| 
		cbc:ReferencedConsignmentID| cbc:RegistrationID| cbc:RegistrationNationalityID| cbc:ReleaseID| cbc:RequestForQuotationLineID| cbc:RequiredCustomsID| cbc:ResponseID| cbc:RevisedForecastLineID| cbc:SalesOrderID| cbc:SalesOrderLineID| cbc:SecurityID| cbc:SellerEventID|
		cbc:SequenceID| cbc:SequenceNumberID| cbc:SerialID| cbc:ShippingOrderID| cbc:SignatureID| cbc:SpecificationID| cbc:SubscriberID| cbc:SuccessiveSequenceID| cbc:SupplierAssignedAccountID| cbc:TenderEnvelopeID| cbc:TraceID| cbc:TrackingID| cbc:TrainID| 
		cbc:TransportExecutionPlanReferenceID| cbc:UBLVersionID| cbc:UUID| cbc:UpperOrangeHazardPlacardID| cbc:ValidatedCriterionPropertyID| cbc:ValidatorID| cbc:VariantID| cbc:VersionID| cbc:VesselID| cbc:WeighingDeviceID">
			<assert test="(@schemeAgencyID) and normalize-space(@schemeAgencyID) != ''" flag="fatal"  id="BR-OTH-02">The attribute schemeAgencyID is mandatory for the element: '<value-of select="name()"/>', and it should not be empty.</assert>
		</rule>
		
		<rule context="cbc:EndpointID">
			<!-- BR-OTH-08: An end-point identifier MUST have a scheme identifier attribute (e.g.eSENSParty Identifier Scheme). -->
			<assert test="(@schemeID)" flag="error" id="BR-OTH-08">An end-point identifier MUST have a scheme identifier attribute ('/cac:ServiceProviderParty/cac:Party/cbc:EndpointID/@schemeID').</assert>
			<assert test="(@schemeAgencyID) and normalize-space(@schemeAgencyID) != ''" flag="fatal"  id="BR-OTH-02.">The attribute schemeAgencyID is mandatory for the element: '<value-of select="name()"/>', and it should not be empty.</assert>
		</rule>
	</pattern>
</schema>
