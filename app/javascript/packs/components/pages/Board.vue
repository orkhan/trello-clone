<style scoped>
.board {
  overflow-x: auto;
  white-space: nowrap;
}
.list {
  display: inline-block;
  background: gray;
  border-radius: 5px;
  margin-right: 25px;
  padding: 10px;
  vertical-align: top;
  width: 250px;
}
.card {
  display: block;
  background: cyan;
  padding: 10px;
  border-radius: 5px;
  margin: 5px 0;
}
</style>
<template>
  <div class="row col-xs-12 board">
    <section class="row col-xs-12 board">
      <h1>Board: {{board.name}}</h1>
      <div class="row col-xs-12 lists">
        <div class="list">
          <div class="col-3 form-group">
            <label for="name">New list</label>
            <input type="text" id="name" placeholder="List name" v-model="listName" @keyup.enter="createList()" class="form-control" />
          </div>
        </div>
        <div :key="list.id" class="list" v-for="(list, index) in board.lists">
          <h4>{{list.name}}</h4>
          <button v-on:click="deleteList(list.id)" class="btn btn-danger">DELETE</button>
          <div class="col-3 cards">
            <input type="text" placeholder="Card name" v-model="cardTitle[list.id]" @keyup.enter="createCard(list.id)" class="form-control" />


            <draggable v-model="list.cards" :options="{group: 'cards'}" class="dragArea" @change="didMovedCard">
              <div class="card" :key="card.id" v-for="(card, index) in list.cards">
                <span @click="editCard(card.id)">{{ card.title }}</span>
                <input type="text" v-show="editId === card.id" v-model="cards[card.id] = card.title" @keyup.enter="updateCard(card.id)" class="form-control" />
                <button v-on:click="deleteCard(list.id, card.id)" class="btn btn-danger">x</button>
              </div>
            </draggable>

    
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
  import draggable from 'vuedraggable'
  import {HTTP} from '../../utils/http'
  export default {
    props:['id'],
    data() {
      return {
        errors: [],
        board: {},
        listName: '',
        cardTitle: [],
        editId: 0,
        cards: [],
        ws: null
      }
    },
    name: "Board",
    methods: {
      getBoard() {
        HTTP.get('/boards/'+ this.id + '.json')
          .then(response => {
            if(response.data){
              this.board = response.data;
              this.listenWS();
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
          this.listName = "";
        })
        .catch(e => {
          this.errors.push(e)
        });
      },
      deleteList(id) {
        HTTP({
          method: 'delete',
          url: '/lists/' + id + '.json',
          dataType: 'json'
        }).then(response => {
          const index = this.board.lists.findIndex(item => item.id == id);
          this.board.lists.splice(index, 1);
        })
        .catch(e => {
          this.errors.push(e)
        });
      },
      createCard(list) {
        HTTP({
          method: 'post',
          url: '/cards.json',
          data: {
            card: {
              list_id: list,
              title: this.cardTitle[list]
            }
          },
          dataType: 'json'
        }).then(response => {
          this.$delete(this.cardTitle, list);
        })
        .catch(e => {
          this.errors.push(e)
        });
      },
      editCard(id) {
        this.editId = id;
      },
      updateCard(id) {
        HTTP({
          method: 'put',
          url: '/cards/' + id + '.json',
          data: {
            card: {
              title: this.cards[id]
            }
          },
          dataType: 'json'
        }).then(response => {
          this.editId = 0;
        })
        .catch(e => {
          this.errors.push(e)
        });
      },
      deleteCard(list, id) {
        HTTP({
          method: 'delete',
          url: '/cards/' + id + '.json',
          dataType: 'json'
        }).then(response => {
          const listIndex = this.board.lists.findIndex(item => item.id == list);
          const index = this.board.lists[listIndex].cards.findIndex(item => item.id == id);
          this.board.lists[listIndex].cards.splice(index, 1);
        })
        .catch(e => {
          this.errors.push(e)
        });
      },
      didMovedCard(e) {
        const event = e.added || e.moved
        if (event == undefined) {
          return;
        }

        const card = event.element;
        const listIndex = this.board.lists.findIndex((list) => {
          return list.cards.find((_card) => {
            return _card.id === card.id;
          });
        });

        HTTP({
          method: 'put',
          url: '/cards/' + card.id + '.json',
          data: {
            card: {
              list_id: this.board.lists[listIndex].id
            }
          },
          dataType: 'json'
        }).then(response => {
          
        })
        .catch(e => {
          this.errors.push(e)
        });
      },
      listenWS() {
        var board = this.board;
        this.ws = App.cable.subscriptions.create({

        	  channel: "BoardChannel",
        	  uid: this.board.uid

        	}, {

        	  connected: function() {
              
        	  },

        	  disconnected: function() {
              
        	  },

        	  received: function(data) {
              console.log(data);
              if (data.action == "newList") {
                const list = JSON.parse(data.data);
                board.lists.unshift(list);
              }
              else if (data.action == "newCard") {
                const card = JSON.parse(data.data);
                const index = board.lists.findIndex(item => item.id == card.list_id);
                board.lists[index].cards.unshift(card);
              }
        	  }

        	});
      }
    },
    beforeMount(){
      this.getBoard();
    },
    mounted(){
    },
    components: {
      draggable
    }
  }
</script>
