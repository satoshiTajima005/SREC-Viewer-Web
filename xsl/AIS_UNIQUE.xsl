<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" encoding="UTF-8" indent="no" omit-xml-declaration="no"/>
  <!-- *********************************************************************** AIS *********************************************************************** -->
  <xsl:template match="/">
    <xsl:variable name="ver" select="number(substring(//PROPERTY_SNAME[.='Use format']/following-sibling::node()/text(), 5, 1))"/>
    {
      "AIS1":{<!--AISに関する情報-->
        "LANG":"<xsl:value-of select="//LANG"/>",<!--言語-->
        "KJE134":"<xsl:value-of select="//KJE134/PROPERTY_VALUE"/>",<!--文書GPID-->
        "KJE135":"<xsl:value-of select="//KJE135/PROPERTY_VALUE"/>",<!--文書種類-->
        "KJE098":"<xsl:value-of select="//KJE098/PROPERTY_VALUE"/>",<!--文書番号-->
        "KJE136":"<xsl:value-of select="//KJE136/PROPERTY_VALUE"/>",<!--フォーマットVer.-->
        "KJE137":"<xsl:value-of select="//KJE137/PROPERTY_VALUE"/>",<!--提出日-->
        "KJE016":"<xsl:value-of select="//KJE016/PROPERTY_VALUE"/>",<!--作成日-->
        "KJE017":"<xsl:value-of select="//KJE017/PROPERTY_VALUE"/>",<!--改訂日-->
        "KJE014":"<xsl:value-of select="//KJE014/PROPERTY_VALUE"/>"<!--改訂履歴-->
      },
      "AIS2":{<!--発行会社情報-->
        "KJE138":"<xsl:value-of select="//KJE138/PROPERTY_VALUE"/>",<!--登録機関ID-->
        "KJE011":"<xsl:value-of select="//KJE011/PROPERTY_VALUE"/>",<!--会社ID-->
        "KJE141":"<xsl:value-of select="//KJE141/PROPERTY_VALUE"/>",<!--JAMP ID-->
      <xsl:if test="$ver='3'">
        "KJE012":"<xsl:value-of select="//KJE012/PROPERTY_VALUE"/>",<!--会社名 -->
      </xsl:if>
      <xsl:if test="$ver='4'">
        "KJE012":"<xsl:value-of select="//KJE012/PROPERTY_VALUE"/>",<!--会社名(英)-->
        "KJE297":"<xsl:value-of select="//KJE297/PROPERTY_VALUE"/>",<!--会社名(母)-->
      </xsl:if>
        "KJE142":"<xsl:value-of select="//KJE142/PROPERTY_VALUE"/>"<!--追加情報-->
      },
      "AIS3":{<!--発行/作成 部門情報-->
        "KJE143":"<xsl:value-of select="//KJE143/PROPERTY_VALUE"/>",<!--発行:部門名-->
        "KJE144":"<xsl:value-of select="//KJE144/PROPERTY_VALUE"/>",<!--発行:住所-->
        "KJE145":"<xsl:value-of select="//KJE145/PROPERTY_VALUE"/>",<!--発行:電話-->
        "KJE146":"<xsl:value-of select="//KJE146/PROPERTY_VALUE"/>",<!--発行:FAX-->
        "KJE147":"<xsl:value-of select="//KJE147/PROPERTY_VALUE"/>",<!--発行:E-Mail-->
        "KJE093":"<xsl:value-of select="//KJE093/PROPERTY_VALUE"/>",<!--作成:部門名-->
        "KJE124":"<xsl:value-of select="//KJE124/PROPERTY_VALUE"/>"<!--作成:電話-->
      },
      "AIS4":{<!--依頼者情報-->
        "KJE149":"<xsl:value-of select="//KJE149/PROPERTY_VALUE"/>",<!--登録機関ID-->
        "KJE150":"<xsl:value-of select="//KJE150/PROPERTY_VALUE"/>",<!--会社ID-->
        "KJE153":"<xsl:value-of select="//KJE153/PROPERTY_VALUE"/>",<!--JAMP ID-->
        "KJE078":"<xsl:value-of select="//KJE078/PROPERTY_VALUE"/>",<!--会社名-->
        "KJE154":"<xsl:value-of select="//KJE154/PROPERTY_VALUE"/>",<!--部門名-->
        "KJE155":"<xsl:value-of select="//KJE155/PROPERTY_VALUE"/>",<!--住所-->
        "KJE090":"<xsl:value-of select="//KJE090/PROPERTY_VALUE"/>",<!--担当者氏名-->
        "KJE156":"<xsl:value-of select="//KJE156/PROPERTY_VALUE"/>",<!--電話-->
        "KJE157":"<xsl:value-of select="//KJE157/PROPERTY_VALUE"/>",<!--FAX-->
        "KJE091":"<xsl:value-of select="//KJE091/PROPERTY_VALUE"/>",<!--E-Mail-->
        "KJE158":"<xsl:value-of select="//KJE158/PROPERTY_VALUE"/>",<!--備考 1-->
        "KJE159":"<xsl:value-of select="//KJE159/PROPERTY_VALUE"/>",<!--備考 2-->
        "KJE160":"<xsl:value-of select="//KJE160/PROPERTY_VALUE"/>"<!--備考 3-->
      },
      "AIS5":{<!--型番情報-->
        "KJE079":[<!--依頼者-->
          "<xsl:value-of select="//KJA022[1]/EDK022-001/KJE079/PROPERTY_VALUE"/>",
          "<xsl:value-of select="//KJA022[2]/EDK022-001/KJE079/PROPERTY_VALUE"/>",
          "<xsl:value-of select="//KJA022[3]/EDK022-001/KJE079/PROPERTY_VALUE"/>",
          "<xsl:value-of select="//KJA022[4]/EDK022-001/KJE079/PROPERTY_VALUE"/>",
          "<xsl:value-of select="//KJA022[5]/EDK022-001/KJE079/PROPERTY_VALUE"/>",
          "<xsl:value-of select="//KJA022[6]/EDK022-001/KJE079/PROPERTY_VALUE"/>"
        ],
        "KJE164":[<!--発行者-->
          "<xsl:value-of select="//KJA022[1]/EDK022-001/KJE164/PROPERTY_VALUE"/>",
          "<xsl:value-of select="//KJA022[2]/EDK022-001/KJE164/PROPERTY_VALUE"/>",
          "<xsl:value-of select="//KJA022[3]/EDK022-001/KJE164/PROPERTY_VALUE"/>",
          "<xsl:value-of select="//KJA022[4]/EDK022-001/KJE164/PROPERTY_VALUE"/>",
          "<xsl:value-of select="//KJA022[5]/EDK022-001/KJE164/PROPERTY_VALUE"/>",
          "<xsl:value-of select="//KJA022[6]/EDK022-001/KJE164/PROPERTY_VALUE"/>"
        ]
      },
      "AIS6":{<!--成型品情報-->
        "KJE101":"<xsl:value-of select="//KJE101/PROPERTY_VALUE"/>",<!--製造会社-->
        <xsl:if test="$ver='3'">
          "KJE018":"<xsl:value-of select="//KJE018/PROPERTY_VALUE"/>",<!--発行者型番-->
        </xsl:if>
        <xsl:if test="$ver='4'">
          "KJE018":"<xsl:value-of select="//KJE018/PROPERTY_VALUE"/>",<!--発行者型番(英)-->
          "KJE298":"<xsl:value-of select="//KJE298/PROPERTY_VALUE"/>",<!--発行者型番(母)-->
        </xsl:if>
        "KJE172":"<xsl:value-of select="//KJE172/PROPERTY_VALUE"/>",<!--一般商品名-->
        "KJE173":"<xsl:value-of select="//KJE173/PROPERTY_VALUE"/>",<!--シリーズ名-->
        "KJE174":"<xsl:value-of select="//KJE174/PROPERTY_VALUE"/>",<!--発行者備考-->
        "KJE183":"<xsl:value-of select="//KJE183/PROPERTY_VALUE"/>",<!--引用等-->
        "KJE176":"<xsl:value-of select="string(//KJE176/PROPERTY_VALUE)"/>",<!--集合化-->
        "KJE177":"<xsl:value-of select="string(//KJE177/PROPERTY_VALUE)"/>",<!--単位-->
        "KJE023":"<xsl:value-of select="concat(//KJE023/PROPERTY_VALUE, //KJE023/PROPERTY_VALUE/@prefix, 'g')"/>",<!--質量-->
        "KJE178":"<xsl:value-of select="string(//KJE178/PROPERTY_VALUE)"/>",<!--GADSL-->
        "KJE179":"<xsl:value-of select="string(//KJE179/PROPERTY_VALUE)"/>",<!--JIG-->
        "KJE180":"<xsl:value-of select="string(//KJE180/PROPERTY_VALUE)"/>",<!--含有確認-->
        "KJE181":"<xsl:value-of select="//KJE181/PROPERTY_VALUE"/>",<!--材質リストVer.-->
        "KJE182":"<xsl:value-of select="//KJE182/PROPERTY_VALUE"/>"<!--物質リストVer.-->
      },
      "AIS7":[<!--集計情報-->
        <xsl:apply-templates select="//KJA024" />
      ]
    }
  </xsl:template>

  <!-- ****************************************集計情報部***************************************************** -->
  <xsl:template match="KJA024">
    {
      "name":"<xsl:value-of select="string(.//KJE167/PROPERTY_VALUE)"/>",<!--名称-->
      "div":"<xsl:value-of select=".//KJE167/PROPERTY_VALUE"/>",<!--分類記号-->
      "weight":"<xsl:value-of select="concat(.//KJE168/PROPERTY_VALUE, .//KJE168/PROPERTY_VALUE/@prefix, 'g')"/>"<!--質量-->
    }<xsl:if test="last()!=position()">,</xsl:if>
  </xsl:template>
<!--
  <xsl:include href="xsl/function.xsl"/>
  <xsl:include href="xsl/dicJAMP.xsl"/>
-->
</xsl:stylesheet>