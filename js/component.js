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

Vue.component('JGPSSI', {
  template: ``
});
Vue.component('AIS', {
  props: ['target'],
  template: `
    <div>
      <AISunique :target="target"></AISunique>
      <div class="tabs">
        <ul>
          <li class="is-active"><a>Pictures</a></li>
          <li><a>Music</a></li>
        </ul>
      </div>
      <div>
        <AIStable :target="target"></AIStable>
        <AIStree :target="target"></AIStree>
      </div>
    </div>
  `
});
Vue.component('AISunique', {
  props: ['target'],
  template: `
    <div class="unique">
      <div class="AIS1 message">
        <div class="message-header">
          <p>AISに関する情報</p>
          <span class="icon" v-if="target.unique.AIS1.isShow"><i class="fas fa-caret-right"></i></span>
          <span class="icon" v-if="!target.unique.AIS1.isShow"><i class="fas fa-caret-down"></i></span>
        </div>
        <div class="message-body columns">
          <div class="column">
            <table class="unique-table">
              <tbody>
                <tr><th>言語</th><td></td></tr>
                <tr><th>文書GPID</th><td></td></tr>
                <tr><th>文書種類</th><td></td></tr>
                <tr><th>文書番号</th><td></td></tr>
                <tr><th>フォーマットVer.</th><td></td></tr>
              </tbody>
            </table>
          </div>
          <div class="column">
            <table class="unique-table">
              <tbody>
                <tr><th>提出日</th><td></td></tr>
                <tr><th>作成日</th><td></td></tr>
                <tr><th>改訂日</th><td></td></tr>
                <tr><th>改訂履歴</th><td></td></tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  `
});
Vue.component('AIStable', {
  props: ['target'],
  template: `<div class="table"></div>`
});
Vue.component('AIStree', {
  props: ['target'],
  template: `<div class="tree"></div>`
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