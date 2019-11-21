<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" encoding="UTF-8" indent="no" omit-xml-declaration="no"/>
  <!-- ********************************** AIS *********************************************************************** -->
  <xsl:template match="/">
    <xsl:variable name="ver" select="number(substring(//PROPERTY_SNAME[.='Use format']/following-sibling::node()/text(), 5, 1))"/>
    {
      "thead": [
        [
          {"colspan":"2", "value": "layer"},
          {"colspan":"2", "value": "parts"},
          {"colspan":"<xsl:value-of select="$ver+2"/>", "value": "material"},
          {"colspan":"5", "value": "substance"},
          {"colspan":"4", "value": "raw"}
        ],[
          {"value":"name"},<!--名称-->
          {"value":"qua"},<!--員数-->
          {"value":"name"},<!--名称-->
          {"value":"qua"},<!--員数-->
          {"value":"use"},<!--用途-->
          {"value":"name"},<!--名称-->
          {"value":"symbol"},<!--分類記号-->
          {"value":"standerd"},<!--公的規格-->
          {"value":"mass"},<!--質量-->
          <xsl:if test="$ver='4'">
            {"value":"remarks"},<!--備考-->
          </xsl:if>
          {"value":"CAS"},
          {"value":"name"},<!--名称-->
          {"value":"rate"},<!--含有率-->
          {"value":"mass"},<!--質量-->
          {"value":"remarks"},<!--備考-->
          {"value":"ID"},
          {"value":"name"},<!--名称-->
          {"value":"cls"},<!--該当区分-->
          {"value":"remarks"}<!--備考-->
        ]
      ],
      "tbody":[
        <xsl:for-each select="//KJA027">
          <xsl:apply-templates select="." />
        </xsl:for-each>
      ]]
    }
  </xsl:template>

  <!-- ************************************************階層部***************************************************** -->
  <xsl:template match="KJA027">
    <!-- 変数取得 -->
    <xsl:variable name="ver" select="number(substring(//PROPERTY_SNAME[.='Use format']/following-sibling::node()/text(), 5, 1))"/>
    <xsl:variable name="qBH" select="count(.//KJA028[count(.//KJA029)=0])"/>
    <xsl:variable name="qZR" select="count(.//KJA029[count(.//KJA030)=0])"/>
    <xsl:variable name="qBS" select="count(.//KJA030[count(.//KJA031)=0])"/>
    <xsl:variable name="qHR">
      <xsl:call-template name="getqHR">
        <xsl:with-param name="node" select="." />
        <xsl:with-param name="ver" select="$ver"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="rows">
      <xsl:call-template name="zeroToOne">
        <xsl:with-param name="num" select="$qBH + $qZR + $qBS + $qHR"/>
      </xsl:call-template>
    </xsl:variable>

    <!-- 行入力 -->
    #[
    <xsl:choose>
      <xsl:when test="//KJE176/PROPERTY_VALUE='0' or count(.//EDK027-001)=0">
        {"rowspan":"<xsl:value-of select="$rows"/>", "value":""},
        {"rowspan":"<xsl:value-of select="$rows"/>", "value":""}<xsl:if test="count(.//KJA028)&gt;1">,</xsl:if>
      </xsl:when>
      <xsl:when test="count(.//KJE055)!=0">
        {"rowspan":"<xsl:value-of select="$rows"/>", "value":"<xsl:value-of select=".//KJE055/PROPERTY_VALUE"/>"},
        {"rowspan":"<xsl:value-of select="$rows"/>", "value":"<xsl:value-of select="format-number(.//KJE057/PROPERTY_VALUE, '0.#')"/>"}<xsl:if test="count(.//KJA028)&gt;1">,</xsl:if>
      </xsl:when>
    </xsl:choose>
    <xsl:apply-templates select=".//KJA028[1]"/>

    <xsl:if test="count(.//KJA028)!=0">
      <xsl:for-each select=".//KJA028[position()!=1]">
        #[<xsl:apply-templates select="."/>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>

  <!-- ************************************************部品部***************************************************** -->
  <xsl:template match="KJA028">
    <!-- 変数取得 -->
    <xsl:variable name="ver" select="number(substring(//PROPERTY_SNAME[.='Use format']/following-sibling::node()/text(), 5, 1))"/>
    <xsl:variable name="qZR" select="count(.//KJA029[count(.//KJA030)=0])"/>
    <xsl:variable name="qBS" select="count(.//KJA030[count(.//KJA031)=0])"/>
    <xsl:variable name="qHR">
      <xsl:call-template name="getqHR">
        <xsl:with-param name="node" select="." />
        <xsl:with-param name="ver" select="$ver"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="rows">
      <xsl:call-template name="zeroToOne">
        <xsl:with-param name="num" select="$qZR + $qBS + $qHR"/>
      </xsl:call-template>
    </xsl:variable>

    <!-- 行入力 -->
    {"rowspan":"<xsl:value-of select="$rows"/>", "value":"<xsl:value-of select=".//KJE059/PROPERTY_VALUE"/>"},
    {"rowspan":"<xsl:value-of select="$rows"/>", "value":"<xsl:value-of select="format-number(.//KJE185/PROPERTY_VALUE, '0.#')"/>"}<xsl:if test="count(.//KJA029)!=0">,</xsl:if>
    <xsl:apply-templates select=".//KJA029[1]"/>

    <xsl:if test="count(.//KJA029)=0">
      ,{"value":""}
      ,{"value":""}
      ,{"value":""}
      ,{"value":""}
      ,{"value":""}
      ,{"value":""}
      ,{"value":""}
      ,{"value":""}
      ,{"value":""}
      ,{"value":""}
      ,{"value":""}
      ,{"value":""}
      ,{"value":""}
      ,{"value":""}
      <xsl:if test="$ver='4'">
        ,{"value":""}
      </xsl:if>
    </xsl:if>
    <xsl:if test="count(.//KJA029)!=0">
      <xsl:for-each select=".//KJA029[position()!=1]">
        #[<xsl:apply-templates select="."/>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>

  <!-- ************************************************材料部***************************************************** -->
  <xsl:template match="KJA029">
    <!-- 変数取得 -->
    <xsl:variable name="ver" select="number(substring(//PROPERTY_SNAME[.='Use format']/following-sibling::node()/text(), 5, 1))"/>
    <xsl:variable name="qBS" select="count(.//KJA030[count(.//KJA031)=0])"/>
    <xsl:variable name="qHR">
      <xsl:call-template name="getqHR">
        <xsl:with-param name="node" select="." />
        <xsl:with-param name="ver" select="$ver"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="rows">
      <xsl:call-template name="zeroToOne">
        <xsl:with-param name="num" select="$qBS + $qHR"/>
      </xsl:call-template>
    </xsl:variable>

    <!-- 行入力 -->
    {"rowspan":"<xsl:value-of select="$rows"/>", "value":"<xsl:value-of select="number(substring(.//KJE187/PROPERTY_VALUE, 1, 2))"/>"},
    {"rowspan":"<xsl:value-of select="$rows"/>", "value":"<xsl:value-of select="string(.//KJE189/PROPERTY_VALUE)"/>"},
    {"rowspan":"<xsl:value-of select="$rows"/>", "value":"<xsl:value-of select=".//KJE189/PROPERTY_VALUE"/>"},
    {"rowspan":"<xsl:value-of select="$rows"/>", "value":"<xsl:value-of select=".//KJE190/PROPERTY_VALUE"/>"},
    {"rowspan":"<xsl:value-of select="$rows"/>", "value":"<xsl:if test=".//KJE128/PROPERTY_VALUE!=''"><xsl:value-of select="concat(.//KJE128/PROPERTY_VALUE, .//KJE128/PROPERTY_VALUE/@prefix, 'g')"/></xsl:if>"}
    <xsl:if test="$ver='3' and count(.//KJA030)!=0">,</xsl:if>
    <xsl:if test="$ver='4'">
      ,{"rowspan":"<xsl:value-of select="$rows"/>", "value":"<xsl:value-of select=".//KJE296/PROPERTY_VALUE"/>"}<xsl:if test="count(.//KJA030)!=0">,</xsl:if>
    </xsl:if>
    <xsl:apply-templates select=".//KJA030[1]"/>
    <xsl:if test="count(.//KJA030)=0">
      ,{"value":""}
      ,{"value":""}
      ,{"value":""}
      ,{"value":""}
      ,{"value":""}
      ,{"value":""}
      ,{"value":""}
      ,{"value":""}
      ,{"value":""}
    </xsl:if>
    <xsl:if test="count(.//KJA030)!=0">
      <xsl:for-each select=".//KJA030[position()!=1]">
        #[<xsl:apply-templates select="."/>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>

  <!-- ************************************************物質部***************************************************** -->
  <xsl:template match="KJA030">
    <!-- 変数取得 -->
    <xsl:variable name="ver" select="number(substring(//PROPERTY_SNAME[.='Use format']/following-sibling::node()/text(), 5, 1))"/>
    <xsl:variable name="qHR">
      <xsl:call-template name="getqHR">
        <xsl:with-param name="node" select="." />
        <xsl:with-param name="ver" select="$ver"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="rows">
      <xsl:call-template name="zeroToOne">
        <xsl:with-param name="num" select="$qHR"/>
      </xsl:call-template>
    </xsl:variable>

    <!-- 行入力 -->
    {"rowspan":"<xsl:value-of select="$rows"/>", "value":"<xsl:value-of select=".//KJE071/PROPERTY_VALUE"/>"},
    {"rowspan":"<xsl:value-of select="$rows"/>", "value":"<xsl:value-of select=".//KJE070/PROPERTY_VALUE"/>"},
    {"rowspan":"<xsl:value-of select="$rows"/>", "value":"
      <xsl:if test=".//KJE131/PROPERTY_VALUE!=''">
        <xsl:call-template name="unitConvR">
          <xsl:with-param name="rate" select=".//KJE131/PROPERTY_VALUE"/>
          <xsl:with-param name="unit" select=".//KJE131/PROPERTY_VALUE/@unit"/>
        </xsl:call-template>
      </xsl:if>
    "},
    {"rowspan":"<xsl:value-of select="$rows"/>", "value":"<xsl:if test=".//KJE133/PROPERTY_VALUE!=''"><xsl:value-of select="concat(.//KJE133/PROPERTY_VALUE, .//KJE133/PROPERTY_VALUE/@prefix, 'g')"/></xsl:if>"},
    {"rowspan":"<xsl:value-of select="$rows"/>", "value":"<xsl:value-of select=".//KJE191/PROPERTY_VALUE"/>"},

    <xsl:if test="$ver='3'">
      <xsl:apply-templates select=".//KJA031[1]" /><!--<xsl:if test="count(.//KJA031)=1">],</xsl:if>-->
      <xsl:if test="count(.//KJA031)=0">
        {"value":""},
        {"value":""},
        {"value":""},
        {"value":""}
      </xsl:if>
      <xsl:if test="count(.//KJA031)!=0">
        <xsl:for-each select=".//KJA031[position()!=1]">
          #[<xsl:apply-templates select="." />
        </xsl:for-each>
      </xsl:if>
    </xsl:if>
    <xsl:if test="$ver='4'">
      <xsl:apply-templates select=".//KJA031[count(.//KJE278)!=0][1]"/><!--<xsl:if test="count(.//KJE278)=1">],</xsl:if>-->
      <xsl:if test="count(.//KJE278)=0">
        {"value":""},
        {"value":""},
        {"value":""},
        {"value":""}
      </xsl:if>
      <xsl:if test="count(.//KJE278)!=0">
        <xsl:for-each select=".//KJA031[count(.//KJE278)!=0][position()!=1]">
          #[<xsl:apply-templates select="."/>
        </xsl:for-each>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <!-- ************************************************法令部***************************************************** -->
  <xsl:template match="KJA031">
    <!-- 変数取得 -->
    <xsl:variable name="ver" select="number(substring(//PROPERTY_SNAME[.='Use format']/following-sibling::node()/text(), 5, 1))"/>

    <!-- 行入力 -->
    {"value":"<xsl:value-of select=".//KJE192/PROPERTY_VALUE"/>"},
    {"value":"<xsl:value-of select=".//KJE192/PROPERTY_VALUE"/>"},
    <xsl:if test="$ver='3'">
      {"value":"<xsl:value-of select=".//KJE194/PROPERTY_VALUE"/>"},
    </xsl:if>
    <xsl:if test="$ver='4'">
      {"value":"<xsl:value-of select=".//KJE278/PROPERTY_VALUE"/>"},
    </xsl:if>
    {"value":"<xsl:value-of select=".//KJE195/PROPERTY_VALUE"/>"}
  </xsl:template>

  <!-- ************************************************関数郡***************************************************** -->
  <xsl:template name="getqHR">
    <xsl:param name="node" />
    <xsl:param name="ver" />
    <xsl:if test="$ver='3'">
      <xsl:value-of select="count($node//KJA031)" />
    </xsl:if>
    <xsl:if test="$ver='4'">
      <xsl:value-of select="count($node//KJE278)" />
    </xsl:if>
  </xsl:template>

  	<!-- 比率単位変換関数 -->
	<xsl:template name="unitConvR">
		<xsl:param name="rate" />
		<xsl:param name="unit" />
		<xsl:choose>
			<xsl:when test="$unit='ppm'">
				<xsl:value-of select="concat($rate div 10000, '%')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($rate, '%')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

  <xsl:template name="zeroToOne">
    <xsl:param name="num" />
		<xsl:if test="$num=0">
			<xsl:value-of select="1"/>
		</xsl:if>
		<xsl:if test="$num!=0">
			<xsl:value-of select="$num"/>
		</xsl:if>
	</xsl:template>

  <!--
  <xsl:include href="xsl/function.xsl"/>
  <xsl:include href="xsl/dicJAMP.xsl"/>
  -->
</xsl:stylesheet>