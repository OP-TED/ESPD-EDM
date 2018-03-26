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

    Illustration of cardinality constraints - 03 ESPD Common Other BR.sch
	ESPD Version: 2.0.0
-->
	
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="BR-COM-OTH">
		<!-- Information about publication CAN be provided. -->
		<rule context="cac:AdditionalDocumentReference">
			<!-- If the document referenced is a Contract Notice published on TED the ID must follow the scheme defined by the Publications Office: [][][][]/S [][][]-[][][][][][] (e.g. 2015/S 252-461137). If at the time of drafting the ESPD document the Publication Office has not published yet the Contract Notice the value 0000/S 000-000000 value must be used to indicate that a temporary identifier is being used. -->
			<assert test="(count(cbc:ID)=0) or not(cbc:DocumentTypeCode/text() = 'TED_CN') or ((count(cbc:ID))=1 and fn:matches(normalize-space(cbc:ID/text()), '^[0-9]{4}/S [0-9]{3}\-[0-9]{6}$'))" flag="fatal">If the document referenced is a Contract Notice published on TED the ID must follow the scheme defined by the Publications Office: [][][][]/S [][][]-[][][][][][] (cbc:ID = '<value-of select="cbc:ID"/>').</assert>
		
			<!-- If the document being referenced is a Notice being published on TED, use two description lines. Use the second description line to place therein the temporary number received from TED. -->
			<assert test="(cbc:DocumentTypeCode/text() = 'TED_CN' and (count(cac:Attachment/cac:ExternalReference/cbc:Description) = 2)) or not(cbc:DocumentTypeCode/text() = 'TED_CN')" flag="warning">If the document being referenced is a Notice being published on TED, use two description lines ('/cac:AdditionalDocumentReference/cac:Attachment/cac:ExternalReference/cbc:Description'). Use the second description line to place therein the temporary number received from TED (cbc:ID = '<value-of select="cbc:ID"/>').</assert>
			
			<!-- The type of document being referenced, expressed as a code is mandatory. -->
			<assert test="(cbc:DocumentTypeCode)" flag="fatal">The type of document being referenced, expressed as a code ('/cac:AdditionalDocumentReference/cbc:DocumentTypeCode') is mandatory (cbc:ID = '<value-of select="cbc:ID"/>').</assert>
		</rule>
		
		<!-- Identifies the earliest version of the UBL 2 schema. Use the value "2.2". Use also "OASIS-UBL-TC" for the schemeAgencyID attribute. -->
		<rule context="cbc:UBLVersionID">
			<assert test="text()='2.2'" flag="fatal">'cbc:UBLVersionID' must use the value "2.2" (cbc:UBLVersionID = '<value-of select="."/>').</assert>
			<assert test="@schemeAgencyID = 'OASIS-UBL-TC'" flag="fatal">'cbc:UBLVersionID/@schemeAgencyID' must use the value "OASIS-UBL-TC" (cbc:UBLVersionID/@schemeAgencyID = '<value-of select="@schemeAgencyID"/>').</assert>
		</rule>
		
		<!-- Identification of the specification. Use the value "41". Use also "CEN-BII" for the schemeAgencyID attribute. -->
		<rule context="cbc:ProfileID">
			<assert test="text()='4.1'" flag="fatal">'cbc:ProfileID' must use the value "4.1" (cbc:ProfileID = '<value-of select="."/>').</assert>
			<assert test="@schemeAgencyID = 'CEN-BII'" flag="fatal">'cbc:ProfileID/@schemeAgencyID' must use the value "CEN-BII" (cbc:ProfileID/@schemeAgencyID = '<value-of select="@schemeAgencyID"/>').</assert>
		</rule>
		
		<!-- For the Regulated ESDP Request only three basic data are required: the title, a short description and the file (i.e. case) reference number attributed by the Contracting Authority to the procurement procedure -->
		<rule context="cac:ProcurementProject">
			<assert test="(cbc:Name)" flag="fatal">The title of  the procurement procedure is mandatory.</assert>
			<assert test="(cbc:Description)" flag="warning">The short description of  the procurement procedure is mandatory.</assert>
		</rule>
		
		<!-- If @languageID is not specified, it defaults to EN (English) -->
		<!--rule context="cbc:LegislationTitle | cbc:Description | cbc:JurisdictionLevel | cbc:Article">
			<assert test="@languageID" flag="fatal">If @languageID is not specified, it defaults to EN (English).</assert>
		</rule-->
		
		<!-- For codes, this ESPD V02.00.00 specification requires always three mandatory attributes: listID, listAgencyID, and listVersionID. -->
		<rule context="cbc:ExpectedCode | cbc:IdentificationCode | cbc:CriterionTypeCode | cbc:ValueCurrencyCode | cbc:ProcedureCode | cbc:ProcurementTypeCode | cbc:ProcurementSubTypeCode">
			<assert test="@listID" flag="fatal">The attribute listID is mandatory for the element: '<value-of select="name()"/>').</assert>
			<assert test="@listAgencyID" flag="fatal">The attribute listAgencyID is mandatory for the element: '<value-of select="name()"/>').</assert>
			<assert test="@listVersionID" flag="fatal">The attribute listVersionID is mandatory for the element: '<value-of select="name()"/>').</assert>
		</rule>
		<!-- CODE LISTS NO IDENTIFIED -->
		<!--rule context="ext:ExtensionReasonCode | cbc:PartyTypeCode | cbc:ActivityTypeCode | cbc:LocaleCode | cbc:AddressTypeCode | cbc:AddressFormatCode | cbc:CountrySubentityCode | cbc:CoordinateSystemCode | cbc:LatitudeDirectionCode | cbc:LongitudeDirectionCode
		| cbc:LocationTypeCode | cbc:DescriptionCode | cbc:TaxLevelCode | cbc:ExemptionReasonCode | cbc:TaxTypeCode | cbc:CurrencyCode | cbc:CompanyLegalFormCode | cbc:CorporateRegistrationTypeCode | cbc:ChannelCode | cbc:GenderCode | cbc:RoleCode
		| cbc:AccountTypeCode | cbc:AccountFormatCode | cbc:DocumentStatusCode | cbc:MimeCode | cbc:FormatCode | cbc:EncodingCode | cbc:CharacterSetCode | cbc:ValidationResultCode | cbc:ServiceTypeCode | cbc:WebSiteTypeCode | cbc:SocialMediaTypeCode
		| cbc:TendererRoleCode | cbc:CapabilityTypeCode | cbc:DeclarationTypeCode | cbc:QualityControlCode | cbc:TaxExemptionReasonCode | cbc:NatureCode | cbc:CargoTypeCode | cbc:CommodityCode | cbc:ItemClassificationCode | cbc:AllowanceChargeReasonCode | cbc:AccountingCostCode 
		| cbc:PaymentMeansCode | cbc:PaymentChannelCode | cbc:MandateTypeCode | cbc:FinancingInstrumentCode | cbc:LineStatusCode | cbc:PositionCode | cbc:ActionCode | cbc:UNDGCode | cbc:EmergencyProceduresCode | cbc:MedicalFirstAidGuideCode | cbc:HazardousCategoryCode
		| cbc:TransportEmergencyCardCode | cbc:PackingCriteriaCode | cbc:HazardousRegulationCode | cbc:InhalationToxicityZoneCode | cbc:TransportAuthorizationCode | cbc:NameCode | cbc:ImportanceCode | cbc:CertificateTypeCode">
			<assert test="@listID and @listAgencyName and @listVersionID" flag="fatal">The attributes listID, listAgencyName and listVersionID are mandatory for the element: '<value-of select="name()"/>').</assert>
		</rule-->
		
		<!-- For identifiers, this ESPD V02.00.00 specification requires at least (and always) the mandatory attribute schemeAgencyID. -->
		<rule context="ext:ExtensionAgencyID | ext:ExtensionVersionID | cbc:AccountID| cbc:AdditionalAccountID|cbc:AgencyID| cbc:AircraftID| cbc:AttributeID| cbc:AwardID| cbc:AwardingCriterionID| cbc:BarcodeSymbologyID| cbc:BrokerAssignedID| cbc:BusinessClassificationEvidenceID| 
		cbc:BusinessIdentityEvidenceID| cbc:BuyerEventID| cbc:CV2ID| cbc:CarrierAssignedID| cbc:ChipApplicationID| cbc:CompanyID| cbc:ConsigneeAssignedID| cbc:ConsignorAssignedID| cbc:ConsumptionID| cbc:ConsumptionReportID| cbc:ContractFolderID| cbc:ContractedCarrierAssignedID|
		cbc:CustomerAssignedAccountID| cbc:CustomizationID| cbc:DocumentID| cbc:EndpointID| cbc:ExchangeMarketID| cbc:ExpectedID| cbc:ExtendedID| cbc:FormatID| cbc:FreightForwarderAssignedID| cbc:HazardClassID| cbc:ID| cbc:IdentificationID| cbc:ImmobilizationCertificateID|
		cbc:InstructionID| cbc:IssueNumberID| cbc:IssuerID| cbc:JourneyID| cbc:LanguageID| cbc:LicensePlateID| cbc:LineID| cbc:LoadingSequenceID| cbc:LocationID| cbc:LogoReferenceID| cbc:LotNumberID| cbc:LowerOrangeHazardPlacardID| cbc:MarkingID| cbc:MinimumImprovementBid|
		cbc:NationalityID| cbc:NetworkID| cbc:OID| cbc:OpenTenderID| cbc:OriginalContractingSystemID| cbc:OriginalJobID| cbc:ParentDocumentID| cbc:ParentDocumentLineReferenceID| cbc:ParentDocumentVersionID| cbc:ParticipantID| cbc:PaymentID| cbc:PaymentMeansID|
		cbc:PerformingCarrierAssignedID| cbc:PrepaidPaymentReferenceID| cbc:PreviousJobID| cbc:PreviousVersionID| cbc:PrimaryAccountNumberID| cbc:ProductTraceID| cbc:ProfileExecutionID| cbc:ProfileID| cbc:ProtocolID| cbc:RadioCallSignID| cbc:RailCarID| cbc:ReferenceID| 
		cbc:ReferencedConsignmentID| cbc:RegistrationID| cbc:RegistrationNationalityID| cbc:ReleaseID| cbc:RequestForQuotationLineID| cbc:RequiredCustomsID| cbc:ResponseID| cbc:RevisedForecastLineID| cbc:SalesOrderID| cbc:SalesOrderLineID| cbc:SecurityID| cbc:SellerEventID|
		cbc:SequenceID| cbc:SequenceNumberID| cbc:SerialID| cbc:ShippingOrderID| cbc:SignatureID| cbc:SpecificationID| cbc:SubscriberID| cbc:SuccessiveSequenceID| cbc:SupplierAssignedAccountID| cbc:TenderEnvelopeID| cbc:TraceID| cbc:TrackingID| cbc:TrainID| 
		cbc:TransportExecutionPlanReferenceID| cbc:UBLVersionID| cbc:UUID| cbc:UpperOrangeHazardPlacardID| cbc:ValidatedCriterionPropertyID| cbc:ValidatorID| cbc:VariantID| cbc:VersionID| cbc:VesselID| cbc:WeighingDeviceID">
			<assert test="@schemeAgencyID" flag="fatal">The attribute schemeAgencyID is mandatory for the element: '<value-of select="name()"/>').</assert>
		</rule>
		
		<!-- Code types listVersionID validation: starts with 2. -->
		<rule context="cbc:ConfidentialityLevelCode | cbc:TypeCode | cbc:DocumentTypeCode | cbc:IndustryClassificationCode | cbc:RoleCode | cbc:EvaluationMethodTypeCode | cbc:PropertyGroupTypeCode |
		cbc:QualificationApplicationTypeCode | cbc:ValueDataTypeCode">
			<assert test="@listID" flag="fatal">The attribute listID is mandatory for the element: '<value-of select="name()"/>').</assert>
			<assert test="@listAgencyID" flag="fatal">The attribute listAgencyID is mandatory for the element: '<value-of select="name()"/>').</assert>
			<assert test="@listVersionID" flag="fatal">The attribute listVersionID is mandatory for the element: '<value-of select="name()"/>').</assert>
			
			<assert test="starts-with(@listVersionID, '2.')" flag="fatal">Invalid value: '<value-of select="@listVersionID"/>' for the attribute 'listVersionID'.<value-of select="name()"/>').</assert>
		</rule>
	</pattern>
</schema>
