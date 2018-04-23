<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ccv="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonAggregateComponents-1"
    xmlns:cbc-old="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" 
    xmlns:cac="urn:X-test:UBL:Pre-award:CommonAggregate" 
    xmlns:cbc="urn:X-test:UBL:Pre-award:CommonBasic"
    exclude-result-prefixes="#all"
    version="2.0">
    
    <xsl:import href="../criteria/criterionHeader.xslt"/>
    <xsl:import href="../criteria/Legislation.xslt"/>
    <xsl:import href="../criteria/SC-Setup_of_economic_operator.xslt"/>
    <xsl:import href="../criteria/SC-Financial_ratios.xslt"/>
    <xsl:import href="../criteria/EG-Convictions.xslt"/>
    <xsl:import href="../criteria/SC-Suitability.xslt"/>
    
    
    
    <xsl:template name="Criteria">
       <xsl:for-each select="node()/ccv:Criterion">
           
          <xsl:variable name="code" select="./cbc-old:TypeCode"/>
              <cbc:TenderingCriterion> 
              <xsl:call-template name="criterionHeader"/>
              <xsl:call-template name="Legislation"/>
           
              <xsl:choose>
                 <xsl:when test="contains($code, 'CRITERION.EXCLUSION.CONVICTIONS')">
                     
                     <!--
                    <cac:TenderingCriterion>
                         <xsl:call-template name="EG-Convictions"/>
                    </cac:TenderingCriterion>
                    -->
               </xsl:when>
               <xsl:when test="contains($code, 'CRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.TURNOVER.SET_UP')">
                    <xsl:call-template name="SC-Setup_of_economic_operator"/>
               </xsl:when>
                 <xsl:when test="contains($code, 'CRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.FINANCIAL_RATIO')">
                     <!--
                     <cac:TenderingCriterion>
                        <xsl:call-template name="SC-Financial_ratios"/>
                     </cac:TenderingCriterion>
                     -->
               </xsl:when>
                  <xsl:when test="contains($code, 'CRITERION.SELECTION.SUITABILITY.PROFESSIONAL_REGISTER_ENROLMENT')">
                      <xsl:call-template name="SC-Suitability"/>
               </xsl:when>   
           </xsl:choose>
           </cbc:TenderingCriterion>     
     </xsl:for-each>
    </xsl:template>

    <!-- #### Old criteria code ### 
                <xsl:for-each select="node()/ccv:Criterion">
                    <xsl:variable name="id" select="cbc-old:ID"/>
                    <xsl:copy-of select="(document('../REGULATED-ESPDRequest-2.0.2.xml')//cac:TenderingCriterion[starts-with(cbc:ID, $id)])" copy-namespaces="no"/>
                </xsl:for-each>
    -->
</xsl:stylesheet>