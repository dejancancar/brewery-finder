<template>
  <div>
    <h1>Select a user to add brewery:</h1>
    <table>
        <tr>
            <td>Username:</td>
            <td>
                <input type="text" v-model="searchUsername" />
            </td>

        </tr>
        <tr>
            <td>
                <button @click="getUsers">Search</button>
            </td>
        </tr>
    </table>
    <user-list :users="users" ></user-list>
  </div>
</template>

<script>
import api from "../services/AuthService.js"
import UserList from "../components/UsersList.vue"
export default {
    name: 'users',
    components: {
        UserList
    },
    data(){
        return{
        searchUsername:"",
        users: []
        }
    },
    methods:{
        getUsers(){
            api.getUsers(this.searchUsername)
                .then( (resp) => {
                    this.users = resp.data
                });

        }
    },
    created(){
        this.searchUsername = this.$route.query.searchUsername;
    }
};
</script>

<style>
</style>