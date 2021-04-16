<template>
  <div id="container">
    <h1>Select a user to add brewery:</h1>
    <!--
      <div class="fields">
      <label for="username" class="label">Username:</label>
      <input
        type="text"
        id="username"
        class="text-box"
        placeholder="Username"
        v-model="user.username"
        required
        autofocus
      />
        </div>
        <button type="submit" class="submit-button">Sign in</button>
        <div class="hyperlink">
                <router-link :to="{ name: 'register' }" class="router-link">Need an account?</router-link>

        </div>

      --->

    <div>
      <div id="username">
         <label for="username" autofocus>Username</label>     
      </div>

      <input
        type="text"
        id="username"
        class="text-box"
        placeholder=""
        v-model="searchUsername"
        required
        autofocus
      />
    </div>
    <button @click="getUsers">Search</button>
    <user-list v-show="toggleUsersList" :users="users"></user-list>
  </div>
</template>

<script>
import api from "../services/apiService.js";
import UserList from "../components/UsersList.vue";
export default {
  components: {
    UserList,
  },
  data() {
    return {
      searchUsername: "",
      users: [],
      toggleUsersList: false,
    };
  },
  methods: {
    getUsers() {
      this.toggleUsersList = true;
      api.getUsers(this.searchUsername).then((resp) => {
        this.users = resp.data;
      });
    },
  },
  created() {
    //Checks to see if the user is an admin, if not it reroutes them to home.
    if (this.$store.state.user.role != "admin") {
      window.alert("You are not authorized");
      this.$router.push("/");
    }
    this.searchUsername = this.$route.query.searchUsername;
  },
};
</script>

<style scoped>
#container{
  margin-left: 2%;
  margin-top: 8%;
}
input {
  padding-left: 3px;
  font-size: 16px;
  color: #000000;
  background-color: #ffffff;
  background-image: none;
  border: 1px solid #dfd7ca;
  border-radius: 4px;
  height: 40px;
  margin-left: 6px;
  width: 30%;
}
#username{
  font-weight: bold;
  font-size: 17px;
  margin-right: 3px;
}
</style>