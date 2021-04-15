<template>
  <div id="container">
     <h2>Upcoming Events!</h2>
    <ul>

      <li v-for="event in events" :key="event.breweryEventId">
        <h3 class="event"><span id="title">{{ event.title }}</span></h3>
        <div class="event" id="date-time">{{ formatDate(event.dateAndTime) }} </div>
        <div class="event" id="description">{{event.description}}</div>
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
    getEventsByBrewery() {
      api.getEventsByBrewery(this.$route.params.breweryId).then((resp) => {
        this.events = resp.data;
      });
    },
    formatDate(date) {
      return moment(String(date)).format("MMMM Do YYYY, h:mm a");
    },
  },
  created() {
    this.getEventsByBrewery();
  },
};
</script>

<style scoped>
ul{
    display: flex;
    justify-content: flex-start;
    list-style-type: none;
    margin: 0px;
  }
  li{
    margin: 10px;
    background-color: white;
    padding: 15px;
    border-radius: 5px;
    border: thin solid black;

  }
  .image{
    max-width: 100%;
  }
  h2{
    margin-left: 2%;
    margin-top: 1%;
    font-size: 40px;
    /* text-decoration: underline; */
    font-weight: bold;
    font-variant: small-caps;
    
  }
  h3{
    margin: 0px;
    font-size: 30px;
    background-color:#e0af1f;
    /* opacity: 70%; */
    color: white;
    padding-left: 5px;
    padding-right: 5px;
    border-radius: 5px;

  }
  .event{
    
  }
  #description{
    margin-top: 10px;
  }
  #container{
    margin-top: 2%;
    background-color: rgba(221, 221, 221, 0.678);
  }
  #title{
    
  }


</style>