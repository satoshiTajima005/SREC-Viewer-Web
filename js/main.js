let list = {
  name: "", //ファイル名
  id: 0, //読み込んだファイル数のインクリメント
  type: "", //AIS, AIS-temp, MSDSplus, MSDSplus-temp, IEC62474, SHAI, SHCI, JAMA, JGP4
  txt: "", //読み込んだ生のテキストデータ
  detail: "", //詳細表示のパターン[tree, table, itemNo]
  data: {//JSON変換したデータ
    unique:{},
    table:{},
    tree:{},
    item:{}
  } 
}

Vue.config.productionTip = true;
let app;
let id = 0; //ファイルID

document.addEventListener('DOMContentLoaded', function () {
  app = new Vue({
    el: "#app",
    data: {
      langType: 'ja',
      language: lang.ja,
      tabLeft: {
        selected: 0,
        list: []
      },
      tabRight: {
        selected: 0,
        list: []
      }
    },
    methods: {
      openFile: async function (e) {
        let me = this;

        if (!(window.File && window.FileReader && window.FileList && window.Blob)) return;
        let files = [];
        //FileListを配列化
        for (let i = 0; i < e.target.files.length; i++) files.push(e.target.files[i]);

        //ファイルのテキスト読み取り
        let tabObject = [];
        await Promise.all(files.map(function (file) {
          return me.getFileArr(file, tabObject);
        }));

        //エラーを削除
        //ファイルテキストをオブジェクト化
        await Promise.all(tabObject.map(async function (o, index) {
          switch (o.type) {
            case 'extErr':
            case 'zipErr':
            case 'xmlTypeErr':
              //todo エラーなので配列から削除
              //todo 画面に何かしらの表示
              break;
            case 'AIS':
            case 'AIS-temp':
              o.data = {
                unique: {},
                tree: {},
                table: {}
              };
              o.data.unique = await me.xmlTransform(o.txt, 'xsl/AIS_UNIQUE.xsl');
              o.data.tree = await me.xmlTransform(o.txt, 'xsl/AIS_TREE.xsl');
              o.data.table = await me.xmlTransform(o.txt, 'xsl/AIS_TABLE.xsl');
              break;
            case 'MSDSplus':
            case 'MSDSplus-temp':
                o.data = {
                  unique: {},
                  //table: {}
                };
                o.data.unique = await me.xmlTransform(o.txt, 'xsl/MSDSplus_UNIQUE.xsl');
                //o.data.table = await me.xmlTransform(o.txt, 'xsl/MSDSplus_TABLE.xsl');
                break;
            case 'IEC62474':
            case 'SHAI':
            case 'SHCI':
              break;
            case 'JAMA':
            case 'JGP4':
              o.data = o.txt;
              break;
          }
        }));

        //dataをJSON.parse
        tabObject.map(o =>{
          try {
            if (o.data.unique) o.data.unique = JSON.parse(o.data.unique);
            if (o.data.tree) o.data.tree = JSON.parse(o.data.tree);
            if (o.data.table) o.data.table = JSON.parse(o.data.table);
            if (o.data.item) o.data.item = JSON.parse(o.data.item);
          }catch(e){
            console.log('JSON parse error');
            console.log(o.data);
          }
        });
        //変換後の配列をタブリストに投入
        this.tabLeft.list = this.tabLeft.list.concat(tabObject);
      },
      getFileArr: async function (file, o) {
        //ファイルタイプの判定
        let f = [], type = '', detail = '';
        switch (file.name.slice(-4).toUpperCase()) {
          case '.XML': //AIS・MSDSplus・IEC62474判定
            f = await this.readFile(file);
            type = 'XML';
            break;
          case '.CSV': //文字コード
            f = await this.readFile(file, 'shift_jis');
            type = 'JAMA';
            detail = 'tree';
            break;
          case 'JGP4': //文字コード
            f = await this.readFile(file, 'shift_jis');
            type = 'JGP4';
            detail = 'item';
            break;
          case 'SHAI': //ZIP
            f = await this.readFile(file, null, true);
            type = 'SHAI';
            detail = 'tree';
            break;
          case 'SHCI': //ZIP
            f = await this.readFile(file, null, true);
            type = 'SHCI';
            detail = 'tree';
            break;
          default:
            //拡張子エラー
            o.push({
              result: false,
              type: 'extErr',
              name: file.name
            });
            return;
        }
        if (f === 'zipErr') {
          //ZIP解凍エラー
          o.push({
            result: false,
            type: 'zipErr',
            name: file.name
          });
          return;
        }
        f.map(function (fres) {
          if (type === 'XML') {
            switch (true) {
              case (/MSDSplus-temp/.test(fres)):
                type = 'MSDSplus-temp';
                detail = 'table';
                break;
              case (/AIS-temp/.test(fres)):
                type = 'AIS-temp';
                detail = 'table';
                break;
              case (/MSDSplus/.test(fres)):
                type = 'MSDSplus';
                detail = 'table';
                break;
              case (/AIS/.test(fres)):
                type = 'AIS';
                detail = 'table';
                break;
              case (/chemSHERPA-A/.test(fres)):
                type = 'SHAI';
                detail = 'tree';
                break;
              case (/chemSHERPA-C/.test(fres)):
                type = 'SHCI';
                detail = 'tree';
                break;
              case (/IEC62474/.test(fres)):
                type = 'IEC62474';
                detail = 'tree';
                break;
              default:
                o.push({
                  result: false,
                  type: 'xmlTypeErr',
                  name: file.name
                });
                return;
            }
          }
          id++;
          o.push({
            result: true,
            id: id,
            type: type,
            name: file.name,
            txt: fres,
            detail: detail
          });
        });
        return;
      },
      readFile: async function (file, encode, isZip) {
        const me = this;
        const awaitForLoad = function (target) {
          return new Promise(function (resolve) {
            let listener = resolve;
            target.addEventListener("loadend", listener, {
              once: true
            });
          });
        };
        let reader = new FileReader();
        encode = encode ? encode : 'utf8';
        if (isZip) {
          try {
            reader.readAsArrayBuffer(file);
            let res = await awaitForLoad(reader);
            let zipArr = new Uint8Array(res.target.result);
            let unzip = new Zlib.Unzip(zipArr);
            let res2 = [];
            unzip.getFilenames().map(function (zipf) {
              let utf8arr = unzip.decompress(zipf);
              res2.push(me.Utf8ArrayToStr(utf8arr));
            });
            return res2; //配列戻し
          } catch (e) {
            console.log(e);
            return 'zipErr';
          }
        } else {
          reader.readAsText(file, encode);
          let res = await awaitForLoad(reader);
          return [res.target.result]; //ZIPが配列で戻すので合わせる
        }
      },
      Utf8ArrayToStr: function (b) {
        var a;
        var c = "";
        var f = b.length;
        for (a = 0; a < f;) {
          var d = b[a++];
          switch (d >> 4) {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
              c += String.fromCharCode(d);
              break;
            case 12:
            case 13:
              var e = b[a++];
              c += String.fromCharCode((d & 31) << 6 | e & 63);
              break;
            case 14:
              e = b[a++];
              var g = b[a++];
              c += String.fromCharCode((d & 15) << 12 | (e & 63) << 6 | (g & 63) << 0)
          }
        }
        return c
      },
      xmlTransform: async function (xmlStr, xslPath) {
        if (xmlStr.charCodeAt(0) === 0xFEFF) xmlStr = xmlStr.slice(1); //BOM削除
        xmlStr = xmlStr.replace(/<DESCRIPT(.|\s)*?>/im, "<DESCRIPT>") //名前空間除去
        let xml = this.parseXML(xmlStr);
        let xsl = await this.xhrLoad(xslPath, true); //xslロード
        let xslp = new XSLTProcessor();
        xslp.importStylesheet(xsl);
        let o = xslp.transformToFragment(xml, document);
        let res = o.textContent;
        
        //XSLT変換不足対応
        res = res.replace(/\n\s*/igm,'');
        if (xslPath == 'xsl/AIS_TABLE.xsl'){
          res = res
            .replace(/\#\[/g, '],[')
            .replace(/\@\[/, '[')
            .replace(/\}\{/g, '},{');
        }
        return res;
      },
      xhrLoad: async function (url, isXML) {
        const response = await fetch(url);
        const res = await response.text();
        return isXML ? this.parseXML(res) : res;
      },
      xmlToJson: function (xml) {
        var obj = {};
        if (xml.nodeType == 1) { // element
          // do attributes
          if (xml.attributes.length > 0) {
            obj["@attributes"] = {};
            for (var j = 0; j < xml.attributes.length; j++) {
              var attribute = xml.attributes.item(j);
              obj["@attributes"][attribute.nodeName] = attribute.nodeValue;
            }
          }
        } else if (xml.nodeType == 3) { // text
          obj = xml.nodeValue;
        }
        // do children
        if (xml.hasChildNodes()) {
          for (var i = 0; i < xml.childNodes.length; i++) {
            var item = xml.childNodes.item(i);
            var nodeName = item.nodeName;
            if (typeof (obj[nodeName]) == "undefined") {
              obj[nodeName] = this.xmlToJson(item);
            } else {
              if (typeof (obj[nodeName].push) == "undefined") {
                var old = obj[nodeName];
                obj[nodeName] = [];
                obj[nodeName].push(old);
              }
              obj[nodeName].push(this.xmlToJson(item));
            }
          }
        }
        return obj;
      },
      parseXML: function (xmlStr) {
        return new DOMParser().parseFromString(xmlStr, "text/xml")
      },
    }
  });
});