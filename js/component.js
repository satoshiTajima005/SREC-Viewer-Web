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
Vue.component('UniqueWrap', {
  props: {oName:{type: String}, target:{ type: Object } },
  template: `
    <div class="message is-green">
      <div class="message-header" @click="toggleDetail">
        <p>{{target.title}}</p>
        <span class="icon" v-if="!target.isShow"><i class="fas fa-caret-right"></i></span>
        <span class="icon" v-if="target.isShow"><i class="fas fa-caret-down"></i></span>
      </div>
      <transition name="fade">
        <div class="message-body columns" v-show="target.isShow">
          <div class="column">
            <table class="unique-table table is-bordered is-narrow">
              <tbody>
                <unique-tr v-for="(item,index) in target.data[0]" :title="item.title" :value="item.value" :key="index"></unique-tr>
              </tbody>
            </table>
          </div>
          <div class="column">
            <table class="unique-table table is-bordered is-narrow">
              <tbody>
                <unique-tr v-for="(item,index) in target.data[1]" :title="item.title" :value="item.value" :key="index"></unique-tr>
              </tbody>
            </table>
          </div>
        </div>
      </transition>
    </div>
  `,
  methods: {
    toggleDetail: function(){
      this.target.isShow = !this.target.isShow;
    }
  }
});
Vue.component('AisUnique', {
  props: { target:{ type: Object } },
  template: `
    <div class="unique">
      <unique-wrap oName="AIS1" :target="target.AIS1"></unique-wrap>
      <unique-wrap oName="AIS2" :target="target.AIS2"></unique-wrap>
      <unique-wrap oName="AIS3" :target="target.AIS3"></unique-wrap>
      <unique-wrap oName="AIS4" :target="target.AIS4"></unique-wrap>

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

      <unique-wrap oName="AIS6" :target="target.AIS6"></unique-wrap>

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
  `,
  methods: {
    toggleDetail: function(prop){
      this.target[prop].isShow = !this.target[prop].isShow;
    }
  }
});
Vue.component('AisTable', {
  props: {target:{type: Object} },
  template:
    `<div class="tabbody">
      <table class="table is-bordered is-narrow" style="margin: 10px;">
        <thead>
          <tr v-for="tr in target.thead">
            <th v-for="th in tr" :colspan="th.colspan" :class="th.class">{{th.value}}</th>
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
        <span v-if="!node.children" style="display:inline-block; width:24px;">&nbsp;</span>
        <span @click="select({treeID: treeID, props: node.props})">
          <span v-if="node.type=='product'"><img src="css/ticon_product.png"></span>
          <span v-if="node.type=='layer'"><img src="css/ticon_layer.png"></span>
          <span v-if="node.type=='parts'"><img src="css/ticon_parts.png"></span>
          <span v-if="node.type=='material'"><img src="css/ticon_material.png"></span>
          <span v-if="node.type=='substance'"><img src="css/ticon_substance.png"></span>
          <span v-if="node.type=='law'"><img src="css/ticon_law.png"></span>
          <span :class="{'is-selected': isSelected}">{{ node.name }}</span>
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
    <div class="tree tabbody" style="overflow:visible;">
      <div class="columns">
        <div class="column treecol">
          <div>
            <ul>
              <ais-tree-child v-for="(child, index) in target.children" :key="index" :item="child" treeID="tree" ref="root"></ais-tree-child>
            </ul>
          </div>
        </div>
        <div class="column treecol">
          <div>
            <table class="table">
              <tr v-for="(row, index) in selected">
                <th>{{row.name}}</th>
                <td>{{row.value}}</td>
              </tr>
            </table>
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
        arg.$children.map(function(child){
          treespred(child, treeID);
        });
      }
      treespred(this.$refs.root[0], arg.treeID);
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
      <div style="background:#f8f8f8;padding: 10px;">
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
Vue.component('MspUnique', {
  props: { target:{ type: Object } },
  template: `
    <div class="unique">
      <unique-wrap oName="MS1" :target="target.MS1"></unique-wrap>
      <unique-wrap oName="MS2" :target="target.MS2"></unique-wrap>
      <unique-wrap oName="MS3" :target="target.MS3"></unique-wrap>
      <unique-wrap oName="MS4" :target="target.MS4"></unique-wrap>

      <div class="message is-green">
        <div class="message-header" @click="toggleDetail('MS5')">
          <p>型番情報</p>
          <span class="icon" v-if="!target.MS5.isShow"><i class="fas fa-caret-right"></i></span>
          <span class="icon" v-if="target.MS5.isShow"><i class="fas fa-caret-down"></i></span>
        </div>
        <transition name="fade">
          <div class="message-body columns" v-show="target.MS5.isShow">
            <div class="column is-half">
              <table class="unique-table table is-bordered is-narrow">
                <caption>依頼者</caption>
                <tbody>
                  <unique-tr v-for="(item,index) in target.MS5.KJE253" :title="index+1" :value="item" :key="index"></unique-tr>
                </tbody>
              </table>
            </div>
            <div class="column is-half">
              <table class="unique-table table is-bordered is-narrow">
                <caption>発行者</caption>
                <tbody>
                  <unique-tr v-for="(item,index) in target.MS5.KJE254" :title="index+1" :value="item" :key="index"></unique-tr>
                </tbody>
              </table>
            </div>
          </div>
        </transition>
      </div>

      <unique-wrap oName="MS6" :target="target.MS6"></unique-wrap>

      <div class="message is-green">
        <div class="message-header" @click="toggleDetail('MS7')">
          <p>報告法令等の制定/改訂 番号</p>
          <span class="icon" v-if="!target.MS7.isShow"><i class="fas fa-caret-right"></i></span>
          <span class="icon" v-if="target.MS7.isShow"><i class="fas fa-caret-down"></i></span>
        </div>
        <transition name="fade">
          <div class="message-body columns" v-show="target.MS7.isShow">
            <div class="column">
              <table class="table is-bordered is-narrow">
                <thead>
                  <th style="text-align:left; width:auto;">ID</th>
                  <th style="text-align:left; width:auto;">名称</th>
                  <th style="text-align:left; width:auto;">制定/改訂 番号</th>
                </thead>
                <tbody>
                  <tr v-for="(item, index) in target.MS7.data" :key="index">
                    <td>{{item.ID}}</td>
                    <td>{{item.name}}</td>
                    <td>{{item.rev}}</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </transition>
      </div>

    </div>
  `
});
Vue.component('MspTable', {
  template: `

  `
});
Vue.component('MsdsPlus', {
  props: {
    detail:{type: String},
    unique:{type: Object},
    table:{type: Object}
  },
  template: `
    <div>
      <msp-unique :target="unique"></msp-unique>
      <hr class="hr">
      <div style="background:#f8f8f8;padding: 10px;">
        <div class="tabs is-boxed">
          <ul>
            <li class="is-active">
              <a><span class="icon"><i class="fas fa-table"></i></span><span>テーブル</span></a>
            </li>
          </ul>
        </div>
        <div>
          <msp-table :target="table" v-if="undertab=='table'"></msp-table>
        </div>
      </div>
    </div>
  `
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