<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
    <xsl:template match="/">
        <!--html>
            <meta content="text/html;  charset=UTF-8" http-equiv="Content-Type">
                <body style="font-family:Arial;font-size:12pt;background-color:#EEEEEE"-->
        <div style="width:100%;font-family:Arial;background-color:#EEEEEE">
            <h3 style="background-color:5f70af;color:white;padding:4px">
                <xsl:value-of select="svrl:schematron-output/@title"/>
            </h3>
            <xsl:for-each select="svrl:schematron-output/svrl:failed-assert">
                <div style="background-color:003399;color:white;padding:4px;margin:10px;">
                    <span style="font-weight:bold">
                        Error :
                    </span>
                    <xsl:value-of select="svrl:text"/>
                </div>
                <div style="margin-left:20px;margin-bottom:1em;font-size:10pt;width:95%">
                    <p>
                        <b>Location :</b>
                        <table style="width:100%;font-family:Arial;font-size:10pt;background-color:#EEEEEE">
                            <xsl:call-template name="separateLocal">
                                <xsl:with-param name="path" select="@location"/>
                            </xsl:call-template>
                        </table>
                    </p>
                </div>
            </xsl:for-each>
            <xsl:for-each select="svrl:schematron-output/svrl:successful-report">
                <div style="margin-left:20px;margin-bottom:1em;font-size:10pt;width:95%">
                    <span>
                        Validation : correct
                    </span>
                </div>
            </xsl:for-each>
            <xsl:if test="count(svrl:schematron-output/svrl:failed-assert)=0 and count(svrl:schematron-output/svrl:successful-report)=0">
                <div style="margin-left:20px;margin-bottom:1em;font-size:10pt;width:95%">
                    <span>
                        Validation : correct
                    </span>
                </div>
            </xsl:if>
        </div>
        <!--/body>
    </meta>
</html-->
    </xsl:template>
    <xsl:template name="separateLocal">
        <xsl:param name="path"/>
        <xsl:choose>
            <xsl:when test="contains($path, '/*')">
                <tr>
                    <td>
                        <xsl:value-of select="substring-before($path, '/*')"/>
                    </td>
                </tr>
                <xsl:call-template name="separateLocal">
                    <xsl:with-param name="path" select="substring-after($path, '/*')"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <tr>
                    <td>
                        <b>
                            <xsl:value-of select="$path"/>
                        </b>
                    </td>
                </tr>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
