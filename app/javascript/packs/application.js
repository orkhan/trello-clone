import Vue from 'vue'
import App from './App'
import router from './router'

// Setup Configs
Vue.config.productionTip = false;

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#app',
    router,
    components: { App },
    template: '<App/>',
    render: h => h(App)
  });
})
