<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:cbc="urn:X-test:UBL:Pre-award:CommonBasic"
                xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:espd-req="urn:X-test:UBL:Pre-award:QualificationApplicationRequest"
                xmlns:espd-resp="urn:X-test:UBL:Pre-award:QualificationApplicationResponse"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:cac="urn:X-test:UBL:Pre-award:CommonAggregate"
                xmlns:udt="urn:oasis:names:specification:ubl:schema:xsd:UnqualifiedDataTypes-2"
                xmlns:espd="urn:X-test:UBL:Pre-award:QualificationApplicationRequest"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                version="2.0"><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->
<xsl:param name="archiveDirParameter"/>
   <xsl:param name="archiveNameParameter"/>
   <xsl:param name="fileNameParameter"/>
   <xsl:param name="fileDirParameter"/>
   <xsl:variable name="document-uri">
      <xsl:value-of select="document-uri(/)"/>
   </xsl:variable>

   <!--PHASES-->


<!--PROLOG-->
<xsl:output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" method="xml"
               omit-xml-declaration="no"
               standalone="yes"
               indent="yes"/>

   <!--XSD TYPES FOR XSLT2-->


<!--KEYS AND FUNCTIONS-->


<!--DEFAULT RULES-->


<!--MODE: SCHEMATRON-SELECT-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<xsl:template match="*" mode="schematron-select-full-path">
      <xsl:apply-templates select="." mode="schematron-get-full-path"/>
   </xsl:template>

   <!--MODE: SCHEMATRON-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<xsl:template match="*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">
            <xsl:value-of select="name()"/>
            <xsl:variable name="p_1" select="1+    count(preceding-sibling::*[name()=name(current())])"/>
            <xsl:if test="$p_1&gt;1 or following-sibling::*[name()=name(current())]">[<xsl:value-of select="$p_1"/>]</xsl:if>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>*[local-name()='</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>']</xsl:text>
            <xsl:variable name="p_2"
                          select="1+   count(preceding-sibling::*[local-name()=local-name(current())])"/>
            <xsl:if test="$p_2&gt;1 or following-sibling::*[local-name()=local-name(current())]">[<xsl:value-of select="$p_2"/>]</xsl:if>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="@*" mode="schematron-get-full-path">
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">@<xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>@*[local-name()='</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>' and namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!--MODE: SCHEMATRON-FULL-PATH-2-->
<!--This mode can be used to generate prefixed XPath for humans-->
<xsl:template match="node() | @*" mode="schematron-get-full-path-2">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="preceding-sibling::*[name(.)=name(current())]">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>
   <!--MODE: SCHEMATRON-FULL-PATH-3-->
<!--This mode can be used to generate prefixed XPath for humans 
	(Top-level element has index)-->
<xsl:template match="node() | @*" mode="schematron-get-full-path-3">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="parent::*">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>

   <!--MODE: GENERATE-ID-FROM-PATH -->
<xsl:template match="/" mode="generate-id-from-path"/>
   <xsl:template match="text()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/>
   </xsl:template>
   <xsl:template match="comment()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/>
   </xsl:template>
   <xsl:template match="processing-instruction()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.@', name())"/>
   </xsl:template>
   <xsl:template match="*" mode="generate-id-from-path" priority="-0.5">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/>
   </xsl:template>

   <!--MODE: GENERATE-ID-2 -->
<xsl:template match="/" mode="generate-id-2">U</xsl:template>
   <xsl:template match="*" mode="generate-id-2" priority="2">
      <xsl:text>U</xsl:text>
      <xsl:number level="multiple" count="*"/>
   </xsl:template>
   <xsl:template match="node()" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>n</xsl:text>
      <xsl:number count="node()"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="string-length(local-name(.))"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="translate(name(),':','.')"/>
   </xsl:template>
   <!--Strip characters--><xsl:template match="text()" priority="-1"/>

   <!--SCHEMA SETUP-->
<xsl:template match="/">
      <svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                              title="ESPD Request Self-contained Business Rules"
                              schemaVersion="">
         <xsl:comment>
            <xsl:value-of select="$archiveDirParameter"/>   
		 <xsl:value-of select="$archiveNameParameter"/>  
		 <xsl:value-of select="$fileNameParameter"/>  
		 <xsl:value-of select="$fileDirParameter"/>
         </xsl:comment>
         <svrl:ns-prefix-in-attribute-values uri="urn:X-test:UBL:Pre-award:CommonAggregate" prefix="cac"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:X-test:UBL:Pre-award:CommonBasic" prefix="cbc"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
                                             prefix="ext"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:UnqualifiedDataTypes-2"
                                             prefix="udt"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:X-test:UBL:Pre-award:QualificationApplicationRequest" prefix="espd"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.w3.org/2005/xpath-functions" prefix="fn"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">BR-REQ-SC</xsl:attribute>
            <xsl:attribute name="name">BR-REQ-SC</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M7"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ESPD Request Self-contained Business Rules</svrl:text>

   <!--PATTERN BR-REQ-SC-->


	<!--RULE -->
<xsl:template match="espd:QualificationApplicationRequest[cbc:QualificationApplicationTypeCode='SELFCONTAINED']"
                 priority="1002"
                 mode="M7">

		<!--ASSERT fatal-->
<xsl:choose>
         <xsl:when test="(cbc:ProcedureCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="(cbc:ProcedureCode)">
               <xsl:attribute name="id">BR-SC-10</xsl:attribute>
               <xsl:attribute name="role">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Information about the procurement procedure MUST be provided ('/cbc:ProcedureCode) when the type of ESPD is self-contained.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="count_procurementIDs"
                    select="count(cac:ProcurementProjectLot/cbc:ID/text())"/>
      <xsl:variable name="count_equal_procurementIDs"
                    select="count(distinct-values(cac:ProcurementProjectLot/cbc:ID/text()))"/>

		    <!--ASSERT fatal-->
<xsl:choose>
         <xsl:when test="($count_procurementIDs &lt;= 1) or ($count_equal_procurementIDs = $count_procurementIDs)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="($count_procurementIDs &lt;= 1) or ($count_equal_procurementIDs = $count_procurementIDs)">
               <xsl:attribute name="id">BR-LOT-30-S10</xsl:attribute>
               <xsl:attribute name="role">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Each '/cac:ProcurementProjectLot/cbc:ID' must be unique. Currently there are '<xsl:text/>
                  <xsl:value-of select="$count_procurementIDs - $count_equal_procurementIDs"/>
                  <xsl:text/>' which are not unique.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cac:TenderingCriterionPropertyGroup[cbc:ID='a53561d5-6614-4dbe-987e-b96f35387f46']/cac:TenderingCriterionProperty[cbc:TypeCode='REQUIREMENT' and cbc:ValueDataTypeCode='IDENTIFIER']"
                 priority="1001"
                 mode="M7">
      <xsl:variable name="allLots" select="/*[1]/cac:ProcurementProjectLot/cbc:ID"/>
      <xsl:variable name="testLots"
                    select="(cbc:ExpectedID) and (/*[1]/cbc:QualificationApplicationTypeCode = 'SELFCONTAINED') and count($allLots)&gt;0"/>
      <xsl:variable name="currentExpectedID" select="cbc:ExpectedID"/>
      <xsl:variable name="lotsIDs"
                    select="/*[1]/cac:ProcurementProjectLot[cbc:ID = $currentExpectedID]/cbc:ID"/>

		    <!--ASSERT fatal-->
<xsl:choose>
         <xsl:when test="not($testLots) or ($testLots and count($lotsIDs)=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not($testLots) or ($testLots and count($lotsIDs)=1)">
               <xsl:attribute name="id">BR-LOT-40</xsl:attribute>
               <xsl:attribute name="role">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The lots each criteria applies to MUST be provided. The lot identifier '/cbc:ExpectedID = <xsl:text/>
                  <xsl:value-of select="cbc:ExpectedID"/>
                  <xsl:text/>' does not exist.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cac:TenderingCriterion" priority="1000" mode="M7">
      <xsl:variable name="isSCopen"
                    select="(/*[1]/cbc:QualificationApplicationTypeCode = 'SELFCONTAINED') and (/*[1]/cbc:ProcedureCode != 'OPEN')"/>
      <xsl:variable name="testWeightNumeric"
                    select="$isSCopen and (cbc:EvaluationMethodTypeCode = 'WEIGHTED') and starts-with(cbc:CriterionTypeCode, 'CRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.')"/>

		    <!--ASSERT fatal-->
<xsl:choose>
         <xsl:when test="not($testWeightNumeric) or  ((cbc:WeightNumeric) and ($testWeightNumeric))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not($testWeightNumeric) or ((cbc:WeightNumeric) and ($testWeightNumeric))">
               <xsl:attribute name="id">BR-2P-10-S10_01</xsl:attribute>
               <xsl:attribute name="role">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>For two-phased procedure with weighted criteria, the information about weighting (cbc:WeightNumeric) for the criteria '<xsl:text/>
                  <xsl:value-of select="cbc:CriterionTypeCode"/>
                  <xsl:text/>' MUST be provided-</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="testTechnicalCriteria"
                    select="$isSCopen and not(starts-with(cbc:CriterionTypeCode, 'CRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.')) and (cbc:EvaluationMethodTypeCode)"/>

		    <!--ASSERT fatal-->
<xsl:choose>
         <xsl:when test="not($testTechnicalCriteria) or (($testTechnicalCriteria) and not(cbc:EvaluationMethodTypeCode = 'WEIGHTED'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not($testTechnicalCriteria) or (($testTechnicalCriteria) and not(cbc:EvaluationMethodTypeCode = 'WEIGHTED'))">
               <xsl:attribute name="id">BR-2P-10-S10_02</xsl:attribute>
               <xsl:attribute name="role">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>It is only possible to weight the "Technical and professional ability". The current criteria ('<xsl:text/>
                  <xsl:value-of select="cbc:CriterionTypeCode"/>
                  <xsl:text/>') should be always PASS/FAIL.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="testPassFail"
                    select="$isSCopen and (cbc:EvaluationMethodTypeCode != 'WEIGHTED') and not(starts-with(cbc:CriterionTypeCode, 'CRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.'))"/>

		    <!--ASSERT fatal-->
<xsl:choose>
         <xsl:when test="not($testPassFail) or (($testPassFail) and not(cbc:WeightNumeric))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not($testPassFail) or (($testPassFail) and not(cbc:WeightNumeric))">
               <xsl:attribute name="id">BR-2P-10-S20</xsl:attribute>
               <xsl:attribute name="role">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>If evaluation method is pass/fail, weighting is not required (see Tendering Criterion identifier '<xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>').</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M7"/>
   <xsl:template match="@*|node()" priority="-2" mode="M7">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>
</xsl:stylesheet>