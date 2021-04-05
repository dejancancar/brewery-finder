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
              <td><router-link :to="{name: 'addBrewery'}">Add Brewery</router-link></td>
          </tr>
      </table>
  </div>
</template>

<script>
import api from '../services/AuthService.js'
export default {
    name: "user",
    props:{
        userId: Number
    },
    data(){
        return{
            user:{
                userId:0,
                username: "",
            }
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