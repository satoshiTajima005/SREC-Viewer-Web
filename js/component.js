Vue.component('tabs', {
  props: ['target', 'moveto', 'language'],
  template: `
    <div class="column">
      <div class="tabs is-boxed">
        <ul style="overflow:hidden;">
          <li v-for="(item, index) in tabObject.list" :key="item.id" :class="{'is-active': tabObject.selected === index}" @click="clickTab(tabObject, index)">
            <a :title="item.name">
              <span class="tabname">{{item.name}}</span>
              <span class="icon movetab" :title="language.movetab" @click="moveTab(tabObject, item, index, moveto.list)">
                <i class="fas fa-file-export"></i>
              </span>
              <button class="delete is-small" aria-label="close" :title="language.delete" @click="deleteTab(tabObject, index)"></button>
            </a>
          </li>
        </ul>
      </div>
      <div class="preview tabbody">
        <ais
          v-if="/AIS/.test(tabObject.list[tabObject.selected].type)"
          ref="ais"
          :detail="tabObject.list[tabObject.selected].detail"
          :unique="tabObject.list[tabObject.selected].data.unique"
          :table="tabObject.list[tabObject.selected].data.table"
          :tree="tabObject.list[tabObject.selected].data.tree">
        </ais>
      </div>
    </div>
  `,
  data: function(){
    return {
      tabObject: this.target
    }
  },
  methods: {
    clickTab: function(target, index){
      target.selected = index;
      if (this.$refs.ais) this.$refs.ais.changeView('table');
    },
    deleteTab: function(target, index){
      target.list.splice( index, 1 );
    },
    moveTab: function(target, item, index, moveTo){
      target.selected = 0;
      moveTo.push(Object.create(item));
      this.deleteTab(target, index);
    }
  }
});
Vue.component('UniqueTr', {
  props: ['title', 'value'],
  template: `<tr><th :style="/^[1-6]$/.test(title)?'width:50px;text-arign:center;':''">{{title}}</th><td>{{value}}</td></tr>`
});
Vue.component('AisUnique', {
  props: { target:{ type: Object } },
  template: `
    <div class="unique">

      <div class="AIS1 message is-green">
        <div class="message-header" @click="toggleDetail('AIS1')">
          <p>AISに関する情報</p>
          <span class="icon" v-if="!target.AIS1.isShow"><i class="fas fa-caret-right"></i></span>
          <span class="icon" v-if="target.AIS1.isShow"><i class="fas fa-caret-down"></i></span>
        </div>
        <transition name="fade">
          <div class="message-body columns" v-show="target.AIS1.isShow">
            <div class="column">
              <table class="unique-table table is-bordered is-narrow">
                <tbody>
                  <unique-tr title="言語" :value="target.AIS1.LANG"></unique-tr>
                  <unique-tr title="文書GPID" :value="target.AIS1.KJE134"></unique-tr>
                  <unique-tr title="文書種類" :value="target.AIS1.KJE135"></unique-tr>
                  <unique-tr title="文書番号" :value="target.AIS1.KJE098"></unique-tr>
                  <unique-tr title="フォーマット" :value="target.AIS1.KJE136"></unique-tr>
                </tbody>
              </table>
            </div>
            <div class="column">
              <table class="unique-table table is-bordered is-narrow">
                <tbody>
                  <unique-tr title="提出日" :value="target.AIS1.KJE137"></unique-tr>
                  <unique-tr title="作成日" :value="target.AIS1.KJE016"></unique-tr>
                  <unique-tr title="改訂日" :value="target.AIS1.KJE017"></unique-tr>
                  <unique-tr title="改訂履歴" :value="target.AIS1.KJE014"></unique-tr>
                </tbody>
              </table>
            </div>
          </div>
        </transition>
      </div>
      
      <div class="AIS2 message is-green">
        <div class="message-header" @click="toggleDetail('AIS2')">
          <p>発行会社情報</p>
          <span class="icon" v-if="!target.AIS2.isShow"><i class="fas fa-caret-right"></i></span>
          <span class="icon" v-if="target.AIS2.isShow"><i class="fas fa-caret-down"></i></span>
        </div>
        <transition name="fade">
          <div class="message-body columns" v-show="target.AIS2.isShow">
            <div class="column">
              <table class="unique-table table is-bordered is-narrow">
                <tbody>
                  <unique-tr title="登録機関ID" :value="target.AIS2.KJE138"></unique-tr>
                  <unique-tr title="会社ID" :value="target.AIS2.KJE011"></unique-tr>
                  <unique-tr title="JAMP ID" :value="target.AIS2.KJE141"></unique-tr>
                </tbody>
              </table>
            </div>
            <div class="column">
              <table class="unique-table table is-bordered is-narrow">
                <tbody>
                  <unique-tr title="会社名" :value="target.AIS2.KJE012"></unique-tr>
                  <unique-tr title="会社名(母)" :value="target.AIS2.KJE297"></unique-tr>
                  <unique-tr title="追加情報" :value="target.AIS2.KJE142"></unique-tr>
                </tbody>
              </table>
            </div>
          </div>
        </transition>
      </div>

      <div class="AIS3 message is-green">
        <div class="message-header" @click="toggleDetail('AIS3')">
          <p>発行/作成 部門情報</p>
          <span class="icon" v-if="!target.AIS3.isShow"><i class="fas fa-caret-right"></i></span>
          <span class="icon" v-if="target.AIS3.isShow"><i class="fas fa-caret-down"></i></span>
        </div>
        <transition name="fade">
          <div class="message-body columns" v-show="target.AIS3.isShow">
            <div class="column">
              <table class="unique-table table is-bordered is-narrow">
                <tbody>
                  <unique-tr title="発行:部門名" :value="target.AIS3.KJE143"></unique-tr>
                  <unique-tr title="発行:住所" :value="target.AIS3.KJE144"></unique-tr>
                  <unique-tr title="発行:電話" :value="target.AIS3.KJE145"></unique-tr>
                  <unique-tr title="発行:FAX" :value="target.AIS3.KJE146"></unique-tr>
                </tbody>
              </table>
            </div>
            <div class="column">
              <table class="unique-table table is-bordered is-narrow">
                <tbody>
                  <unique-tr title="発行:E-Mail" :value="target.AIS3.KJE147"></unique-tr>
                  <unique-tr title="作成:部門名" :value="target.AIS3.KJE093"></unique-tr>
                  <unique-tr title="作成:電話" :value="target.AIS3.KJE124"></unique-tr>
                </tbody>
              </table>
            </div>
          </div>
        </transition>
      </div>

      <div class="AIS4 message is-green">
        <div class="message-header" @click="toggleDetail('AIS4')">
          <p>依頼者情報</p>
          <span class="icon" v-if="!target.AIS4.isShow"><i class="fas fa-caret-right"></i></span>
          <span class="icon" v-if="target.AIS4.isShow"><i class="fas fa-caret-down"></i></span>
        </div>
        <transition name="fade">
          <div class="message-body columns" v-show="target.AIS4.isShow">
            <div class="column">
              <table class="unique-table table is-bordered is-narrow">
                <tbody>
                  <unique-tr title="登録機関ID" :value="target.AIS4.KJE149"></unique-tr>
                  <unique-tr title="会社ID" :value="target.AIS4.KJE150"></unique-tr>
                  <unique-tr title="JAMP ID" :value="target.AIS4.KJE153"></unique-tr>
                  <unique-tr title="会社名" :value="target.AIS4.KJE078"></unique-tr>
                  <unique-tr title="部門名" :value="target.AIS4.KJE154"></unique-tr>
                  <unique-tr title="住所" :value="target.AIS4.KJE155"></unique-tr>
                  <unique-tr title="担当者氏名" :value="target.AIS4.KJE090"></unique-tr>
                </tbody>
              </table>
            </div>
            <div class="column">
              <table class="unique-table table is-bordered is-narrow">
                <tbody>
                  <unique-tr title="電話" :value="target.AIS4.KJE156"></unique-tr>
                  <unique-tr title="FAX" :value="target.AIS4.KJE157"></unique-tr>
                  <unique-tr title="E-Mail" :value="target.AIS4.KJE091"></unique-tr>
                  <unique-tr title="備考 1" :value="target.AIS4.KJE158"></unique-tr>
                  <unique-tr title="備考 2" :value="target.AIS4.KJE159"></unique-tr>
                  <unique-tr title="備考 3" :value="target.AIS4.KJE160"></unique-tr>
                </tbody>
              </table>
            </div>
          </div>
        </transition>
      </div>

      <div class="AIS5 message is-green">
        <div class="message-header" @click="toggleDetail('AIS5')">
          <p>型番情報</p>
          <span class="icon" v-if="!target.AIS5.isShow"><i class="fas fa-caret-right"></i></span>
          <span class="icon" v-if="target.AIS5.isShow"><i class="fas fa-caret-down"></i></span>
        </div>
        <transition name="fade">
          <div class="message-body columns" v-show="target.AIS5.isShow">
            <div class="column is-half">
              <table class="unique-table table is-bordered is-narrow">
                <caption>依頼者</caption>
                <tbody>
                  <unique-tr v-for="(item,index) in target.AIS5.KJE079" :title="index+1" :value="item" :key="index"></unique-tr>
                </tbody>
              </table>
            </div>
            <div class="column is-half">
              <table class="unique-table table is-bordered is-narrow">
                <caption>発行者</caption>
                <tbody>
                  <unique-tr v-for="(item,index) in target.AIS5.KJE164" :title="index+1" :value="item" :key="index"></unique-tr>
                </tbody>
              </table>
            </div>
          </div>
        </transition>
      </div>

      <div class="AIS6 message is-green">
        <div class="message-header" @click="toggleDetail('AIS6')">
          <p>成型品情報</p>
          <span class="icon" v-if="!target.AIS6.isShow"><i class="fas fa-caret-right"></i></span>
          <span class="icon" v-if="target.AIS6.isShow"><i class="fas fa-caret-down"></i></span>
        </div>
        <transition name="fade">
          <div class="message-body columns" v-show="target.AIS6.isShow">
            <div class="column">
              <table class="unique-table table is-bordered is-narrow">
                <tbody>
                  <unique-tr title="製造会社" :value="target.AIS6.KJE101"></unique-tr>
                  <unique-tr title="発行者型番(英)" :value="target.AIS6.KJE018"></unique-tr>
                  <unique-tr title="発行者型番(母)" :value="target.AIS6.KJE298"></unique-tr>
                  <unique-tr title="一般商品名" :value="target.AIS6.KJE172"></unique-tr>
                  <unique-tr title="シリーズ名" :value="target.AIS6.KJE173"></unique-tr>
                  <unique-tr title="発行者備考" :value="target.AIS6.KJE174"></unique-tr>
                  <unique-tr title="引用等" :value="target.AIS6.KJE183"></unique-tr>
                  <unique-tr title="集合化" :value="getKJE176(target.AIS6.KJE176)"></unique-tr>
                </tbody>
              </table>
            </div>
            <div class="column">
              <table class="unique-table table is-bordered is-narrow">
                <tbody>
                  <unique-tr title="単位" :value="getKJE177(target.AIS6.KJE177)"></unique-tr>
                  <unique-tr title="質量" :value="target.AIS6.KJE023"></unique-tr>
                  <unique-tr title="GADSL" :value="getCoveredRow(target.AIS6.KJE178)"></unique-tr>
                  <unique-tr title="JIG" :value="getCoveredRow(target.AIS6.KJE179)"></unique-tr>
                  <unique-tr title="含有確認" :value="getContained(target.AIS6.KJE180)"></unique-tr>
                  <unique-tr title="材質リストVer." :value="target.AIS6.KJE181"></unique-tr>
                  <unique-tr title="物質リストVer." :value="target.AIS6.KJE182"></unique-tr>
                </tbody>
              </table>
            </div>
          </div>
        </transition>
      </div>

      <div class="AIS7 message is-green">
        <div class="message-header" @click="toggleDetail('AIS7')">
          <p>集計情報</p>
          <span class="icon" v-if="!target.AIS7.isShow"><i class="fas fa-caret-right"></i></span>
          <span class="icon" v-if="target.AIS7.isShow"><i class="fas fa-caret-down"></i></span>
        </div>
        <transition name="fade">
          <div class="message-body columns" v-show="target.AIS7.isShow">
            <div class="column">
              <table class="table is-bordered is-narrow">
                <thead>
                  <th style="text-align:left; width:auto;">名称</th>
                  <th style="text-align:left; width:auto;">分類記号</th>
                  <th style="text-align:left; width:auto;">質量</th>
                </thead>
                <tbody>
                  <tr v-for="(item,index) in target.AIS7.data" :key="index">
                    <td style="text-align:left; width:auto;">{{item.name}}</td>
                    <td>{{item.div}}</td>
                    <td>{{item.weight}}</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </transition>
      </div>

    </div>
  </div>
  `,
  methods: {
    toggleDetail: function(prop){
      this.target[prop].isShow = !this.target[prop].isShow;
    },
    getKJE176: function(id){
      switch (id){
        case '0': return '無し';
        case '1': return '複合化';
        case '2': return '単純化';
      }
    },
    getKJE177: function(id){
      switch (id){
        case 'PC': return '個';
        case 'MTR': return 'm';
        case 'MTK': return 'm2';
        case 'MTQ': return 'm3';
        case 'CMT': return 'cm';
        case 'CMK': return 'cm2';
        case 'CMQ': return 'cm3';
      }
    },
    getCoveredRow(id){  //KJE178 KJE179 KJE267 KJE268 KJE269
      switch(id){
        case '0': return '対象としない';
        case '1': return '対象とする';
      }
    },
    getContained(id){ //KJE180 KJE270
      switch (id){
        case '0': return '含有あり';
        case '1': return '含有なし';
      }
    }
  }
});
Vue.component('AisTable', {
  props: {target:{type: Object} },
  template:
    `<div class="table is-bordered is-narrow" style="margin: 10px;">
      <table>
        <thead>
          <tr v-for="tr in target.thead">
            <th v-for="th in tr" :colspan="th.colspan">{{th.value}}</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="tr in target.tbody">
            <td v-for="td in tr" :rowspan="td.rowspan">{{td.value}}</td>
          </tr>
        </tbody>
      </table>
    </div>`
});
Vue.component('AisTreeChild', {
  props: {item:{type: Object}, treeID:{type: String} },
  template: `
    <li class="item">
      <span>
        <span class="icon" @click="toggle" v-if="node.children && !node.isOpen"><i class="fas fa-caret-right"></i></span>
        <span class="icon" @click="toggle" v-if="node.children && node.isOpen"><i class="fas fa-caret-down"></i></span>
        <span @click="select({id: treeID, props: node.props})">
          <span v-if="node.type=='product'"><img src="css/ticon_product.png"></span>
          <span v-if="node.type=='layer'"><img src="css/ticon_layer.png"></span>
          <span v-if="node.type=='parts'"><img src="css/ticon_parts.png"></span>
          <span v-if="node.type=='material'"><img src="css/ticon_material.png"></span>
          <span v-if="node.type=='substance'"><img src="css/ticon_law.png"></span>
          <span v-if="node.type=='law'"></span>
          <span :class="{'is-selected': node.isSelected}">{{ node.name }}</span>
        </span>
      </span>
      <ul class="node" v-show="node.isOpen" v-if="node.children">
        <ais-tree-child v-for="(child, index) in node.children" :key="index":item="child" :treeID="treeID+''+index"></ais-tree-child>
      </ul>
    </li>
  `,
  data: function(){
    return {
      node: this.item,
      isSelected: false
    }
  },
  methods: {
    toggle: function(){
      this.node.isOpen = !this.node.isOpen;
    },
    select: function(arg){
      if (this.$parent.showDetail){
        this.$parent.showDetail(arg);
      }else{
        this.$parent.select(arg);
      }
    },
  }
});
Vue.component('AisTree', {
  props: {target:{type: Object} },
  template: `
    <div class="tree">
      <div class="tabbody">
        <div class="columns">
          <div class="column">
            <div>
              <ul>
                <ais-tree-child v-for="(child, index) in target.children" :key="index" :item="child" treeID="tree" ref="root"></ais-tree-child>
              </ul>
            </div>
          </div>
          <div class="column">
            <div>
              <table class="table">
                <tr v-for="(row, index) in selected">
                  <th>{{row.name}}</th>
                  <td>{{row.value}}</td>
                </tr>
              </table>
            <div>
          </div>
        </div>
      </div>
    </div>
  `,
  data: function(){
    return {
      selected: []
    }
  },
  methods: {
    showDetail: function(arg){
      this.selected = arg.props;
      let treespred = function(arg, treeID){
        arg.isSelected = treeID == arg.treeID;
        arg.children.map(function(child){
          treespred(child);
        });
      }
      treespred(this.$refs.root, arg.treeID);
    }
  }
});
Vue.component('Ais', {
  props: {
    detail:{type: String}, 
    unique:{type: Object},
    table:{type: Object},
    tree:{type: Object}
  },
  template: `
    <div>
      <ais-unique :target="unique"></ais-unique>
      <hr class="hr">
      <div class="tabs is-boxed">
        <ul>
          <li :class="{'is-active': undertab=='table'}" @click="changeView('table')">
            <a><span class="icon"><i class="fas fa-table"></i></span><span>テーブル</span></a>
          </li>
          <li :class="{'is-active': undertab=='tree'}" @click="changeView('tree')">
            <a><span class="icon"><i class="fas fa-stream"></i></span><span>ツリー</span></a>
          </li>
        </ul>
      </div>
      <div>
        <ais-table :target="table" v-if="undertab=='table'"></ais-table>
        <ais-tree :target="tree" v-if="undertab=='tree'"></ais-tree>
      </div>
    </div>
  `,
  data: function () {
    return {
      undertab: this.detail
    }
  },
  methods: {
    changeView: function(arg){
      this.undertab = arg;
    }
  }
});
Vue.component('MSDSplus', {
  template: ``
});
Vue.component('JGPSSI', {
  template: ``
});
Vue.component('JAMA', {
  template: ``
});
Vue.component('chem', {
  template: ``
});