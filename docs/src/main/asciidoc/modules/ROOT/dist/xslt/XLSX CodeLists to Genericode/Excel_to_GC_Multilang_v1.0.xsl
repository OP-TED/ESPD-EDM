<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://docs.oasis-open.org/codelist/ns/genericode/1.0/ ./genericode.xsd">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" omit-xml-declaration="no" standalone="yes" indent="yes"/>
	<xsl:template match="/">
		<xsl:for-each select="/ss:Workbook/ss:Worksheet">
			<xsl:result-document method="xml" href="{@ss:Name}-CodeList.gc">
				<gc:CodeList>
					<Identification>
						<xsl:for-each select="ss:Table/ss:Row">
							<xsl:if test="ss:Cell[1]/ss:Data='ShortName' and not(string(ss:Cell[1]/following-sibling::*[1]))=false()">
								<ShortName>
									<xsl:value-of select="ss:Cell[1]/following-sibling::*[1]"/>
								</ShortName>
							</xsl:if>
							<xsl:if test="ss:Cell[1]/ss:Data='LongName' and not(string(ss:Cell[1]/following-sibling::*[1]))=false()">
								<LongName xml:lang="en">
									<xsl:value-of select="ss:Cell[1]/following-sibling::*[1]"/>
								</LongName>
							</xsl:if>
							<xsl:if test="ss:Cell[1]/ss:Data='Version'">
								<Version>
									<xsl:value-of select="ss:Cell[1]/following-sibling::*[1]"/>
								</Version>
							</xsl:if>
							<xsl:if test="ss:Cell[1]/ss:Data='CanonicalUri' and not(string(ss:Cell[1]/following-sibling::*[1]))=false()">
								<CanonicalUri>
									<xsl:value-of select="ss:Cell[1]/following-sibling::*[1]"/>
								</CanonicalUri>
							</xsl:if>
							<xsl:if test="ss:Cell[1]/ss:Data='CanonicalVersionUri' and not(string(ss:Cell[1]/following-sibling::*[1]))=false()">
								<CanonicalVersionUri>
									<xsl:value-of select="ss:Cell[1]/following-sibling::*[1]"/>
								</CanonicalVersionUri>
							</xsl:if>
							<xsl:if test="ss:Cell[1]/ss:Data='LocationUri' and not(string(ss:Cell[1]/following-sibling::*[1]))=false()">
								<LocationUri>
									<xsl:value-of select="ss:Cell[1]/following-sibling::*[1]"/>
								</LocationUri>
							</xsl:if>
							<xsl:if test="ss:Cell[1]/ss:Data='AgencyLongName' and not(string(ss:Cell[1]/following-sibling::*[1]))=false()">
								<Agency>
									<xsl:variable name="LongName" select="ss:Cell[1]/following-sibling::*[1]"/>
									<xsl:variable name="Identifier" select="following-sibling::*[1]/ss:Cell[1]/following-sibling::*[1]"/>
									<LongName>
										<xsl:attribute name="xml:lang"><xsl:value-of select="following-sibling::*[2]/ss:Cell[1]/following-sibling::*[1]"/></xsl:attribute>
										<xsl:value-of select="$LongName"/>
									</LongName>
									<Identifier>
										<xsl:value-of select="$Identifier"/>
									</Identifier>
								</Agency>
							</xsl:if>
						</xsl:for-each>
					</Identification>
					<xsl:for-each select="ss:Table/ss:Row">
						<xsl:if test="ss:Cell/ss:Data='Code'">
							<xsl:variable name="vars">
								<xsl:for-each select="ss:Cell/following-sibling::*">
									<xsl:variable name="language" select="ss:Data"/>
									<xsl:if test="empty($language)=false()">
										<var>
											<xsl:attribute name="name"><xsl:value-of select="$language"/></xsl:attribute>
											<xsl:value-of select="$language"/>
										</var>
									</xsl:if>
								</xsl:for-each>
							</xsl:variable>
							<ColumnSet>
								<Column Id="code" Use="required">
									<ShortName>Code</ShortName>
									<Data Type="normalizedString" Lang="en"/>
								</Column>
								<Column Id="status" Use="required">
									<ShortName>Status</ShortName>
									<Data Type="normalizedString" Lang="en"/>
								</Column>
								<xsl:for-each select="$vars/var">
									<xsl:variable name="current" select="."/>
									<xsl:if test="not($current = 'Name') and not($current = 'Description') and not($current = 'Status')">
										<Column Use="optional">
											<xsl:attribute name="Id">name-<xsl:value-of select="."/></xsl:attribute>
											<ShortName>Name</ShortName>
											<Data Type="string">
												<xsl:attribute name="Lang"><xsl:value-of select="."/></xsl:attribute>
											</Data>
										</Column>
									</xsl:if>
								</xsl:for-each>
								<Key Id="codeKey">
									<ShortName>CodeKey</ShortName>
									<ColumnRef Ref="code"/>
								</Key>
							</ColumnSet>
							<SimpleCodeList>
								<xsl:for-each select="following-sibling::*">
									<xsl:variable name="currentValue" select="."/>
									<xsl:if test="empty($currentValue/ss:Cell[1]/ss:Data)=false()">
										<Row>
											<Value ColumnRef="code">
												<SimpleValue>
													<xsl:value-of select="ss:Cell[1]"/>
												</SimpleValue>
											</Value>
											<Value ColumnRef="status">
												<SimpleValue>
													<xsl:value-of select="ss:Cell[5]"/>
												</SimpleValue>
											</Value>
											<xsl:for-each select="ss:Cell">
												<xsl:if test="(count(preceding-sibling::*) &gt; 0) and empty(ss:Data)=false() and not(ss:Data='pending')">
													<xsl:variable name="number" as="xs:integer">
														<xsl:value-of select="count(preceding-sibling::*)"/>
													</xsl:variable>
													<xsl:variable name="current" select="$vars/var[($number)]"/>
													<xsl:if test="not($current = 'Name') and not($current = 'Description') and not($current = 'Status')">
														<Value>
															<xsl:attribute name="ColumnRef">name-<xsl:value-of select="$vars/var[($number)]"/></xsl:attribute>
															<SimpleValue>
																<xsl:value-of select="ss:Data"/>
															</SimpleValue>
														</Value>
													</xsl:if>
												</xsl:if>
											</xsl:for-each>
										</Row>
									</xsl:if>
								</xsl:for-each>
							</SimpleCodeList>
						</xsl:if>
					</xsl:for-each>
				</gc:CodeList>
			</xsl:result-document>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
