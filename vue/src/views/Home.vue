<template>
  <div class="main">
    <!-- <p>You must be authenticated to see this</p>
    <p>User Name: {{currentUser.username}}</p>
    <p>User Id: {{currentUser.userId}}</p>
    <p>Role: {{currentUser.role}}</p> -->
    <!-- <router-link :to="{name: 'users'}" ><button>Search Users</button></router-link> -->
    <view-breweries id="breweries"/>
    <display-events-all-breweries id="events"/>
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

<style scoped>
#breweries{
  grid-area: breweries;
  display: flex;
}
#events{
  grid-area: events;
  display: flex;
}
div{
  display: grid;
  grid-template-areas:
    "breweries breweries breweries events"
  ;
  grid-template-columns: 1fr 1fr 1fr 1fr;
}
</style>
