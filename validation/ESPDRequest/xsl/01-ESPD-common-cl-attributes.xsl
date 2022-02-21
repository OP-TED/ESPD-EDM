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
<xsl:template match="cbc:ConfidentialityLevelCode" priority="1009" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'access-right'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'access-right'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listName = access-right'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'http://publications.europa.eu/resource/authority/access-right'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'http://publications.europa.eu/resource/authority/access-right'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listID = http://publications.europa.eu/resource/authority/access-right'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listSchemeURI != 'http://publications.europa.eu/resource/distribution/access-right/20211208-0/xml/gc/AccessRight.gc'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listSchemeURI != 'http://publications.europa.eu/resource/distribution/access-right/20211208-0/xml/gc/AccessRight.gc'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listSchemeURI = http://publications.europa.eu/resource/distribution/access-right/20211208-0/xml/gc/AccessRight.gc'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listURI != 'http://publications.europa.eu/resource/authority/access-right'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listURI != 'http://publications.europa.eu/resource/authority/access-right'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listURI = http://publications.europa.eu/resource/authority/access-right'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyName != 'Publications Office of the European Union'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyName != 'Publications Office of the European Union'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listAgencyName = Publications Office of the European Union'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyID != 'OP'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyID != 'OP'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listAgencyID = OP'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cac:Country/cbc:IdentificationCode" priority="1008" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'country'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'country'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listName = country'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'http://publications.europa.eu/resource/authority/country'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'http://publications.europa.eu/resource/authority/country'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listID = http://publications.europa.eu/resource/authority/country'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listVersionID != '20211208-0'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listVersionID != '20211208-0'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listVersionID = 20211208-0'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listSchemeURI != 'http://publications.europa.eu/resource/distribution/country/20211208-0/xml/gc/Country.gc'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listSchemeURI != 'http://publications.europa.eu/resource/distribution/country/20211208-0/xml/gc/Country.gc'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listSchemeURI = http://publications.europa.eu/resource/distribution/country/20211208-0/xml/gc/Country.gc'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listURI != 'http://publications.europa.eu/resource/dataset/country'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listURI != 'http://publications.europa.eu/resource/dataset/country'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listURI = http://publications.europa.eu/resource/dataset/country'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyName != 'Publications Office of the European Union'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyName != 'Publications Office of the European Union'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listAgencyName = Publications Office of the European Union'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyID != 'OP'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyID != 'OP'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listAgencyID = OP'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cbc:TypeCode" priority="1007" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'criterion-element-type'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'criterion-element-type'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listName = criterion-element-type'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'criterion-element-type'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'criterion-element-type'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listID = criterion-element-type'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/v3.0.1/codelists/gc/CriterionElementType.gc'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/v3.0.1/codelists/gc/CriterionElementType.gc'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listSchemeURI = https://github.com/ESPD/ESPD-EDM/tree/v3.0.1/codelists/gc/CriterionElementType.gc'.</svrl:text>
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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cbc:ValueCurrencyCode" priority="1006" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'currency'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'currency'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listName = currency'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'http://publications.europa.eu/resource/authority/currency'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'http://publications.europa.eu/resource/authority/currency'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listID = http://publications.europa.eu/resource/authority/currency'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listVersionID != '20211208-0'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listVersionID != '20211208-0'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listVersionID = 20211208-0'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listSchemeURI != 'http://publications.europa.eu/resource/distribution/currency/20211208-0/xml/gc/Currency.gc'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listSchemeURI != 'http://publications.europa.eu/resource/distribution/currency/20211208-0/xml/gc/Currency.gc'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listSchemeURI = http://publications.europa.eu/resource/distribution/currency/20211208-0/xml/gc/Currency.gc'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listURI != 'http://publications.europa.eu/resource/authority/currency'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listURI != 'http://publications.europa.eu/resource/authority/currency'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listURI = http://publications.europa.eu/resource/authority/currency'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyName != 'Publications Office of the European Union'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyName != 'Publications Office of the European Union'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listAgencyName = Publications Office of the European Union'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyID != 'OP'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyID != 'OP'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listAgencyID = OP'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cac:AdditionalReferenceDocument/cbc:DocumentTypeCode" priority="1005"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'docrefcontent-type'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'docrefcontent-type'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listName = docrefcontent-type'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'docrefcontent-type'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'docrefcontent-type'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listID = docrefcontent-type'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/v3.0.1/codelists/gc/DocRefContentType.gc'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/v3.0.1/codelists/gc/DocRefContentType.gc'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listSchemeURI = https://github.com/ESPD/ESPD-EDM/tree/v3.0.1/codelists/gc/DocRefContentType.gc'.</svrl:text>
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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cac:EconomicOperatorParty/cac:EconomicOperatorRole/cbc:RoleCode"
                 priority="1004"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'eo-role-type'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'eo-role-type'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listName = eo-role-type'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'http://publications.europa.eu/resource/authority/eo-role-type'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'http://publications.europa.eu/resource/authority/eo-role-type'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listID = http://publications.europa.eu/resource/authority/eo-role-type'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listSchemeURI != 'http://publications.europa.eu/resource/distribution/eo-role-type/20211208-0/xml/gc/EoRoleType.gc'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listSchemeURI != 'http://publications.europa.eu/resource/distribution/eo-role-type/20211208-0/xml/gc/EoRoleType.gc'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listSchemeURI = http://publications.europa.eu/resource/distribution/eo-role-type/20211208-0/xml/gc/EoRoleType.gc'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listURI != 'http://publications.europa.eu/resource/authority/eo-role-type'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listURI != 'http://publications.europa.eu/resource/authority/eo-role-type'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listURI = http://publications.europa.eu/resource/authority/eo-role-type'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyName != 'Publications Office of the European Union'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyName != 'Publications Office of the European Union'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listAgencyName = Publications Office of the European Union'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyID != 'OP'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyID != 'OP'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listAgencyID = OP'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cac:TenderingCriterionPropertyGroup/cbc:PropertyGroupTypeCode"
                 priority="1003"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'property-group-type'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'property-group-type'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listName = property-group-type'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'property-group-type'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'property-group-type'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listID = property-group-type'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/v3.0.1/codelists/gc/PropertyGroupType.gc'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/v3.0.1/codelists/gc/PropertyGroupType.gc'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listSchemeURI = https://github.com/ESPD/ESPD-EDM/tree/v3.0.1/codelists/gc/PropertyGroupType.gc'.</svrl:text>
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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cac:TenderingCriterionProperty/cbc:ValueDataTypeCode" priority="1002"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'response-data-type'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'response-data-type'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listName = response-data-type'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'response-data-type'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'response-data-type'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listID = response-data-type'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/v3.0.1/codelists/gc/ResponseDataType.gc'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listSchemeURI != 'https://github.com/ESPD/ESPD-EDM/tree/v3.0.1/codelists/gc/ResponseDataType.gc'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listSchemeURI = https://github.com/ESPD/ESPD-EDM/tree/v3.0.1/codelists/gc/ResponseDataType.gc'.</svrl:text>
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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cbc:CriterionTypeCode" priority="1001" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'criterion'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'criterion'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listName = criterion'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'http://publications.europa.eu/resource/authority/criterion'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'http://publications.europa.eu/resource/authority/criterion'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listID = http://publications.europa.eu/resource/authority/criterion'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listURI != 'http://publications.europa.eu/resource/dataset/criterion'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listURI != 'http://publications.europa.eu/resource/dataset/criterion'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listURI = http://publications.europa.eu/resource/dataset/criterion'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyName != 'Publications Office of the European Union'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyName != 'Publications Office of the European Union'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listAgencyName = Publications Office of the European Union'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listAgencyID != 'OP'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listAgencyID != 'OP'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listAgencyID = OP'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cbc:occupation" priority="1000" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listName != 'occupation'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listName != 'occupation'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listName = occupation'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(false() or not(@listID != 'criterion'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(false() or not(@listID != 'criterion'))">
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
                  <xsl:text/>' must have the following attribute and value: 'listID = occupation'.</svrl:text>
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