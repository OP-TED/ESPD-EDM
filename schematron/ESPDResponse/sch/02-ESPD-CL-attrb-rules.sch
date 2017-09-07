<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron">
	<title>Code list elements - mandatory attributes</title>
  
	<ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
	<ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
	<ns prefix="ccv-cbc" uri="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonBasicComponents-1"/>
	<ns prefix="cev-cbc" uri="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonBasicComponents-1"/>
	<ns prefix="cev" uri="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonAggregateComponents-1"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="ccv" uri="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonAggregateComponents-1"/>
	<ns prefix="espd-cbc" uri="urn:grow:names:specification:ubl:schema:xsd:ESPD-CommonBasicComponents-1"/>
	<ns prefix="espd" uri="urn:grow:names:specification:ubl:schema:xsd:ESPDResponse-1"/>

	<pattern id="cl-attrb-rules">

<!--
    Start of synthesis of rules from code list attributes assertions.

    Illustration of codelists attributes constraints - ESPD-CL-attrb-rules.sch
-->

	<!-- ESPDResponse elements: elements which values are checked in 'ESPD-codelist-values.cva' -->
	<rule context="cbc:TypeCode | ccv-cbc:JurisdictionLevelCode | cbc:ActivityTypeCode | cbc:LocaleCode | espd-cbc:EconomicOperatorRoleCode">
		<!-- The attributes listID, listAgencyID, listVersionID must be provided and filled in. -->
		<assert test="@listID and @listAgencyID and @listVersionID">One or more of the mandatory attributes (listID, listAgengyID, listVersionID) are not provided </assert>
	</rule>
	
	<!-- ESPDResponse / EconomicOperator -->
	<rule context="espd-cbc:NaturalPersonRoleCode | espd-cbc:NaturalPersonRegistrationCountryCode">
		<!-- The attributes listID, listAgencyID, listVersionID must be provided and filled in. -->
		<assert test="@listID and @listAgencyID and @listVersionID">One or more of the mandatory attributes (listID, listAgengyID, listVersionID) are not provided </assert>
	</rule>
	
	<!-- ESPDResponse elements: CommonExtensionComponents-2 -->
	<rule context="ext:ExtensionReasonCode">
		<!-- The attributes listID, listAgencyID, listVersionID must be provided and filled in. -->
		<assert test="@listID and @listAgencyID and @listVersionID">One or more of the mandatory attributes (listID, listAgengyID, listVersionID) are not provided </assert>
	</rule>
	
	<!-- ESPDResponse elements: Other -->
	<rule context="cbc:PartyTypeCode | cbc:AddressTypeCode | cbc:AddressFormatCode | cbc:CountrySubentityCode">
		<!-- The attributes listID, listAgencyID, listVersionID must be provided and filled in. -->
		<assert test="@listID and @listAgencyID and @listVersionID">One or more of the mandatory attributes (listID, listAgengyID, listVersionID) are not provided </assert>
	</rule>
	
	<!-- ESPDResponse elements: CommonBasicComponents-2 PENDING TO TAKE A DECISION -->
	<rule context="cbc:IdentificationCode | cbc:CoordinateSystemCode | cbc:LatitudeDirectionCode | cbc:LongitudeDirectionCode | cbc:LocationTypeCode | cbc:DescriptionCode | cbc:TaxLevelCode | cbc:ExemptionReasonCode | cbc:TaxTypeCode | cbc:CurrencyCode | cbc:CompanyLegalFormCode | cbc:CompanyLiquidationStatusCode | cbc:CorporateRegistrationTypeCode | cbc:ChannelCode | cbc:GenderCode | cbc:AccountTypeCode | cbc:AccountFormatCode | cbc:DocumentTypeCode | cbc:LocaleCode | cbc:DocumentStatusCode | cbc:MimeCode | cbc:FormatCode | cbc:EncodingCode | cbc:CharacterSetCode | cbc:ValidationResultCode | cbc:ServiceTypeCode | cbc:AwardingMethodTypeCode | cbc:PriceEvaluationCode | cbc:FundingProgramCode | cbc:PaymentFrequencyCode | cbc:GuaranteeTypeCode | cbc:ReferenceEventCode | cbc:SourceCurrencyCode | cbc:TargetCurrencyCode | cbc:MathematicOperatorCode | cbc:ContractTypeCode | cbc:LossRiskResponsibilityCode | cbc:AllowanceChargeReasonCode | cbc:AccountingCostCode | cbc:AccountingCost | cbc:TaxExemptionReasonCode | cbc:ShippingPriorityLevelCode | cbc:HandlingCode | cbc:TariffCode | cbc:TransportEventTypeCode | cbc:ConditionCode | cbc:StatusReasonCode | cbc:TransportServiceCode | cbc:TariffClassCode | cbc:FreightRateClassCode | cbc:TransportEquipmentTypeCode | cbc:ProviderTypeCode | cbc:OwnerTypeCode | cbc:SizeTypeCode | cbc:DispositionCode | cbc:FullnessIndicationCode | cbc:TrackingDeviceCode | cbc:SealStatusCode | cbc:SealIssuerTypeCode | cbc:DirectionCode | cbc:TransportMeansTypeCode | cbc:TradeServiceCode | cbc:TransportEmergencyCardCode | cbc:PackingCriteriaCode | cbc:HazardousRegulationCode | cbc:InhalationToxicityZoneCode | cbc:TransportAuthorizationCode | cbc:TransportHandlingUnitTypeCode | cbc:HandlingCode | cbc:LineStatusCode | cbc:PositionCode | cbc:NatureCode | cbc:CargoTypeCode | cbc:CommodityCode | cbc:ItemClassificationCode | cbc:ActionCode | cbc:UNDGCode | cbc:EmergencyProceduresCode | cbc:MedicalFirstAidGuideCode | cbc:HazardousCategoryCode | cbc:EmergencyProceduresCode | cbc:NameCode | cbc:ImportanceCode | cbc:ImportanceCode | cbc:CertificateTypeCode | cbc:PackageLevelCode | cbc:PackagingTypeCode | cbc:PreferenceCriterionCode | cbc:CustomsStatusCode | cbc:AccountingCostCode | cbc:PaymentPurposeCode | cbc:OrderTypeCode | cbc:PriceTypeCode | cbc:StatusCode | cbc:ShortageActionCode | cbc:RejectReasonCode | cbc:RejectActionCode | cbc:QuantityDiscrepancyCode | cbc:TimingComplaintCode | cbc:TransportModeCode |cbc:TransportMeansTypeCode |cbc:TransitDirectionCode | cbc:EnvironmentalEmissionTypeCode | cbc:CalculationMethodCode | cbc:FullnessIndicationCode | cbc:WeekDayCode | cbc:CompanyLegalFormCode | cbc:EvaluationCriterionTypeCode | cbc:ExpressionCode | cbc:EvidenceTypeCode | cbc:TendererRequirementTypeCode | cbc:RoleCode | cbc:SubcontractingConditionsCode | cbc:TenderEnvelopeTypeCode | cbc:ExecutionRequirementCode | cbc:WeightingAlgorithmCode | cbc:AwardingCriterionTypeCode | cbc:CalculationExpressionCode | cbc:ProcurementTypeCode | cbc:ProcurementSubTypeCode | cbc:QualityControlCode">
		<!-- The attributes listID, listAgencyID, listVersionID must be provided and filled in. -->
		<assert test="@listID and @listAgencyID and @listVersionID">One or more of the mandatory attributes (listID, listAgengyID, listVersionID) are not provided </assert>
	</rule>
</pattern>
</schema>