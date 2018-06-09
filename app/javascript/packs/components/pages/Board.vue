<style scoped>
.board {
  width: 100%;
  height: 100%;
}
.board h1 {
}
.lists {
  width: 100%;
  overflow-y: auto;
}
.create-list, .list {
  float: left;
  display: block;
  width: 250px;
  border: 1px solid red;
  margin: 2px;
  height: auto;
}
.cards {
  width: 100%;
}
</style>
<template>
  <div class="board">
    <nav>
    </nav>
    <section class="board">
      <h1>Board: {{board.name}}</h1>
      <div class="lists">
        <div class="create-list">
          <a href="#">Create new list</a>
        </div>
        <div :key="list.id" class="list" v-for="(list, index) in board.lists">
          <h3>{{list.name}}</h3>
          <div class="cards">
            <div class="card" :key="card.id" v-for="(card, index) in list.cards">
              <h4>{{ card.title }}</h4>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
  import {HTTP} from '../../utils/http'
  export default {
    props:['id'],
    data() {
      return {
        errors:[],
        board:{}
      }
    },
    name: "Board",
    methods: {
      getBoard() {
        HTTP.get('/boards/'+ this.id + '.json')
          .then(response => {
            if(response.data){
              this.board = response.data;
            }
          })
          .catch(e => {
            this.errors.push(e);
            this.$router.push({ path: '/' });
          });
      }
    },
    beforeMount(){
      this.getBoard();
    },
    mounted(){
    },
    components: {
    }
  }
</script>
