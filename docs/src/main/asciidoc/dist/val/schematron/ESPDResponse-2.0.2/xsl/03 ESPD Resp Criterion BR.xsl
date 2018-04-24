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
                xmlns:espd="urn:X-test:UBL:Pre-award:QualificationApplicationResponse"
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
<xsl:key name="CriterionProperty" match="cac:TenderingCriterionProperty" use="cbc:ID"/>
   <xsl:key name="EvidenceID" match="cac:Evidence" use="cbc:ID"/>
   <xsl:key name="CriterionResponseType" match="cac:TenderingCriterionResponse"
            use="cbc:ValidatedCriterionPropertyID"/>
   <xsl:key name="TenderingCriteria" match="cac:TenderingCriterion"
            use="cbc:CriterionTypeCode"/>
   <xsl:key name="EORoleTest" match="cbc:RoleCode" use="."/>

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
                              title="ESPD Response Criterion Business Rules"
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
         <svrl:ns-prefix-in-attribute-values uri="urn:X-test:UBL:Pre-award:QualificationApplicationResponse" prefix="espd"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.w3.org/2005/xpath-functions" prefix="fn"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">BR-RESP-CRI</xsl:attribute>
            <xsl:attribute name="name">BR-RESP-CRI</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M11"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ESPD Response Criterion Business Rules</svrl:text>

   <!--PATTERN BR-RESP-CRI-->


	<!--RULE -->
<xsl:template match="cac:TenderingCriterionProperty/cbc:ID" priority="1004" mode="M11">
      <xsl:variable name="responseIDs" select="key('CriterionResponseType', .)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count($responseIDs) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count($responseIDs) &lt;= 1">
               <xsl:attribute name="id">BR-TCR-01-03</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The criterion property ('cac:TenderingCriterionProperty/cbc:ID' = '<xsl:text/>
                  <xsl:value-of select="."/>
                  <xsl:text/>') has '<xsl:text/>
                  <xsl:value-of select="count($responseIDs)"/>
                  <xsl:text/>' responses.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cac:TenderingCriterionResponse" priority="1003" mode="M11">
      <xsl:variable name="currentDataType"
                    select="key('CriterionProperty', cbc:ValidatedCriterionPropertyID)/cbc:ValueDataTypeCode/text()"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cbc:ValidatedCriterionPropertyID)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(cbc:ValidatedCriterionPropertyID)">
               <xsl:attribute name="id">BR-TCR-01-01</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>A cross-reference ('/cbc:ValidatedCriterionPropertyID') to the criterion property is mandatory.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(cac:ResponseValue) + count(cac:ApplicablePeriod) + count(cac:EvidenceSupplied))=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(cac:ResponseValue) + count(cac:ApplicablePeriod) + count(cac:EvidenceSupplied))=1">
               <xsl:attribute name="id">BR-TCR-03</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>One and only one response element ('/cac:ResponseValue', '/cac:ApplicablePeriod' or '/cac:EvidenceSupplied') per criterion response ('/cac:TenderingCriterionResponse/cbc:ValidatedCriterionPropertyID = <xsl:text/>
                  <xsl:value-of select="cbc:ValidatedCriterionPropertyID"/>
                  <xsl:text/>') is mandatory.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="((cbc:ValidatedCriterionPropertyID) and (count(key('CriterionProperty', cbc:ValidatedCriterionPropertyID))=1)) or not(cbc:ValidatedCriterionPropertyID)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="((cbc:ValidatedCriterionPropertyID) and (count(key('CriterionProperty', cbc:ValidatedCriterionPropertyID))=1)) or not(cbc:ValidatedCriterionPropertyID)">
               <xsl:attribute name="id">BR-TCR-01-02</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The criterion response ('cbc:ValidatedCriterionPropertyID' = '<xsl:text/>
                  <xsl:value-of select="cbc:ValidatedCriterionPropertyID"/>
                  <xsl:text/>') does not have a cross-reference to a criterion property ('cac:TenderingCriterionProperty/cbc:ID').</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="((cac:EvidenceSupplied) and (count(key('EvidenceID', cac:EvidenceSupplied/cbc:ID)) = 1)) or not(cac:EvidenceSupplied)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="((cac:EvidenceSupplied) and (count(key('EvidenceID', cac:EvidenceSupplied/cbc:ID)) = 1)) or not(cac:EvidenceSupplied)">
               <xsl:attribute name="id">BR-TCR-09</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The evidence response ('cac:EvidenceSupplied/cbc:ID' = '<xsl:text/>
                  <xsl:value-of select="cac:EvidenceSupplied/cbc:ID"/>
                  <xsl:text/>') does not have a corss-reference to the evidence identifier ('cac:Evidence/cbc:ID').</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( ($currentDataType = 'AMOUNT') and (cac:ResponseValue/cbc:ResponseAmount) ) or not($currentDataType = 'AMOUNT')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( ($currentDataType = 'AMOUNT') and (cac:ResponseValue/cbc:ResponseAmount) ) or not($currentDataType = 'AMOUNT')">
               <xsl:attribute name="id">BR-TCR-08-01</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of answer expected by the contracting authority is 'AMOUNT' ('cac:ResponseValue/cbc:ResponseAmount' element) - ('cbc:ID' is <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( ($currentDataType = 'CODE') and (cac:ResponseValue/cbc:ResponseCode) ) or not($currentDataType = 'CODE')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( ($currentDataType = 'CODE') and (cac:ResponseValue/cbc:ResponseCode) ) or not($currentDataType = 'CODE')">
               <xsl:attribute name="id">BR-TCR-08-02</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of answer expected by the contracting authority is 'CODE' ('cac:ResponseValue/cbc:ResponseCode' element) - ('cbc:ID' is <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( ($currentDataType = 'CODE_COUNTRY') and (cac:ResponseValue/cbc:ResponseCode) ) or not($currentDataType = 'CODE_COUNTRY')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( ($currentDataType = 'CODE_COUNTRY') and (cac:ResponseValue/cbc:ResponseCode) ) or not($currentDataType = 'CODE_COUNTRY')">
               <xsl:attribute name="id">BR-TCR-08-03</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of answer expected by the contracting authority is 'CODE_COUNTRY' ('cac:ResponseValue/cbc:ResponseCode' element) - ('cbc:ID' is <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( ($currentDataType = 'DATE') and (cac:ResponseValue/cbc:ResponseDate) ) or not($currentDataType = 'DATE')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( ($currentDataType = 'DATE') and (cac:ResponseValue/cbc:ResponseDate) ) or not($currentDataType = 'DATE')">
               <xsl:attribute name="id">BR-TCR-08-04</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of answer expected by the contracting authority is 'DATE' ('cac:ResponseValue/cbc:ResponseDate' element) - ('cbc:ID' is <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( ($currentDataType = 'DESCRIPTION') and (cac:ResponseValue/cbc:Description) ) or not($currentDataType = 'DESCRIPTION')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( ($currentDataType = 'DESCRIPTION') and (cac:ResponseValue/cbc:Description) ) or not($currentDataType = 'DESCRIPTION')">
               <xsl:attribute name="id">BR-TCR-08-05</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of answer expected by the contracting authority is 'DESCRIPTION' ('cac:ResponseValue/cbc:Description' element) - ('cbc:ID' is <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( ($currentDataType = 'EVIDENCE_IDENTIFIER') and (cac:EvidenceSupplied/cbc:ID) ) or not($currentDataType = 'EVIDENCE_IDENTIFIER')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( ($currentDataType = 'EVIDENCE_IDENTIFIER') and (cac:EvidenceSupplied/cbc:ID) ) or not($currentDataType = 'EVIDENCE_IDENTIFIER')">
               <xsl:attribute name="id">BR-TCR-08-06</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of answer expected by the contracting authority is 'EVIDENCE_IDENTIFIER' ('cac:EvidenceSupplied/cbc:ID' element) - ('cbc:ID' is <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( ($currentDataType = 'INDICATOR') and (cac:ResponseValue/cbc:ResponseIndicator) ) or not($currentDataType = 'INDICATOR')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( ($currentDataType = 'INDICATOR') and (cac:ResponseValue/cbc:ResponseIndicator) ) or not($currentDataType = 'INDICATOR')">
               <xsl:attribute name="id">BR-TCR-08-07</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of answer expected by the contracting authority is 'INDICATOR' ('cac:ResponseValue/cbc:ResponseIndicator' element) - ('cbc:ID' is <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( ($currentDataType = 'PERCENTAGE') and (cac:ResponseValue/cbc:ResponseMeasure/@unitCode = 'PERCENTAGE') ) or not($currentDataType = 'PERCENTAGE')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( ($currentDataType = 'PERCENTAGE') and (cac:ResponseValue/cbc:ResponseMeasure/@unitCode = 'PERCENTAGE') ) or not($currentDataType = 'PERCENTAGE')">
               <xsl:attribute name="id">BR-TCR-08-08</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of answer expected by the contracting authority is 'PERCENTAGE' ('cac:ResponseValue/cbc:ResponseMeasure' element) - ('cbc:ID' is <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( ($currentDataType = 'PERIOD') and (cac:ApplicablePeriod) ) or not($currentDataType = 'PERIOD')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( ($currentDataType = 'PERIOD') and (cac:ApplicablePeriod) ) or not($currentDataType = 'PERIOD')">
               <xsl:attribute name="id">BR-TCR-08-09</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of answer expected by the contracting authority is 'PERIOD' ('cac:ApplicablePeriod' element) - ('cbc:ID' is <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( ($currentDataType = 'QUANTITY_INTEGER') and (cac:ResponseValue/cbc:ResponseMeasure) ) or not($currentDataType = 'QUANTITY_INTEGER')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( ($currentDataType = 'QUANTITY_INTEGER') and (cac:ResponseValue/cbc:ResponseMeasure) ) or not($currentDataType = 'QUANTITY_INTEGER')">
               <xsl:attribute name="id">BR-TCR-08-10</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of answer expected by the contracting authority is 'QUANTITY_INTEGER' ('cac:ResponseValue/cbc:ResponseMeasure' element) - ('cbc:ID' is <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( ($currentDataType = 'QUANTITY_YEAR') and (cac:ResponseValue/cbc:ResponseMeasure/@unitCode='YEAR') ) or not($currentDataType = 'QUANTITY_YEAR')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( ($currentDataType = 'QUANTITY_YEAR') and (cac:ResponseValue/cbc:ResponseMeasure/@unitCode='YEAR') ) or not($currentDataType = 'QUANTITY_YEAR')">
               <xsl:attribute name="id">BR-TCR-08-11</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of answer expected by the contracting authority is 'QUANTITY_YEAR' ('cac:ResponseValue/cbc:ResponseMeasure' element) - ('cbc:ID' is <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( ($currentDataType = 'QUANTITY') and (cac:ResponseValue/cbc:ResponseQuantity) ) or not($currentDataType = 'QUANTITY')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( ($currentDataType = 'QUANTITY') and (cac:ResponseValue/cbc:ResponseQuantity) ) or not($currentDataType = 'QUANTITY')">
               <xsl:attribute name="id">BR-TCR-08-12</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of answer expected by the contracting authority is 'QUANTITY' ('cac:ResponseValue/cbc:ResponseQuantity' element) - ('cbc:ID' is <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( ($currentDataType = 'IDENTIFIER') and (cac:ResponseValue/cbc:ResponseID) ) or not($currentDataType = 'IDENTIFIER')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( ($currentDataType = 'IDENTIFIER') and (cac:ResponseValue/cbc:ResponseID) ) or not($currentDataType = 'IDENTIFIER')">
               <xsl:attribute name="id">BR-TCR-08-13</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of answer expected by the contracting authority is 'IDENTIFIER' ('ac:ResponseValue/cbc:ResponseID' element) - ('cbc:ID' is <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( ($currentDataType = 'URL') and (cac:ResponseValue/cbc:ResponseURI) ) or not($currentDataType = 'URL')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( ($currentDataType = 'URL') and (cac:ResponseValue/cbc:ResponseURI) ) or not($currentDataType = 'URL')">
               <xsl:attribute name="id">BR-TCR-08-14</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of answer expected by the contracting authority is 'URL' ('cac:ResponseValue/cbc:ResponseURI' element) - ('cbc:ID' is <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( ($currentDataType = 'MAXIMUM_AMOUNT') and (cac:ResponseValue/cbc:ResponseAmount) ) or not($currentDataType = 'MAXIMUM_AMOUNT')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( ($currentDataType = 'MAXIMUM_AMOUNT') and (cac:ResponseValue/cbc:ResponseAmount) ) or not($currentDataType = 'MAXIMUM_AMOUNT')">
               <xsl:attribute name="id">BR-TCR-08-15</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of answer expected by the contracting authority is 'MAXIMUM_AMOUNT' ('cac:ResponseValue/cbc:ResponseAmount' element) - ('cbc:ID' is <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( ($currentDataType = 'MINIMUM_AMOUNT') and (cac:ResponseValue/cbc:ResponseAmount) ) or not($currentDataType = 'MINIMUM_AMOUNT')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( ($currentDataType = 'MINIMUM_AMOUNT') and (cac:ResponseValue/cbc:ResponseAmount) ) or not($currentDataType = 'MINIMUM_AMOUNT')">
               <xsl:attribute name="id">BR-TCR-08-16</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of answer expected by the contracting authority is 'MINIMUM_AMOUNT' ('cac:ResponseValue/cbc:ResponseAmount' element) - ('cbc:ID' is <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( ($currentDataType = 'MAXIMUM_VALUE_NUMERIC') and (cac:ResponseValue/cbc:ResponseNumeric) ) or not($currentDataType = 'MAXIMUM_VALUE_NUMERIC')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( ($currentDataType = 'MAXIMUM_VALUE_NUMERIC') and (cac:ResponseValue/cbc:ResponseNumeric) ) or not($currentDataType = 'MAXIMUM_VALUE_NUMERIC')">
               <xsl:attribute name="id">BR-TCR-08-17</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of answer expected by the contracting authority is 'MAXIMUM_VALUE_NUMERIC' ('cac:ResponseValue/cbc:ResponseNumeric' element) - ('cbc:ID' is <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( ($currentDataType = 'TRANSLATION_TYPE_CODE') and (cac:ResponseValue/cbc:ResponseCode) ) or not($currentDataType = 'TRANSLATION_TYPE_CODE')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( ($currentDataType = 'TRANSLATION_TYPE_CODE') and (cac:ResponseValue/cbc:ResponseCode) ) or not($currentDataType = 'TRANSLATION_TYPE_CODE')">
               <xsl:attribute name="id">BR-TCR-08-18</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of answer expected by the contracting authority is 'TRANSLATION_TYPE_CODE' ('cac:ResponseValue/cbc:ResponseCode' element) - ('cbc:ID' is <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( ($currentDataType = 'CERTIFICATION_LEVEL_DESCRIPTION') and (cac:ResponseValue/cbc:Description) ) or not($currentDataType = 'CERTIFICATION_LEVEL_DESCRIPTION')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( ($currentDataType = 'CERTIFICATION_LEVEL_DESCRIPTION') and (cac:ResponseValue/cbc:Description) ) or not($currentDataType = 'CERTIFICATION_LEVEL_DESCRIPTION')">
               <xsl:attribute name="id">BR-TCR-08-19</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of answer expected by the contracting authority is 'CERTIFICATION_LEVEL_DESCRIPTION' ('cac:ResponseValue/cbc:Description' element) - ('cbc:ID' is <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( ($currentDataType = 'COPY_QUALITY_TYPE_CODE') and (cac:ResponseValue/cbc:ResponseCode) ) or not($currentDataType = 'COPY_QUALITY_TYPE_CODE')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( ($currentDataType = 'COPY_QUALITY_TYPE_CODE') and (cac:ResponseValue/cbc:ResponseCode) ) or not($currentDataType = 'COPY_QUALITY_TYPE_CODE')">
               <xsl:attribute name="id">BR-TCR-08-20</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of answer expected by the contracting authority is 'COPY_QUALITY_TYPE_CODE' ('cac:ResponseValue/cbc:ResponseCode' element) - ('cbc:ID' is <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( ($currentDataType = 'TIME') and (cac:ResponseValue/cbc:ResponseTime) ) or not($currentDataType = 'TIME')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( ($currentDataType = 'TIME') and (cac:ResponseValue/cbc:ResponseTime) ) or not($currentDataType = 'TIME')">
               <xsl:attribute name="id">BR-TCR-08-21</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of answer expected by the contracting authority is 'TIME' ('cac:ResponseValue/cbc:ResponseTime' element) - ('cbc:ID' is <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cac:TenderingCriterionResponse/cac:ResponseValue" priority="1002"
                 mode="M11">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(child::*) &lt;= 2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(child::*) &lt;= 2">
               <xsl:attribute name="id">BR-TCR-04</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Only one sub-element within '/cac:TenderingCriterionResponse/cac:ResponseValue' is admitted at the same time. The criteria response ('/cac:TenderingCriterionResponse/cbc:ValidatedCriterionPropertyID = <xsl:text/>
                  <xsl:value-of select="ancestor::*[1]/cbc:ValidatedCriterionPropertyID"/>
                  <xsl:text/>') has '<xsl:text/>
                  <xsl:value-of select="count(child::*)-1"/>
                  <xsl:text/>' sub-element(s).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cac:SubsidiaryTenderingCriterionPropertyGroup[cbc:PropertyGroupTypeCode = 'ONTRUE']/cac:TenderingCriterionProperty"
                 priority="1001"
                 mode="M11">
      <xsl:variable name="parentUUID"
                    select="ancestor::*[1]/ancestor::*[1]/cac:TenderingCriterionProperty/cbc:ID"/>
      <xsl:variable name="parentTrueResponse"
                    select="key('CriterionResponseType', $parentUUID)/cac:ResponseValue/cbc:ResponseIndicator = true()"/>
      <xsl:variable name="parentFalseResponse"
                    select="key('CriterionResponseType', $parentUUID)/cac:ResponseValue/cbc:ResponseIndicator = false()"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not($parentTrueResponse) or ($parentTrueResponse and count(key('CriterionResponseType', cbc:ID)) = 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not($parentTrueResponse) or ($parentTrueResponse and count(key('CriterionResponseType', cbc:ID)) = 1)">
               <xsl:attribute name="id">BR-TCR-06-01</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>As the response '<xsl:text/>
                  <xsl:value-of select="$parentUUID"/>
                  <xsl:text/>' is TRUE and the property group is codified as ONTRUE, 'cbc:ID = <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>' must be answered as well.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not($parentFalseResponse) or ($parentFalseResponse and count(key('CriterionResponseType', cbc:ID)) = 0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not($parentFalseResponse) or ($parentFalseResponse and count(key('CriterionResponseType', cbc:ID)) = 0)">
               <xsl:attribute name="id">BR-TCR-06-02</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>As the response '<xsl:text/>
                  <xsl:value-of select="$parentUUID"/>
                  <xsl:text/>' is FALSE but the property group is codified as ONTRUE, 'cbc:ID = <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>' must not be answered.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cac:SubsidiaryTenderingCriterionPropertyGroup[cbc:PropertyGroupTypeCode = 'ONFALSE']/cac:TenderingCriterionProperty"
                 priority="1000"
                 mode="M11">
      <xsl:variable name="parentUUID"
                    select="ancestor::*[1]/ancestor::*[1]/cac:TenderingCriterionProperty/cbc:ID"/>
      <xsl:variable name="parentTrueResponse"
                    select="key('CriterionResponseType', $parentUUID)/cac:ResponseValue/cbc:ResponseIndicator = true()"/>
      <xsl:variable name="parentFalseResponse"
                    select="key('CriterionResponseType', $parentUUID)/cac:ResponseValue/cbc:ResponseIndicator = false()"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not($parentFalseResponse) or ($parentFalseResponse and count(key('CriterionResponseType', cbc:ID)) = 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not($parentFalseResponse) or ($parentFalseResponse and count(key('CriterionResponseType', cbc:ID)) = 1)">
               <xsl:attribute name="id">BR-TCR-07-01</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>As the response '<xsl:text/>
                  <xsl:value-of select="$parentUUID"/>
                  <xsl:text/>' is FALSE and the property group is codified as ONFALSE, 'cbc:ID = <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>' must be answered as well.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not($parentTrueResponse) or ($parentTrueResponse and count(key('CriterionResponseType', cbc:ID)) = 0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not($parentTrueResponse) or ($parentTrueResponse and count(key('CriterionResponseType', cbc:ID)) = 0)">
               <xsl:attribute name="id">BR-TCR-07-02</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>As the response '<xsl:text/>
                  <xsl:value-of select="$parentUUID"/>
                  <xsl:text/>' is TRUE but the property group is codified as ONFALSE, 'cbc:ID = <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>' must not be answered.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M11"/>
   <xsl:template match="@*|node()" priority="-2" mode="M11">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/>
   </xsl:template>
</xsl:stylesheet>