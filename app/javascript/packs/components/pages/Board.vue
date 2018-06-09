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
          <h2>Please type list name</h2>
          <input type="text" v-model="listName" @keyup.enter="createList()"/>
          <button @click="createList()">Create list</button>
        </div>
        <div :key="list.id" class="list" v-for="(list, index) in board.lists">
          <h3>{{list.name}}</h3>
          <div class="cards">
            <!-- <div class="create-card">
              <h2>Please type card title</h2>
              <input type="text" v-model="cardTitle" @keyup.enter="createCard()"/>
              <button @click="createCard()">Create card</button>
            </div> -->
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
        errors: [],
        board: {},
        listName: '',
        cardTitle: ''
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
      },
      createList() {
        HTTP({
          method: 'post',
          url: '/lists.json',
          data: {
            list: {
              board_id: this.board.id,
              name: this.listName
            }
          },
          dataType: 'json'
        }).then(response => {
          console.log(response.data);
        })
        .catch(e => {
          this.errors.push(e)
        });
      },
      // createCard() {
      //   HTTP({
      //     method: 'post',
      //     url: '/cards.json',
      //     data: {
      //       list: {
      //         list_id: this.card.id,
      //         title: this.cardTitle
      //       }
      //     },
      //     dataType: 'json'
      //   }).then(response => {
      //     console.log(response.data);
      //   })
      //   .catch(e => {
      //     this.errors.push(e)
      //   });
      // }
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
