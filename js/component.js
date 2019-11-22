Vue.component('tabcol', {
  template: `
    <div class="column">
      <div class="tabs is-boxed">
        <slot name="ul"></slot>
      </div>
      <slot name="preview"></slot>
    </div>
  `
});

Vue.component('tabs', {
  props: ['target', 'moveto', 'language'],
  template: `
    <ul style="overflow:hidden;">
      <li v-for="(item, index) in target.list" :key="item.id" :class="{'is-active': target.selected === index}" @click="clickTab(target, index)">
        <a :title="item.name">
          <span class="tabname">{{item.name}}</span>
          <span class="icon is-small movetab" :title="language.movetab" @click="moveTab(target, item, index, moveto.list)">
            <i class="fas fa-file-export"></i>
          </span>
          <button class="delete is-small" aria-label="close" :title="language.delete" @click="deleteTab(target, index)"></button>
        </a>
      </li>
    </ul>
  `,
  methods: {
    clickTab: function(target, index){
      target.selected = index;
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
  template: `<tr><th>{{title}}</th><td>{{value}}</td></tr>`
});
Vue.component('JGPSSI', {
  template: ``
});
Vue.component('AisUnique', {
  props: { target:{ type: Object } },
  template: `
    <div class="unique">
      <div class="AIS1 message">
        <div class="message-header" @click="showDetail(target.AIS1)">
          <p>AISに関する情報</p>
          <span class="icon" v-if="!target.AIS1.isShow"><i class="fas fa-caret-right"></i></span>
          <span class="icon" v-if="target.AIS1.isShow"><i class="fas fa-caret-down"></i></span>
        </div>
        <div class="message-body columns" v-show="target.AIS1.isShow">
          <div class="column">
            <table class="unique-table">
              <tbody>
                <unique-tr title="言語" :value="target.AIS1.LANG"></unique-tr>
                <unique-tr title="文書GPID" :value="target.AIS1.KJE134"></unique-tr>
                <unique-tr title="文書種類" :value="target.AIS1.KJE135"></unique-tr>
                <unique-tr title="文書番号" :value="target.AIS1.KJE098"></unique-tr>
                <unique-tr title="フォーマットVer." :value="target.AIS1.KJE136"></unique-tr>
              </tbody>
            </table>
          </div>
          <div class="column">
            <table class="unique-table">
              <tbody>
                <unique-tr title="提出日" :value="target.AIS1.KJE137"></unique-tr>
                <unique-tr title="作成日" :value="target.AIS1.KJE016"></unique-tr>
                <unique-tr title="改訂日" :value="target.AIS1.KJE017"></unique-tr>
                <unique-tr title="改訂履歴" :value="target.AIS1.KJE014"></unique-tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
      
      <div class="AIS2 message">
        <div class="message-header" @click="showDetail(target.AIS2)">
          <p>発行会社情報</p>
          <span class="icon" v-if="!target.AIS2.isShow"><i class="fas fa-caret-right"></i></span>
          <span class="icon" v-if="target.AIS2.isShow"><i class="fas fa-caret-down"></i></span>
        </div>
        <div class="message-body columns" v-show="target.AIS2.isShow">
          <div class="column">
            <table class="unique-table">
              <tbody>
                <unique-tr title="登録機関ID" :value="target.AIS2.KJE138"></unique-tr>
                <unique-tr title="会社ID" :value="target.AIS2.KJE011"></unique-tr>
                <unique-tr title="JAMP ID" :value="target.AIS2.KJE141"></unique-tr>
              </tbody>
            </table>
          </div>
          <div class="column">
            <table class="unique-table">
              <tbody>
                <unique-tr title="会社名(英)" :value="target.AIS2.KJE012"></unique-tr>
                <unique-tr title="会社名(母)" :value="target.AIS2.KJE297"></unique-tr>
                <unique-tr title="追加情報" :value="target.AIS2.KJE142"></unique-tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <div class="AIS3 message">
        <div class="message-header" @click="showDetail(target.AIS3)">
          <p>発行/作成 部門情報</p>
          <span class="icon" v-if="!target.AIS3.isShow"><i class="fas fa-caret-right"></i></span>
          <span class="icon" v-if="target.AIS3.isShow"><i class="fas fa-caret-down"></i></span>
        </div>
        <div class="message-body columns" v-show="target.AIS3.isShow">
          <div class="column">
            <table class="unique-table">
              <tbody>
                <unique-tr title="発行:部門名" :value="target.AIS3.KJE143"></unique-tr>
                <unique-tr title="発行:住所" :value="target.AIS3.KJE144"></unique-tr>
                <unique-tr title="発行:電話" :value="target.AIS3.KJE145"></unique-tr>
                <unique-tr title="発行:FAX" :value="target.AIS3.KJE146"></unique-tr>
              </tbody>
            </table>
          </div>
          <div class="column">
            <table class="unique-table">
              <tbody>
                <unique-tr title="発行:E-Mail" :value="target.AIS3.KJE147"></unique-tr>
                <unique-tr title="作成:部門名" :value="target.AIS3.KJE093"></unique-tr>
                <unique-tr title="作成:電話" :value="target.AIS3.KJE124"></unique-tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <div class="AIS4 message">
        <div class="message-header" @click="showDetail(target.AIS4)">
          <p>依頼者情報</p>
          <span class="icon" v-if="!target.AIS4.isShow"><i class="fas fa-caret-right"></i></span>
          <span class="icon" v-if="target.AIS4.isShow"><i class="fas fa-caret-down"></i></span>
        </div>
        <div class="message-body columns" v-show="target.AIS4.isShow">
          <div class="column">
            <table class="unique-table">
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
            <table class="unique-table">
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
      </div>

    </div>
  </div>
  `,
  method: {
    showDetail: function(target){
      target.isShow = !target.isShow;
    }
  }
});
Vue.component('AisTable', {
  props: {target:{type: Object} },
  template: `<div class="table"></div>`
});
Vue.component('AisTree', {
  props: {target:{type: Object} },
  template: `<div class="tree"></div>`
});
Vue.component('Ais', {
  props: {
    unique:{type: Object},
    table:{type: Object},
    tree:{type: Object}
  },
  template: `
    <div>
      <ais-unique :target="unique"></ais-unique>
      <div class="tabs">
        <ul>
          <li class="is-active"><a><span class="icon"><i class="fas fa-table"></i></span><span>テーブル</span></a></li>
          <li><a><span class="icon"><i class="fas fa-stream"></i></span><span>ツリー</span></a></li>
        </ul>
      </div>
      <div>
        <ais-table :target="table"></ais-table>
        <ais-tree :target="tree"></ais-tree>
      </div>
    </div>
  `
});
Vue.component('MSDSplus', {
  template: ``
});
Vue.component('JAMA', {
  template: ``
});
Vue.component('chem', {
  template: ``
});