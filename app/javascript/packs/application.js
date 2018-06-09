import Vue from 'vue'
import App from './App'
import router from './router'
import NProgress from "nprogress";
import Element from 'element-ui'

// Install Plugins
Vue.use(NProgress);

// Setup Configs
Vue.config.productionTip = false;

// Router
router.beforeEach((to, from, next) => {
  NProgress.start();
  next()
});

router.afterEach(() => {
  NProgress.done()
});

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#app',
    router,
    components: { App },
    template: '<App/>',
    render: h => h(App)
  });
})
