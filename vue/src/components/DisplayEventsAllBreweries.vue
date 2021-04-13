<template>
  <div>
    <h2>Upcoming Events!</h2>
    <ul>
      <li v-for="event in events" :key="event.breweryEventId">
        <h2>{{ event.breweryName }}-{{ event.title }}</h2>
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
      api.getEvents().then((resp) => {
        this.events = resp.data;
      });
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

<style>
</style>