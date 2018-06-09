<template>
  <div class="home-page">
    <h2>Please type board name</h2>
    <input type="text" v-model="name" @keyup.enter="createBoard()"/>
    <button @click="createBoard()">Create Board</button>
  </div>
</template>

<script>
  import {HTTP} from '../../utils/http'
  export default {
    name: 'Home',
    data() {
      return {
        errors: [],
        name: ''
      }
    },
    components: {
    },
    mounted(){
    },
    methods:{
      createBoard(){
        HTTP({
          method: 'post',
          url: '/boards.json',
          data: {
            board: {
              name: this.name
            }
          },
          dataType: 'json'
        }).then(response => {
          this.$router.push('/boards/' + response.data.uid);
        })
        .catch(e => {
          this.errors.push(e)
        });
      }
    }
  }
</script>
<style scoped>
</style>
