<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="no" omit-xml-declaration="no"/>
  <!-- *********************************************************************** AIS *********************************************************************** -->
  <xsl:template match="/">
    <xsl:variable name="ver" select="number(substring(//PROPERTY_SNAME[.='Use format']/following-sibling::node()/text(), 5, 1))"/>
    {
      "AIS1":{<!--AISに関する情報-->
        "isShow": true,
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
        "isShow": true,
        "KJE138":"<xsl:value-of select="//KJE138/PROPERTY_VALUE"/>",<!--登録機関ID-->
        "KJE011":"<xsl:value-of select="//KJE011/PROPERTY_VALUE"/>",<!--会社ID-->
        "KJE141":"<xsl:value-of select="//KJE141/PROPERTY_VALUE"/>",<!--JAMP ID-->
        "KJE012":"<xsl:value-of select="//KJE012/PROPERTY_VALUE"/>",<!--会社名 -->
        <xsl:if test="$ver='4'">"KJE297":"<xsl:value-of select="//KJE297/PROPERTY_VALUE"/>",<!--会社名(母)--></xsl:if>
        "KJE142":"<xsl:value-of select="//KJE142/PROPERTY_VALUE"/>"<!--追加情報-->
      },
      "AIS3":{<!--発行/作成 部門情報-->
        "isShow": true,
        "KJE143":"<xsl:value-of select="//KJE143/PROPERTY_VALUE"/>",<!--発行:部門名-->
        "KJE144":"<xsl:value-of select="//KJE144/PROPERTY_VALUE"/>",<!--発行:住所-->
        "KJE145":"<xsl:value-of select="//KJE145/PROPERTY_VALUE"/>",<!--発行:電話-->
        "KJE146":"<xsl:value-of select="//KJE146/PROPERTY_VALUE"/>",<!--発行:FAX-->
        "KJE147":"<xsl:value-of select="//KJE147/PROPERTY_VALUE"/>",<!--発行:E-Mail-->
        "KJE093":"<xsl:value-of select="//KJE093/PROPERTY_VALUE"/>",<!--作成:部門名-->
        "KJE124":"<xsl:value-of select="//KJE124/PROPERTY_VALUE"/>"<!--作成:電話-->
      },
      "AIS4":{<!--依頼者情報-->
        "isShow": true,
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
        "isShow": true,
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
        "isShow": true,
        "KJE101":"<xsl:value-of select="//KJE101/PROPERTY_VALUE"/>",<!--製造会社-->
        "KJE018":"<xsl:value-of select="//KJE018/PROPERTY_VALUE"/>",<!--発行者型番-->
        <xsl:if test="$ver='4'">
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
      "AIS7":{<!--集計情報-->
        "isShow": true,
        "data":[<xsl:apply-templates select="//KJA024" />]
      }
    }
  </xsl:template>

  <!-- ****************************************集計情報部***************************************************** -->
  <xsl:template match="KJA024">
    {
      "name":"<xsl:call-template name="getMatCLass"><xsl:with-param name="id" select="string(.//KJE167/PROPERTY_VALUE)"/></xsl:call-template>",<!--名称-->
      "div":"<xsl:value-of select=".//KJE167/PROPERTY_VALUE"/>",<!--分類記号-->
      "weight":"<xsl:value-of select="concat(.//KJE168/PROPERTY_VALUE, .//KJE168/PROPERTY_VALUE/@prefix, 'g')"/>"<!--質量-->
    }<xsl:if test="last()!=position()">,</xsl:if>
  </xsl:template>

<!--
##########################################################################################
		材質区分取得関数
##########################################################################################-->
	<xsl:template name="getMatCLass">
		<xsl:param name="id" />
    <xsl:if test="$id='R111'">高合金鋼</xsl:if>
    <xsl:if test="$id='R112'">高合金鋳鉄</xsl:if>
    <xsl:if test="$id='R101'">鉄鋼/鋳鋼/焼結合金</xsl:if>
    <xsl:if test="$id='R102'">非合金、低合金鋼</xsl:if>
    <xsl:if test="$id='R103'">鋳鉄</xsl:if>
    <xsl:if test="$id='R104'">片状黒鉛鋳鉄/可鍛鋳鉄</xsl:if>
    <xsl:if test="$id='R105'">球状黒鉛鋳鉄/バーミキュラー鋳鉄</xsl:if>
    <xsl:if test="$id='R211'">鋳造アルミニウム合金</xsl:if>
    <xsl:if test="$id='R212'">鍛造アルミニウム合金</xsl:if>
    <xsl:if test="$id='R221'">鋳造マグネシウム合金</xsl:if>
    <xsl:if test="$id='R222'">鍛造マグネシウム合金</xsl:if>
    <xsl:if test="$id='R311'">銅(例,ケーブルハーネスの銅)</xsl:if>
    <xsl:if test="$id='R312'">銅合金</xsl:if>
    <xsl:if test="$id='R330'">亜鉛合金</xsl:if>
    <xsl:if test="$id='R340'">ニッケル合金</xsl:if>
    <xsl:if test="$id='R350'">鉛、鉛合金</xsl:if>
    <xsl:if test="$id='R351'">含鉛はんだ</xsl:if>
    <xsl:if test="$id='R361'">非鉛はんだ</xsl:if>
    <xsl:if test="$id='V421'">特殊金属(金)</xsl:if>
    <xsl:if test="$id='V411'">特殊金属(白金、ロジウム)</xsl:if>
    <xsl:if test="$id='V412'">その他の特殊金属(銀、パラジウム等)</xsl:if>
    <xsl:if test="$id='P398'">チタン、チタン合金</xsl:if>
    <xsl:if test="$id='P399'">その他の非鉄金属</xsl:if>
    <xsl:if test="$id='N720'">セラミック</xsl:if>
    <xsl:if test="$id='N721'">ガラス</xsl:if>
    <xsl:if test="$id='N498'">その他無機化合物</xsl:if>
    <xsl:if test="$id='N499'">フィラー(充填材)を含有する熱可塑性樹脂</xsl:if>
    <xsl:if test="$id='P511'">PE</xsl:if>
    <xsl:if test="$id='P512'">PP</xsl:if>
    <xsl:if test="$id='P513'">PS</xsl:if>
    <xsl:if test="$id='P514'">PVC</xsl:if>
    <xsl:if test="$id='P515'">PC</xsl:if>
    <xsl:if test="$id='P516'">POM</xsl:if>
    <xsl:if test="$id='P517'">A(B)S</xsl:if>
    <xsl:if test="$id='P518'">PA</xsl:if>
    <xsl:if test="$id='P519'">PET</xsl:if>
    <xsl:if test="$id='P520'">PPE</xsl:if>
    <xsl:if test="$id='P528'">熱可塑性エラストマ</xsl:if>
    <xsl:if test="$id='P529'">その他の熱可塑性樹脂</xsl:if>
    <xsl:if test="$id='N541'">ポリウレタン</xsl:if>
    <xsl:if test="$id='N542'">不飽和ポリエステル</xsl:if>
    <xsl:if test="$id='N551'">エポキシ樹脂</xsl:if>
    <xsl:if test="$id='N543'">その他の硬化性樹脂</xsl:if>
    <xsl:if test="$id='N544'">(熱可塑でない)エラストマー/エラストマー複合</xsl:if>
    <xsl:if test="$id='N545'">高分子複合材</xsl:if>
    <xsl:if test="$id='N546'">高分子複合材に含まれる樹脂</xsl:if>
    <xsl:if test="$id='N547'">高分子複合材に含まれる繊維</xsl:if>
    <xsl:if test="$id='N711'">木材</xsl:if>
    <xsl:if test="$id='N712'">紙</xsl:if>
    <xsl:if test="$id='N713'">繊維</xsl:if>
    <xsl:if test="$id='N714'">皮革</xsl:if>
    <xsl:if test="$id='N950'">冷媒</xsl:if>
    <xsl:if test="$id='N900'">潤滑剤、ブレーキフルード、他</xsl:if>
    <xsl:if test="$id='N999'">その他材料(粉体ほか)</xsl:if>
    <xsl:if test="$id='S001'">亜鉛めっき</xsl:if>
    <xsl:if test="$id='S002'">ニッケルめっき</xsl:if>
    <xsl:if test="$id='S003'">アルミニウムめっき</xsl:if>
    <xsl:if test="$id='S004'">銅めっき</xsl:if>
    <xsl:if test="$id='S005'">スズめっき</xsl:if>
    <xsl:if test="$id='S006'">クロムめっき</xsl:if>
    <xsl:if test="$id='S007'">コバルトめっき</xsl:if>
    <xsl:if test="$id='S008'">金めっき</xsl:if>
    <xsl:if test="$id='S009'">白金めっき</xsl:if>
    <xsl:if test="$id='S010'">パラジウムめっき</xsl:if>
    <xsl:if test="$id='S011'">ロジウムめっき</xsl:if>
    <xsl:if test="$id='S012'">銀めっき</xsl:if>
    <xsl:if test="$id='S013'">カドミウムめっき</xsl:if>
    <xsl:if test="$id='S101'">亜鉛溶射</xsl:if>
    <xsl:if test="$id='S102'">アルミニウム溶射</xsl:if>
    <xsl:if test="$id='S103'">肉盛溶射</xsl:if>
    <xsl:if test="$id='S104'">コバルト自溶合金溶射</xsl:if>
    <xsl:if test="$id='S105'">タングステンカーバイト自溶合金溶射</xsl:if>
    <xsl:if test="$id='S106'">酸化アルミニウム溶射</xsl:if>
    <xsl:if test="$id='S107'">酸化クロム溶射</xsl:if>
    <xsl:if test="$id='S108'">スピネル溶射</xsl:if>
    <xsl:if test="$id='S109'">酸化ジルコニウム溶射</xsl:if>
    <xsl:if test="$id='S110'">炭化タングステン・コバルト溶射</xsl:if>
    <xsl:if test="$id='S111'">炭化クロム・ニッケル溶射</xsl:if>
    <xsl:if test="$id='S201'">クロメート被膜・6価クロム処理</xsl:if>
    <xsl:if test="$id='S202'">3価クロメート処理</xsl:if>
    <xsl:if test="$id='S203'">クロムフリー処理</xsl:if>
    <xsl:if test="$id='S204'">ジオメット処理(ノンクロム)処理</xsl:if>
    <xsl:if test="$id='S205'">シュウ酸ボンデ処理</xsl:if>
    <xsl:if test="$id='S206'">ZAY コート処理</xsl:if>
    <xsl:if test="$id='S207'">アルマイト処理</xsl:if>
    <xsl:if test="$id='S208'">アルマイト塗装処理</xsl:if>
    <xsl:if test="$id='S209'">マグネシウム防食処理</xsl:if>
    <xsl:if test="$id='S210'">アルミニウム防食処理 </xsl:if>
    <xsl:if test="$id='S211'">黒染め(四三酸化鉄)処理</xsl:if>
    <xsl:if test="$id='S212'">リン酸処理</xsl:if>
    <xsl:if test="$id='S301'">CrN コーティング</xsl:if>
    <xsl:if test="$id='S302'">DLC コーティング</xsl:if>
    <xsl:if test="$id='S303'">TiN コーティング</xsl:if>
    <xsl:if test="$id='S304'">金蒸着(スパッタを含む)</xsl:if>
    <xsl:if test="$id='S305'">金以外の貴金属・希少金属蒸着(スパッタを含む)</xsl:if>
    <xsl:if test="$id='S306'">その他無機化合物のコーティング</xsl:if>
    <xsl:if test="$id='S401'">塗膜樹脂</xsl:if>
    <xsl:if test="$id='S402'">ダクロ処理</xsl:if>
    <xsl:if test="$id='S403'">コーティング(セラミックス)</xsl:if>
    <xsl:if test="$id='S404'">コーティング(ガラス)</xsl:if>
    <xsl:if test="$id='S405'">コーティング(他の複合材)</xsl:if>
  </xsl:template>

</xsl:stylesheet>