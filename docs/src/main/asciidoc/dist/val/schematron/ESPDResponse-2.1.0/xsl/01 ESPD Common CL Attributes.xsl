<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
                xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:espd-req="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationRequest-2"
                xmlns:espd-resp="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationResponse-2"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
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
                              title="Common Criterion Business Rules"
                              schemaVersion="">
         <xsl:comment>
            <xsl:value-of select="$archiveDirParameter"/>   
		 <xsl:value-of select="$archiveNameParameter"/>  
		 <xsl:value-of select="$fileNameParameter"/>  
		 <xsl:value-of select="$fileDirParameter"/>
         </xsl:comment>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
                                             prefix="cac"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
                                             prefix="cbc"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">BR-COM-CL-ATT</xsl:attribute>
            <xsl:attribute name="name">BR-COM-CL-ATT</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M3"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Common Criterion Business Rules</svrl:text>

   <!--PATTERN BR-COM-CL-ATT-->


	<!--RULE -->
<xsl:template match="cbc:ConfidentialityLevelCode" priority="1015" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'ConfidentialityLevel'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'ConfidentialityLevel'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listName = ConfidentialityLevel'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'ConfidentialityLevel'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'ConfidentialityLevel'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listID = ConfidentialityLevel'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/ConfidentialityLevel.gc'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/ConfidentialityLevel.gc'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listSchemeURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listSchemeURI = https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/ConfidentialityLevel.gc'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listURI != 'https://github.com/ESPD/ESPD-EDM'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listURI != 'https://github.com/ESPD/ESPD-EDM'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listURI = https://github.com/ESPD/ESPD-EDM'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyName != 'DG GROW (European Commission)'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyName != 'DG GROW (European Commission)'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyName = DG GROW (European Commission)'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyID != 'EU-COM-GROW'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyID != 'EU-COM-GROW'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyID = EU-COM-GROW'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cac:Country/cbc:IdentificationCode" priority="1014" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'CountryCodeIdentifier'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'CountryCodeIdentifier'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listName = CountryCodeIdentifier'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'CountryCodeIdentifier'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'CountryCodeIdentifier'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listID = CountryCodeIdentifier'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listVersionID != '1.0'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listVersionID != '1.0'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listVersionID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listVersionID = 1.0'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listSchemeURI != 'Placeholder'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listSchemeURI != 'Placeholder'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listSchemeURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listSchemeURI = Placeholder'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listURI != 'Placeholder'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listURI != 'Placeholder'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listURI = Placeholder'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyName != 'ISO'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyName != 'ISO'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyName = ISO'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyID != 'ISO'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyID != 'ISO'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyID = ISO'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cbc:TypeCode" priority="1013" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'CriterionElementType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'CriterionElementType'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listName = CriterionElementType'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'CriterionElementType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'CriterionElementType'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listID = CriterionElementType'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/CriterionElementType.gc'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/CriterionElementType.gc'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listSchemeURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listSchemeURI = https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/CriterionElementType.gc'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listURI != 'https://github.com/ESPD/ESPD-EDM'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listURI != 'https://github.com/ESPD/ESPD-EDM'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listURI = https://github.com/ESPD/ESPD-EDM'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyName != 'DG GROW (European Commission)'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyName != 'DG GROW (European Commission)'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyName = DG GROW (European Commission)'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyID != 'EU-COM-GROW'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyID != 'EU-COM-GROW'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyID = EU-COM-GROW'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cbc:ValueCurrencyCode" priority="1012" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'CurrencyCode'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'CurrencyCode'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listName = CurrencyCode'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'CurrencyCode'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'CurrencyCode'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listID = CurrencyCode'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listVersionID != '1.0'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listVersionID != '1.0'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listVersionID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listVersionID = 1.0'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/CurrencyCode.gc'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/CurrencyCode.gc'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listSchemeURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listSchemeURI = https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/CurrencyCode.gc'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listURI != 'http://publications.europa.eu/mdr/authority/index.html'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listURI != 'http://publications.europa.eu/mdr/authority/index.html'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listURI = http://publications.europa.eu/mdr/authority/index.html'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyName != 'Publications Office of the EU'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyName != 'Publications Office of the EU'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyName = Publications Office of the EU'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyID != 'EU-COM-OP'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyID != 'EU-COM-OP'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyID = EU-COM-OP'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cac:AdditionalReferenceDocument/cbc:DocumentTypeCode" priority="1011"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'DocRefContentType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'DocRefContentType'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listName = DocRefContentType'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'DocRefContentType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'DocRefContentType'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listID = DocRefContentType'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/DocRefContentType.gc'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/DocRefContentType.gc'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listSchemeURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listSchemeURI = https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/DocRefContentType.gc'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listURI != 'https://github.com/ESPD/ESPD-EDM'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listURI != 'https://github.com/ESPD/ESPD-EDM'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listURI = https://github.com/ESPD/ESPD-EDM'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyName != 'DG GROW (European Commission)'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyName != 'DG GROW (European Commission)'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyName = DG GROW (European Commission)'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyID != 'EU-COM-GROW'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyID != 'EU-COM-GROW'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyID = EU-COM-GROW'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cac:EconomicOperatorParty/cac:Party/cbc:IndustryClassificationCode"
                 priority="1010"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'EOIndustryClassificationCode'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'EOIndustryClassificationCode'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listName = EOIndustryClassificationCode'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'EOIndustryClassificationCode'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'EOIndustryClassificationCode'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listID = EOIndustryClassificationCode'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/EOIndustryClassificationCode.gc'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/EOIndustryClassificationCode.gc'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listSchemeURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listSchemeURI = https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/EOIndustryClassificationCode.gc'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listURI != 'https://github.com/ESPD/ESPD-EDM'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listURI != 'https://github.com/ESPD/ESPD-EDM'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listURI = https://github.com/ESPD/ESPD-EDM'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyName != 'DG GROW (European Commission)'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyName != 'DG GROW (European Commission)'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyName = DG GROW (European Commission)'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyID != 'EU-COM-GROW'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyID != 'EU-COM-GROW'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyID = EU-COM-GROW'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cac:EconomicOperatorParty/cac:EconomicOperatorRole/cbc:RoleCode"
                 priority="1009"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'EORoleType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'EORoleType'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listName = EORoleType'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'EORoleType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'EORoleType'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listID = EORoleType'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/EORoleType.gc'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/EORoleType.gc'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listSchemeURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listSchemeURI = https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/EORoleType.gc'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listURI != 'https://github.com/ESPD/ESPD-EDM'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listURI != 'https://github.com/ESPD/ESPD-EDM'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listURI = https://github.com/ESPD/ESPD-EDM'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyName != 'DG GROW (European Commission)'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyName != 'DG GROW (European Commission)'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyName = DG GROW (European Commission)'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyID != 'EU-COM-GROW'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyID != 'EU-COM-GROW'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyID = EU-COM-GROW'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cac:TenderingCriterion/cbc:EvaluationMethodTypeCode" priority="1008"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'EvaluationMethodType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'EvaluationMethodType'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listName = EvaluationMethodType'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'EvaluationMethodType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'EvaluationMethodType'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listID = EvaluationMethodType'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/EvaluationMethodType.gc'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/EvaluationMethodType.gc'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listSchemeURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listSchemeURI = https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/EvaluationMethodType.gc'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listURI != 'https://github.com/ESPD/ESPD-EDM'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listURI != 'https://github.com/ESPD/ESPD-EDM'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listURI = https://github.com/ESPD/ESPD-EDM'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyName != 'DG GROW (European Commission)'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyName != 'DG GROW (European Commission)'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyName = DG GROW (European Commission)'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyID != 'EU-COM-GROW'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyID != 'EU-COM-GROW'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyID = EU-COM-GROW'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cbc:ProcedureCode" priority="1007" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'ProcedureType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'ProcedureType'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listName = ProcedureType'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'ProcedureType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'ProcedureType'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listID = ProcedureType'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listVersionID != '1.0'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listVersionID != '1.0'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listVersionID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listVersionID = 1.0'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/ProcedyreType.gc'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/ProcedyreType.gc'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listSchemeURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listSchemeURI = https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/ProcedyreType.gc'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listURI != 'http://publications.europa.eu/mdr/authority/index.html'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listURI != 'http://publications.europa.eu/mdr/authority/index.html'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listURI = http://publications.europa.eu/mdr/authority/index.html'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyName != 'Publications Office of the EU'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyName != 'Publications Office of the EU'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyName = Publications Office of the EU'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyID != 'EU-COM-OP'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyID != 'EU-COM-OP'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyID = EU-COM-OP'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cbc:ProcurementTypeCode" priority="1006" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'ProjectType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'ProjectType'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listName = ProjectType'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'ProjectType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'ProjectType'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listID = ProjectType'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listVersionID != '1.0'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listVersionID != '1.0'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listVersionID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listVersionID = 1.0'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/ProjectType.gc'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/ProjectType.gc'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listSchemeURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listSchemeURI = https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/ProjectType.gc'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listURI != 'http://publications.europa.eu/mdr/authority/index.html'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listURI != 'http://publications.europa.eu/mdr/authority/index.html'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listURI = http://publications.europa.eu/mdr/authority/index.html'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyName != 'Publications Office of the EU'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyName != 'Publications Office of the EU'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyName = Publications Office of the EU'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyID != 'EU-COM-OP'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyID != 'EU-COM-OP'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyID = EU-COM-OP'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cac:TenderingCriterionPropertyGroup/cbc:PropertyGroupTypeCode"
                 priority="1005"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'PropertyGroupType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'PropertyGroupType'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listName = PropertyGroupType'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'PropertyGroupType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'PropertyGroupType'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listID = PropertyGroupType'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/PropertyGroupType.gc'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/PropertyGroupType.gc'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listSchemeURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listSchemeURI = https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/PropertyGroupType.gc'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listURI != 'https://github.com/ESPD/ESPD-EDM'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listURI != 'https://github.com/ESPD/ESPD-EDM'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listURI = https://github.com/ESPD/ESPD-EDM'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyName != 'DG GROW (European Commission)'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyName != 'DG GROW (European Commission)'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyName = DG GROW (European Commission)'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyID != 'EU-COM-GROW'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyID != 'EU-COM-GROW'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyID = EU-COM-GROW'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cbc:QualificationApplicationTypeCode" priority="1004" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'QualificationApplicationType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'QualificationApplicationType'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listName = QualificationApplicationType'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'QualificationApplicationType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'QualificationApplicationType'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listID = QualificationApplicationType'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/QualificationApplicationType.gc'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/QualificationApplicationType.gc'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listSchemeURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listSchemeURI = https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/QualificationApplicationType.gc'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listURI != 'https://github.com/ESPD/ESPD-EDM'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listURI != 'https://github.com/ESPD/ESPD-EDM'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listURI = https://github.com/ESPD/ESPD-EDM'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyName != 'DG GROW (European Commission)'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyName != 'DG GROW (European Commission)'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyName = DG GROW (European Commission)'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyID != 'EU-COM-GROW'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyID != 'EU-COM-GROW'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyID = EU-COM-GROW'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cac:TenderingCriterionProperty/cbc:ValueDataTypeCode" priority="1003"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'ResponseDataType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'ResponseDataType'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listName = ResponseDataType'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'ResponseDataType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'ResponseDataType'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listID = ResponseDataType'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/ResponseDataType.gc'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/ResponseDataType.gc'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listSchemeURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listSchemeURI = https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/ResponseDataType.gc'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listURI != 'https://github.com/ESPD/ESPD-EDM'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listURI != 'https://github.com/ESPD/ESPD-EDM'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listURI = https://github.com/ESPD/ESPD-EDM'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyName != 'DG GROW (European Commission)'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyName != 'DG GROW (European Commission)'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyName = DG GROW (European Commission)'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyID != 'EU-COM-GROW'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyID != 'EU-COM-GROW'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyID = EU-COM-GROW'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cac:ProcurementProject/cbc:ProcurementSubTypeCode" priority="1002"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'ServicesProjectSubType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'ServicesProjectSubType'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listName = ServicesProjectSubType'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'ServicesProjectSubType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'ServicesProjectSubType'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listID = ServicesProjectSubType'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listVersionID != '1.0'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listVersionID != '1.0'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listVersionID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listVersionID = 1.0'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/ServicesProjectSubType.gc'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/ServicesProjectSubType.gc'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listSchemeURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listSchemeURI = https://github.com/ESPD/ESPD-EDM/tree/ESPD-EDM-V2.1.0/docs/src/main/asciidoc/dist/cl/gc/ServicesProjectSubType.gc'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listURI != 'http://publications.europa.eu/mdr/authority/index.html'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listURI != 'http://publications.europa.eu/mdr/authority/index.html'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listURI = http://publications.europa.eu/mdr/authority/index.html'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyName != 'Publications Office of the EU'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyName != 'Publications Office of the EU'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyName = Publications Office of the EU'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyID != 'EU-COM-OP'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyID != 'EU-COM-OP'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyID = EU-COM-OP'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cbc:CriterionTypeCode" priority="1001" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'CriteriaTypeCode'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'CriteriaTypeCode'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listName = CriteriaTypeCode'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'CriteriaTypeCode'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'CriteriaTypeCode'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listID = CriteriaTypeCode'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listURI != 'https://github.com/ESPD/ESPD-EDM'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listURI != 'https://github.com/ESPD/ESPD-EDM'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listURI = https://github.com/ESPD/ESPD-EDM'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyName != 'DG GROW (European Commission)'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyName != 'DG GROW (European Commission)'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyName = DG GROW (European Commission)'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyID != 'EU-COM-GROW'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyID != 'EU-COM-GROW'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyID = EU-COM-GROW'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cbc:WeightingTypeCode" priority="1000" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'WeightingType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'WeightingType'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listName = WeightingType'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'WeightingType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'WeightingType'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listID = WeightingType'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listURI != 'https://github.com/ESPD/ESPD-EDM'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listURI != 'https://github.com/ESPD/ESPD-EDM'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listURI"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listURI = https://github.com/ESPD/ESPD-EDM'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyName != 'DG GROW (European Commission)'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyName != 'DG GROW (European Commission)'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyName"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyName = DG GROW (European Commission)'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyID != 'EU-COM-GROW'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyID != 'EU-COM-GROW'))">
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invalid codelist attribute value '<xsl:text/>
                  <xsl:value-of select="@listAgencyID"/>
                  <xsl:text/>'. The element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>' must have the following attribute and value: 'listAgencyID = EU-COM-GROW'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M3"/>
   <xsl:template match="@*|node()" priority="-2" mode="M3">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>
</xsl:stylesheet>