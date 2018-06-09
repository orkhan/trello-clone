<template>
  <div id="app" class="container">
    <nav class="navbar navbar-default" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <a class="navbar-brand" href="/">Trello</a>
        </div>
      </div>
    </nav>
    <router-view/>
  </div>
</template>

<script>
  export default {
    name: 'App',
    created(){
      
    }
  }
</script>
<style>
  body, html {
    height: 100%;
  }
</style>
