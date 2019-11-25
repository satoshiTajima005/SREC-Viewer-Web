<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="no" omit-xml-declaration="no"/>
<!-- ********************************** AIS *********************************************************************** -->
  <xsl:template match="/">
    {
      "type": "product",
      "name": "<xsl:value-of select="//KJE018/PROPERTY_VALUE"/>",
      "children":[
        <xsl:apply-templates select="//KJA027" />
      ]
    }
  </xsl:template>
  <!-- ************************************************階層部***************************************************** -->
  <xsl:template match="KJA027">
    {
      "type": "layer",
      "name": 
      <xsl:choose>
        <xsl:when test="//KJE176/PROPERTY_VALUE='0'">"原部品"</xsl:when>
        <xsl:when test="count(.//KJE055)!=0">
          "<xsl:value-of select=".//KJE055/PROPERTY_VALUE"/>",
          "prop":{
            "KJE055": "<xsl:value-of select=".//KJE055/PROPERTY_VALUE" />",
            "KJE057": "<xsl:value-of select="format-number(.//KJE057/PROPERTY_VALUE, '0.#')" />",
            "KJE184": "<xsl:value-of select=".//KJE184/PROPERTY_VALUE" />"
          }
        </xsl:when>
      </xsl:choose>
      <xsl:if test="count(.//KJA028)!=0">
        ,"children":[
          <xsl:apply-templates select=".//KJA028" />
        ]
      </xsl:if>
    }<xsl:if test="last()!=position()">,</xsl:if>
  </xsl:template>
  <!-- ************************************************部品部***************************************************** -->
  <xsl:template match="KJA028">
    {
      "type": "parts",
      "name": "<xsl:value-of select=".//KJE059/PROPERTY_VALUE"/>",
      "prop": {
        "KJE059": "<xsl:value-of select=".//KJE059/PROPERTY_VALUE" />",
        "KJE185": "<xsl:value-of select="format-number(.//KJE185/PROPERTY_VALUE, '0.#')" />",
        "KJE186": "<xsl:value-of select=".//KJE186/PROPERTY_VALUE" />"
      }
      <xsl:if test="count(.//KJA029)!=0">
        ,"children":[
          <xsl:apply-templates select=".//KJA029" />
        ]
      </xsl:if>
    }<xsl:if test="last()!=position()">,</xsl:if>
  </xsl:template>
  <!-- ************************************************材料部***************************************************** -->
  <xsl:template match="KJA029">
    <xsl:variable name="ver" select="number(substring(//PROPERTY_SNAME[.='Use format']/following-sibling::node()/text(), 5, 1))"/>
    {  
      "type": "material",
      "name": "<xsl:value-of select="number(substring(.//KJE187/PROPERTY_VALUE, 1, 2))"/>",
      "prop":{
        "KJE187": "<xsl:value-of select="number(substring(.//KJE187/PROPERTY_VALUE, 1, 2))"/>",
        "KJE188": "<xsl:value-of select="string(.//KJE189/PROPERTY_VALUE)"/>",
        "KJE189": "<xsl:value-of select=".//KJE189/PROPERTY_VALUE"/>",
        "KJE190": "<xsl:value-of select=".//KJE190/PROPERTY_VALUE"/>",
        "KJE128": "<xsl:if test=".//KJE128/PROPERTY_VALUE!=''"><xsl:value-of select="concat(.//KJE128/PROPERTY_VALUE, .//KJE128/PROPERTY_VALUE/@prefix, 'g')"/></xsl:if>"
        <xsl:if test="$ver='4'">
          ,"KJE296": "<xsl:value-of select=".//KJE296/PROPERTY_VALUE"/>"
        </xsl:if>
      }
      <xsl:if test="count(.//KJA030)!=0">
        ,"children":[
          <xsl:apply-templates select=".//KJA030" />
        ]
      </xsl:if>
    }<xsl:if test="last()!=position()">,</xsl:if>
  </xsl:template>
  <!-- ************************************************物質部***************************************************** -->
  <xsl:template match="KJA030">
    <xsl:variable name="ver" select="number(substring(//PROPERTY_SNAME[.='Use format']/following-sibling::node()/text(), 5, 1))"/>
    {
      "type": "substance",
      "name": "<xsl:value-of select=".//KJE070/PROPERTY_VALUE"/>",
      "prop": {
        "KJE070": "<xsl:value-of select=".//KJE070/PROPERTY_VALUE"/>",
        "KJE071": "<xsl:value-of select=".//KJE071/PROPERTY_VALUE"/>",
        "KJE131": "<xsl:value-of select="concat(.//KJE131/PROPERTY_VALUE, .//KJE131/PROPERTY_VALUE/@unit)"/>",
        "KJE133": "<xsl:if test=".//KJE133/PROPERTY_VALUE!=''"><xsl:value-of select="concat(.//KJE133/PROPERTY_VALUE, .//KJE133/PROPERTY_VALUE/@prefix, 'g')"/></xsl:if>",
        "KJE191": "<xsl:value-of select=".//KJE191/PROPERTY_VALUE"/>"
      }
      <xsl:if test="$ver='3'">
        <xsl:if test="count(.//KJA031)!=0">
          ,"children":[
            <xsl:apply-templates select=".//KJA031" />
          ]
        </xsl:if>
      </xsl:if>
      <xsl:if test="$ver='4'">
        <xsl:if test="count(.//KJE278)!=0">
          ,"children":[
            <xsl:apply-templates select=".//KJA031[count(.//KJE278)!=0]" />
          ]
        </xsl:if>
      </xsl:if>
    }<xsl:if test="last()!=position()">,</xsl:if>
  </xsl:template>
  <!-- ************************************************法令部***************************************************** -->
  <xsl:template match="KJA031">
    <xsl:variable name="ver" select="number(substring(//PROPERTY_SNAME[.='Use format']/following-sibling::node()/text(), 5, 1))"/>
    {
      "type": "law",
      "name": "<xsl:value-of select="string(.//KJE192/PROPERTY_VALUE)"/>",
      "prop": {
        "KJE192": "<xsl:value-of select=".//KJE192/PROPERTY_VALUE" />",
        <xsl:if test="$ver='3'">
          "KJE193": "<xsl:value-of select=".//KJE193/PROPERTY_VALUE"/>",
          "KJE194": "<xsl:value-of select=".//KJE194/PROPERTY_VALUE"/>",
        </xsl:if>
        <xsl:if test="$ver='4'">
          "KJE193": "<xsl:value-of select="string(.//KJE192/PROPERTY_VALUE)"/>",
          "KJE278": "<xsl:value-of select=".//KJE278/PROPERTY_VALUE"/>",
        </xsl:if>
        "KJE195": "<xsl:value-of select=".//KJE195/PROPERTY_VALUE"/>",
        "KJE195exp": "<xsl:value-of select="concat(.//KJE192/PROPERTY_VALUE,.//KJE195/PROPERTY_VALUE)"/>"
      }
    }<xsl:if test="last()!=position()">,</xsl:if>
  </xsl:template>

  <!--
  <xsl:include href="xsl/function.xsl"/>
  <xsl:include href="xsl/dicJAMP.xsl"/>
  -->

</xsl:stylesheet>
