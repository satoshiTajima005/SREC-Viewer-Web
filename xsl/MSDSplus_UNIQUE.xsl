<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="UTF-8" indent="no" omit-xml-declaration="no"/>
<!-- *********************************************************************** MSDSplus *********************************************************************** -->
<xsl:template match="/">
<xsl:variable name="ver" select="number(substring(//PROPERTY_SNAME[.='Use format']/following-sibling::node()/text(), 5, 1))"/>
  {
		"MS1":{<!--MSDSplusに関する情報-->
      "isShow":true,
			"LANG":"<xsl:value-of select="//LANG"/>",<!--言語-->
			"KJE222":"<xsl:value-of select="//KJE222/PROPERTY_VALUE"/>",<!--文書GPID-->
			"KJE223":"<xsl:value-of select="//KJE223/PROPERTY_VALUE"/>",<!--文書種類-->
			"KJE224":"<xsl:value-of select="//KJE224/PROPERTY_VALUE"/>",<!--文書番号-->
			"KJE225":"<xsl:value-of select="//KJE225/PROPERTY_VALUE"/>",<!--フォーマット-->
			"KJE226":"<xsl:value-of select="//KJE226/PROPERTY_VALUE"/>",<!--提出日-->
			"KJE227":"<xsl:value-of select="//KJE227/PROPERTY_VALUE"/>",<!--作成日-->
			"KJE228":"<xsl:value-of select="//KJE228/PROPERTY_VALUE"/>",<!--改訂日-->
			"KJE229":"<xsl:value-of select="//KJE229/PROPERTY_VALUE"/>"<!--改訂履歴-->
    },
		"MS2":{<!--発行会社情報-->
      "isShow":true,
			"KJE230":"<xsl:value-of select="//KJE230/PROPERTY_VALUE"/>",<!--登録機関ID-->
			"KJE231":"<xsl:value-of select="//KJE231/PROPERTY_VALUE"/>",<!--会社ID-->
  		"KJE234":"<xsl:value-of select="//KJE234/PROPERTY_VALUE"/>",<!--JUMP ID-->
			<xsl:if test="$ver='3'">
				"KJE235":"<xsl:value-of select="//KJE235/PROPERTY_VALUE"/>",<!--会社名-->
			</xsl:if>
			<xsl:if test="$ver='4'">
				"KJE235":"<xsl:value-of select="//KJE235/PROPERTY_VALUE"/>",<!--会社名(英)-->
				"KJE297":"<xsl:value-of select="//KJE297/PROPERTY_VALUE"/>",<!--会社名(母)-->
			</xsl:if>
			"KJE236":"<xsl:value-of select="//KJE236/PROPERTY_VALUE"/>"<!--追加情報-->
    },
		"MS3":{<!--発行/作成 部門情報-->
      "isShow":true,
			"KJE237":"<xsl:value-of select="//KJE237/PROPERTY_VALUE"/>",<!--発行:部門名-->
			"KJE238":"<xsl:value-of select="//KJE238/PROPERTY_VALUE"/>",<!--発行:住所-->
			"KJE239":"<xsl:value-of select="//KJE239/PROPERTY_VALUE"/>",<!--発行:電話-->
			"KJE240":"<xsl:value-of select="//KJE240/PROPERTY_VALUE"/>",<!--発行:FAX-->
			"KJE241":"<xsl:value-of select="//KJE241/PROPERTY_VALUE"/>",<!--発行:E-Mail-->
			"KJE242":"<xsl:value-of select="//KJE242/PROPERTY_VALUE"/>",<!--作成:部門名-->
			"KJE243":"<xsl:value-of select="//KJE243/PROPERTY_VALUE"/>"<!--作成:電話-->
    },
		"MS4":{<!--依頼者情報-->
      "isShow":true,
			"KJE244":"<xsl:value-of select="//KJE244/PROPERTY_VALUE"/>",<!--登録機関ID-->
			"KJE245":"<xsl:value-of select="//KJE245/PROPERTY_VALUE"/>",<!--会社ID-->
			"KJE248":"<xsl:value-of select="//KJE248/PROPERTY_VALUE"/>",<!--JAMP ID-->
			"KJE249":"<xsl:value-of select="//KJE249/PROPERTY_VALUE"/>",<!--会社名-->
			"KJE256":"<xsl:value-of select="//KJE256/PROPERTY_VALUE"/>",<!--部門名-->
			"KJE257":"<xsl:value-of select="//KJE257/PROPERTY_VALUE"/>",<!--住所-->
			"KJE258":"<xsl:value-of select="//KJE258/PROPERTY_VALUE"/>",<!--担当者氏名-->
			"KJE259":"<xsl:value-of select="//KJE259/PROPERTY_VALUE"/>",<!--電話-->
			"KJE260":"<xsl:value-of select="//KJE260/PROPERTY_VALUE"/>",<!--FAX-->
			"KJE261":"<xsl:value-of select="//KJE261/PROPERTY_VALUE"/>",<!--E-Mail-->
			"KJE250":"<xsl:value-of select="//KJE250/PROPERTY_VALUE"/>",<!--備考1-->
			"KJE251":"<xsl:value-of select="//KJE251/PROPERTY_VALUE"/>",<!--備考2-->
			"KJE252":"<xsl:value-of select="//KJE252/PROPERTY_VALUE"/>"<!--備考3-->
    },
		"MS5":{<!--型番情報-->
      "isShow":true,
      "KJE253":[<!--依頼者-->
			  "<xsl:value-of select="//KJA040[1]/EDK040-001/KJE253/PROPERTY_VALUE"/>",
			  "<xsl:value-of select="//KJA040[2]/EDK040-001/KJE253/PROPERTY_VALUE"/>",
			  "<xsl:value-of select="//KJA040[3]/EDK040-001/KJE253/PROPERTY_VALUE"/>",
			  "<xsl:value-of select="//KJA040[4]/EDK040-001/KJE253/PROPERTY_VALUE"/>",
			  "<xsl:value-of select="//KJA040[5]/EDK040-001/KJE253/PROPERTY_VALUE"/>",
			  "<xsl:value-of select="//KJA040[6]/EDK040-001/KJE253/PROPERTY_VALUE"/>"
      ],
			"KJE254":[<!--発行者-->
				"<xsl:value-of select="//KJA040[1]/EDK040-001/KJE254/PROPERTY_VALUE"/>",
				"<xsl:value-of select="//KJA040[2]/EDK040-001/KJE254/PROPERTY_VALUE"/>",
				"<xsl:value-of select="//KJA040[3]/EDK040-001/KJE254/PROPERTY_VALUE"/>",
				"<xsl:value-of select="//KJA040[4]/EDK040-001/KJE254/PROPERTY_VALUE"/>",
				"<xsl:value-of select="//KJA040[5]/EDK040-001/KJE254/PROPERTY_VALUE"/>",
				"<xsl:value-of select="//KJA040[6]/EDK040-001/KJE254/PROPERTY_VALUE"/>"
      ]
    },
		"MS6":{<!--製品情報-->
      "isShow":true,
			"KJE265":"<xsl:value-of select="//KJE265/PROPERTY_VALUE"/>",<!--製品名-->
      <xsl:if test="$ver='3'">
        "KJE264":"<xsl:value-of select="//KJE264/PROPERTY_VALUE"/>",<!--製品番号-->
      </xsl:if>
      <xsl:if test="$ver='4'">
        "KJE264":"<xsl:value-of select="//KJE264/PROPERTY_VALUE"/>",<!--製品番号(英)-->
        "KJE298":"<xsl:value-of select="//KJE298/PROPERTY_VALUE"/>",<!--製品番号(母)-->
      </xsl:if>
      "KJE266":"<xsl:value-of select="//KJE266/PROPERTY_VALUE"/>",<!--一般商品名-->
      "KJE267":"<xsl:call-template name="getCoveredRow"><xsl:with-param name="id" select="string(//KJE267/PROPERTY_VALUE)"/></xsl:call-template>",<!--GADSL-->
      "KJE268":"<xsl:call-template name="getCoveredRow"><xsl:with-param name="id" select="string(//KJE268/PROPERTY_VALUE)"/></xsl:call-template>",<!--JIG-->
      "KJE269":"<xsl:call-template name="getCoveredRow"><xsl:with-param name="id" select="string(//KJE269/PROPERTY_VALUE)"/></xsl:call-template>",<!--PBT-->
      "KJE270":"<xsl:call-template name="getContained"><xsl:with-param name="id" select="string(//KJE270/PROPERTY_VALUE)"/></xsl:call-template>",<!--含有確認-->
      "KJE271":"<xsl:value-of select="//KJE271/PROPERTY_VALUE"/>"<!--物質リストVer.-->
    },
		"MS7":{<!--報告法令等の制定/改訂 番号-->
      "isShow":true,
      "data":[
			  <xsl:apply-templates select="//KJA041"/>
      ]
    }
  }
</xsl:template>
	
	<!-- ********************************** 報告法令 ************************************************************** -->
<xsl:template match="KJA041">
  {
    "ID":"<xsl:value-of select=".//KJE262/PROPERTY_VALUE"/>",
    "name":"<xsl:call-template name="getLawName"><xsl:with-param name="id" select="string(.//KJE262/PROPERTY_VALUE)"/></xsl:call-template>",<!--名称-->
    "rev":"<xsl:value-of select=".//KJE263/PROPERTY_VALUE"/>"<!--制定/改訂 番号-->
  }<xsl:if test="last()!=position()">,</xsl:if>
</xsl:template>

<!--
##########################################################################################
		対象法令	KJE178 KJE179 KJE267 KJE268 KJE269
##########################################################################################-->
<xsl:template name="getCoveredRow">
  <xsl:param name="id" />
  <xsl:if test="$id='0'">対象としない</xsl:if>
  <xsl:if test="$id='1'">対象とする</xsl:if>
</xsl:template>
<!--
##########################################################################################
		含有判定	KJE180 KJE270
##########################################################################################-->
<xsl:template name="getContained">
  <xsl:param name="id" />
  <xsl:if test="$id='0'">含有無し</xsl:if>
  <xsl:if test="$id='1'">含有あり</xsl:if>
</xsl:template>
<!--
##########################################################################################
		法令名取得関数
##########################################################################################-->
<xsl:template name="getLawName">
  <xsl:param name="id" />
  <xsl:if test="$id=''"></xsl:if>
  <xsl:if test="$id='EU01'">RoHS</xsl:if>
  <xsl:if test="$id='EU02'">ELV</xsl:if>
  <xsl:if test="$id='EU03'">CLP Annex VI CMR 1,2</xsl:if>
  <xsl:if test="$id='EU04'">REACH Annex XVII</xsl:if>
  <xsl:if test="$id='EU05'">SVHC</xsl:if>
  <xsl:if test="$id='EU06'">POPs Annex I</xsl:if>
  <xsl:if test="$id='IA00'">任意報告物質</xsl:if>
  <xsl:if test="$id='IA01'">GADSL</xsl:if>
  <xsl:if test="$id='IA02'">IEC62474/JIG</xsl:if>
  <xsl:if test="$id='JP01'">化審法(第一種特定化学物質)</xsl:if>
  <xsl:if test="$id='JP02'">安衛法(製造等禁止物質)</xsl:if>
  <xsl:if test="$id='JP03'">毒劇法(特定毒物)</xsl:if>
  <xsl:if test="$id='OT01'">ESIS PBT</xsl:if>
</xsl:template>

</xsl:stylesheet>