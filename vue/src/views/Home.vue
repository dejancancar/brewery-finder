<template>
  <div class="home">
    <h1>Home</h1>
    <!-- <p>You must be authenticated to see this</p>
    <p>User Name: {{currentUser.username}}</p>
    <p>User Id: {{currentUser.userId}}</p>
    <p>Role: {{currentUser.role}}</p> -->
    <!-- <router-link :to="{name: 'users'}" ><button>Search Users</button></router-link> -->
    <div>
      <breweries />
    </div>
  </div>
</template>

<script>
import breweries from "../components/ViewBreweries.vue"
export default {
  components:{
    breweries
  },
  name: "home",
  computed: {
    currentUser() {
      return this.$store.state.user;
    },
  },
};
</script>
