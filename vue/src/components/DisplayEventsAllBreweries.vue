<template>
  <div>
    
    <ul><h2>Upcoming Events!</h2>
      <li v-for="event in events" :key="event.breweryEventId">
        <h3>{{ event.breweryName }}-{{ event.title }}</h3>
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
}
h2{
  font-size: 30px;
  display:flex;
  justify-content: center;
}
</style>