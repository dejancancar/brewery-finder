<template>
  <div>
    <!-- <p>You must be authenticated to see this</p>
    <p>User Name: {{currentUser.username}}</p>
    <p>User Id: {{currentUser.userId}}</p>
    <p>Role: {{currentUser.role}}</p> -->
    <!-- <router-link :to="{name: 'users'}" ><button>Search Users</button></router-link> -->
    <view-breweries />
    <display-events-all-breweries />
  </div>
</template>

<script>
import ViewBreweries from "../components/ViewBreweries.vue";
import DisplayEventsAllBreweries from "../components/DisplayEventsAllBreweries.vue";
export default {
  components: {
    ViewBreweries,
    DisplayEventsAllBreweries,
  },
  name: "home",
  computed: {
    currentUser() {
      return this.$store.state.user;
    },
  },
};
</script>
