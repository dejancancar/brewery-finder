<template>
  <div>
      <h1>Details</h1>
      <table>
          <tr>
              <td>UserId:</td>
              <td>{{user.userId}}</td>
          </tr>
          <tr>
              <td>Username:</td>
              <td>{{user.username}}</td>
          </tr>
      </table>
      <table>
          <tr>
              <button type="button" @click="addBrewery = true" v-show="!addBrewery">Add New Brewery</button>
              <new-brewery v-show="addBrewery" />
          </tr>
      </table>
  </div>
</template>

<script>
import api from '../services/AuthService.js'
import newBrewery from '../components/NewBreweryForm.vue'
export default {
    name: "user",
    components:{
        newBrewery
    },
    props:{
        userId: Number
    },
    data(){
        return{
            user:{
                userId:0,
                username: "",
            },
            addBrewery: false,
        }
    },
    methods:{
        getUser(username){
            api.getUsers(username).then( (resp) => { 
                this.user = resp.data;
            })
        }
    },
    created(){
        this.getUser(this.$route.params.id)
    }

}
</script>

<style>

</style>