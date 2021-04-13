<template>
  <div>
      <ul>
          <li v-for="event in events" :key="event.breweryEventId">
              <h2>{{event.breweryName}}-{{event.title}}</h2>
              <caption>{{event.dateAndTime}}</caption>
              <p>{{event.description}}</p>
          </li>
      </ul>
  </div>
</template>

<script>
import api from "../services/apiService.js";
export default {
    data() {
        return {
            events: [],
        }
    },
    methods: {
        getEvents() {
            api.getEvents(this.$route.params.breweryId)
                .then((resp) => {
                    this.events = resp.data;
                })
        }
    },
    created() {
        this.getEvents();
    }

}
</script>

<style>

</style>