<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<axsl:stylesheet xmlns:axsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sch="http://www.ascc.net/xml/schematron" xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" xmlns:ccv-cbc="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonBasicComponents-1" xmlns:cev-cbc="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonBasicComponents-1" xmlns:cev="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonAggregateComponents-1" xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2" xmlns:ccv="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonAggregateComponents-1" xmlns:espd-req="urn:grow:names:specification:ubl:schema:xsd:ESPDRequest-1" xmlns:espd-cbc="urn:grow:names:specification:ubl:schema:xsd:ESPD-CommonBasicComponents-1" version="2.0"><!--Importing stylesheet additions-->
   <axsl:output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" method="xml"/><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->

   <axsl:param name="archiveDirParameter"/>
   <axsl:param name="archiveNameParameter"/>
   <axsl:param name="fileNameParameter"/>
   <axsl:param name="fileDirParameter"/>

<!--PHASES-->


<!--PROLOG-->


<!--KEYS-->


<!--VARIABLES-->


<!--DEFAULT RULES-->


<!--MODE: SCHEMATRON-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->

   <axsl:template match="*" mode="schematron-get-full-path">
      <axsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <axsl:text>/</axsl:text>
      <axsl:choose>
         <axsl:when test="namespace-uri()=''">
            <axsl:value-of select="name()"/>
            <axsl:variable name="p" select="1+    count(preceding-sibling::*[name()=name(current())])"/>
            <axsl:if test="$p&gt;1 or following-sibling::*[name()=name(current())]">[<axsl:value-of select="$p"/>]</axsl:if>
         </axsl:when>
         <axsl:otherwise>
            <axsl:text>*[local-name()='</axsl:text>
            <axsl:value-of select="local-name()"/>
            <axsl:text>' and namespace-uri()='</axsl:text>
            <axsl:value-of select="namespace-uri()"/>
            <axsl:text>']</axsl:text>
            <axsl:variable name="p" select="1+   count(preceding-sibling::*[local-name()=local-name(current())])"/>
            <axsl:if test="$p&gt;1 or following-sibling::*[local-name()=local-name(current())]">[<axsl:value-of select="$p"/>]</axsl:if>
         </axsl:otherwise>
      </axsl:choose>
   </axsl:template>
   <axsl:template match="@*" mode="schematron-get-full-path">
      <axsl:text>/</axsl:text>
      <axsl:choose>
         <axsl:when test="namespace-uri()=''">@<axsl:value-of select="name()"/>
         </axsl:when>
         <axsl:otherwise>
            <axsl:text>@*[local-name()='</axsl:text>
            <axsl:value-of select="local-name()"/>
            <axsl:text>' and namespace-uri()='</axsl:text>
            <axsl:value-of select="namespace-uri()"/>
            <axsl:text>']</axsl:text>
         </axsl:otherwise>
      </axsl:choose>
   </axsl:template>

<!--MODE: SCHEMATRON-FULL-PATH-2-->
<!--This mode can be used to generate prefixed XPath for humans-->

   <axsl:template match="node() | @*" mode="schematron-get-full-path-2">
      <axsl:for-each select="ancestor-or-self::*">
         <axsl:text>/</axsl:text>
         <axsl:value-of select="name(.)"/>
         <axsl:if test="preceding-sibling::*[name(.)=name(current())]">
            <axsl:text>[</axsl:text>
            <axsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <axsl:text>]</axsl:text>
         </axsl:if>
      </axsl:for-each>
      <axsl:if test="not(self::*)">
         <axsl:text/>/@<axsl:value-of select="name(.)"/>
      </axsl:if>
   </axsl:template>

<!--MODE: GENERATE-ID-FROM-PATH -->

   <axsl:template match="/" mode="generate-id-from-path"/>
   <axsl:template match="text()" mode="generate-id-from-path">
      <axsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <axsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/>
   </axsl:template>
   <axsl:template match="comment()" mode="generate-id-from-path">
      <axsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <axsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/>
   </axsl:template>
   <axsl:template match="processing-instruction()" mode="generate-id-from-path">
      <axsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <axsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/>
   </axsl:template>
   <axsl:template match="@*" mode="generate-id-from-path">
      <axsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <axsl:value-of select="concat('.@', name())"/>
   </axsl:template>
   <axsl:template match="*" mode="generate-id-from-path" priority="-0.5">
      <axsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <axsl:text>.</axsl:text>
      <axsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/>
   </axsl:template><!--MODE: SCHEMATRON-FULL-PATH-3-->
<!--This mode can be used to generate prefixed XPath for humans 
	(Top-level element has index)-->

   <axsl:template match="node() | @*" mode="schematron-get-full-path-3">
      <axsl:for-each select="ancestor-or-self::*">
         <axsl:text>/</axsl:text>
         <axsl:value-of select="name(.)"/>
         <axsl:if test="parent::*">
            <axsl:text>[</axsl:text>
            <axsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <axsl:text>]</axsl:text>
         </axsl:if>
      </axsl:for-each>
      <axsl:if test="not(self::*)">
         <axsl:text/>/@<axsl:value-of select="name(.)"/>
      </axsl:if>
   </axsl:template>

<!--MODE: GENERATE-ID-2 -->

   <axsl:template match="/" mode="generate-id-2">U</axsl:template>
   <axsl:template match="*" mode="generate-id-2" priority="2">
      <axsl:text>U</axsl:text>
      <axsl:number level="multiple" count="*"/>
   </axsl:template>
   <axsl:template match="node()" mode="generate-id-2">
      <axsl:text>U.</axsl:text>
      <axsl:number level="multiple" count="*"/>
      <axsl:text>n</axsl:text>
      <axsl:number count="node()"/>
   </axsl:template>
   <axsl:template match="@*" mode="generate-id-2">
      <axsl:text>U.</axsl:text>
      <axsl:number level="multiple" count="*"/>
      <axsl:text>_</axsl:text>
      <axsl:value-of select="string-length(local-name(.))"/>
      <axsl:text>_</axsl:text>
      <axsl:value-of select="translate(name(),':','.')"/>
   </axsl:template><!--Strip characters-->
   <axsl:template match="text()" priority="-1"/>

<!--SCHEMA METADATA-->

   <axsl:template match="/">
      <svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" title="Code list elements - mandatory attributes" schemaVersion="">
         <axsl:comment>
            <axsl:value-of select="$archiveDirParameter"/>   
		 <axsl:value-of select="$archiveNameParameter"/>  
		 <axsl:value-of select="$fileNameParameter"/>  
		 <axsl:value-of select="$fileDirParameter"/>
         </axsl:comment>
         <axsl:apply-templates select="/" mode="M9"/>
      </svrl:schematron-output>
   </axsl:template>

<!--SCHEMATRON PATTERNS-->


<!--PATTERN cl-attrb-rules-->


	<!--RULE -->

   <axsl:template match="cbc:TypeCode | ccv-cbc:JurisdictionLevelCode | cbc:ActivityTypeCode | cbc:LocaleCode | cbc:ContractTypeCode | cbc:CurrencyCode | cbc:ProcurementTypeCode | cbc:RoleCode" priority="1003" mode="M9">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="@listID and @listAgencyID and @listVersionID"/>
         <axsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@listID and @listAgencyID and @listVersionID">
               <axsl:attribute name="location">
                  <axsl:apply-templates select="." mode="schematron-get-full-path"/>
               </axsl:attribute>
               <svrl:text>One or more of the mandatory attributes (listID, listAgengyID, listVersionID) are not provided </svrl:text>
            </svrl:failed-assert>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="ext:ExtensionReasonCode" priority="1002" mode="M9">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="@listID and @listAgencyID and @listVersionID"/>
         <axsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@listID and @listAgencyID and @listVersionID">
               <axsl:attribute name="location">
                  <axsl:apply-templates select="." mode="schematron-get-full-path"/>
               </axsl:attribute>
               <svrl:text>One or more of the mandatory attributes (listID, listAgengyID, listVersionID) are not provided </svrl:text>
            </svrl:failed-assert>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:PartyTypeCode | cbc:AddressTypeCode | cbc:AddressFormatCode | cbc:CountrySubentityCode" priority="1001" mode="M9">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="@listID and @listAgencyID and @listVersionID"/>
         <axsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@listID and @listAgencyID and @listVersionID">
               <axsl:attribute name="location">
                  <axsl:apply-templates select="." mode="schematron-get-full-path"/>
               </axsl:attribute>
               <svrl:text>One or more of the mandatory attributes (listID, listAgengyID, listVersionID) are not provided </svrl:text>
            </svrl:failed-assert>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:IdentificationCode | cbc:CoordinateSystemCode | cbc:LatitudeDirectionCode | cbc:LongitudeDirectionCode | cbc:LocationTypeCode | cbc:DescriptionCode | cbc:TaxLevelCode | cbc:ExemptionReasonCode | cbc:TaxTypeCode | cbc:CompanyLegalFormCode | cbc:CompanyLiquidationStatusCode | cbc:CorporateRegistrationTypeCode | cbc:ChannelCode | cbc:GenderCode | cbc:AccountTypeCode | cbc:AccountFormatCode | cbc:DocumentTypeCode | cbc:LocaleCode | cbc:DocumentStatusCode | cbc:MimeCode | cbc:FormatCode | cbc:EncodingCode | cbc:CharacterSetCode | cbc:ValidationResultCode | cbc:ServiceTypeCode | cbc:AwardingMethodTypeCode | cbc:PriceEvaluationCode | cbc:FundingProgramCode | cbc:PaymentFrequencyCode | cbc:GuaranteeTypeCode | cbc:ReferenceEventCode | cbc:SourceCurrencyCode | cbc:TargetCurrencyCode | cbc:MathematicOperatorCode | cbc:LossRiskResponsibilityCode | cbc:AllowanceChargeReasonCode | cbc:AccountingCostCode | cbc:AccountingCost | cbc:TaxExemptionReasonCode | cbc:ShippingPriorityLevelCode | cbc:HandlingCode | cbc:TariffCode | cbc:TransportEventTypeCode | cbc:ConditionCode | cbc:StatusReasonCode | cbc:TransportServiceCode | cbc:TariffClassCode | cbc:FreightRateClassCode | cbc:TransportEquipmentTypeCode | cbc:ProviderTypeCode | cbc:OwnerTypeCode | cbc:SizeTypeCode | cbc:DispositionCode | cbc:FullnessIndicationCode | cbc:TrackingDeviceCode | cbc:SealStatusCode | cbc:SealIssuerTypeCode | cbc:DirectionCode | cbc:TransportMeansTypeCode | cbc:TradeServiceCode | cbc:TransportEmergencyCardCode | cbc:PackingCriteriaCode | cbc:HazardousRegulationCode | cbc:InhalationToxicityZoneCode | cbc:TransportAuthorizationCode | cbc:TransportHandlingUnitTypeCode | cbc:HandlingCode | cbc:LineStatusCode | cbc:PositionCode | cbc:NatureCode | cbc:CargoTypeCode | cbc:CommodityCode | cbc:ItemClassificationCode | cbc:ActionCode | cbc:UNDGCode | cbc:EmergencyProceduresCode | cbc:MedicalFirstAidGuideCode | cbc:HazardousCategoryCode | cbc:EmergencyProceduresCode | cbc:NameCode | cbc:ImportanceCode | cbc:ImportanceCode | cbc:CertificateTypeCode | cbc:PackageLevelCode | cbc:PackagingTypeCode | cbc:PreferenceCriterionCode | cbc:CustomsStatusCode | cbc:AccountingCostCode | cbc:PaymentPurposeCode | cbc:OrderTypeCode | cbc:PriceTypeCode | cbc:StatusCode | cbc:ShortageActionCode | cbc:RejectReasonCode | cbc:RejectActionCode | cbc:QuantityDiscrepancyCode | cbc:TimingComplaintCode | cbc:TransportModeCode |cbc:TransportMeansTypeCode |cbc:TransitDirectionCode | cbc:EnvironmentalEmissionTypeCode | cbc:CalculationMethodCode | cbc:FullnessIndicationCode | cbc:WeekDayCode | cbc:CompanyLegalFormCode | cbc:EvaluationCriterionTypeCode | cbc:ExpressionCode | cbc:EvidenceTypeCode | cbc:TendererRequirementTypeCode | cbc:SubcontractingConditionsCode | cbc:TenderEnvelopeTypeCode | cbc:ExecutionRequirementCode | cbc:WeightingAlgorithmCode | cbc:AwardingCriterionTypeCode | cbc:CalculationExpressionCode | cbc:ProcurementSubTypeCode | cbc:QualityControlCode" priority="1000" mode="M9">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="@listID and @listAgencyID and @listVersionID"/>
         <axsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@listID and @listAgencyID and @listVersionID">
               <axsl:attribute name="location">
                  <axsl:apply-templates select="." mode="schematron-get-full-path"/>
               </axsl:attribute>
               <svrl:text>One or more of the mandatory attributes (listID, listAgengyID, listVersionID) are not provided </svrl:text>
            </svrl:failed-assert>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </axsl:template>
   <axsl:template match="text()" priority="-1" mode="M9"/>
   <axsl:template match="@*|node()" priority="-2" mode="M9">
      <axsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </axsl:template>
</axsl:stylesheet>