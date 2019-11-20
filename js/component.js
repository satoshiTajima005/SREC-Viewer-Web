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
  template: ``
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