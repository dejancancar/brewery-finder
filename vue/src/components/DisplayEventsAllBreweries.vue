<template>
  <div>
    
    <ul><h2>Upcoming Events!</h2>
      <li v-for="event in events" :key="event.breweryEventId">
        <h3>{{ event.breweryName }}</h3>
        <h4> {{ event.title }}</h4>
        <div>{{ formatDate(event.dateAndTime) }}</div>
        <div>{{ event.description }}</div>
      </li>
    </ul>
  </div>
</template>

<script>
import api from "../services/apiService.js";
import moment from "moment";
export default {
  data() {
    return {
      events: [],
    };
  },
  methods: {
    getEvents() {
      if (this.$store.state.token === "") {
        api.getEvents().then((resp) => {
        this.events = resp.data;
      });
      } else {
        api.getEventsLoggedInUser(this.$store.state.user.userId)
          .then((resp) => {
            this.events = resp.data;
          })
      }
      
    },
    formatDate(date) {
      return moment(String(date)).format("MMMM Do YYYY, h:mm a");
    },
  },
  created() {
    this.getEvents();
  },
};
</script>

<style scoped>
li{
  list-style-type: none;
  margin-top: 50px;
      margin: 15px;
    background-color: white;
    padding: 20px;
    border-radius: 10px;
    border: thin solid black;
}
h2{
  font-size: 20px;
  display:flex;
  justify-content: center;
}

h3, h4{
      margin: 0px;

    background-color:#e0af1f;
    /* opacity: 70%; */
    color: white;
    padding: 5px;
    margin: 0px 2px;
}
h3{
  font-size: 25px;
  text-decoration: underline;
  margin-bottom: 0px;
}
h4{
  margin-top: 0px;
}
</style>