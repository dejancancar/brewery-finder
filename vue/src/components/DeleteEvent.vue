<template>
  <div>
    <button v-show="!toggleDeleteEvent" @click="getEventList">
      Delete Event
    </button>
    <select v-show="toggleDeleteEvent" v-model="eventToDelete">
        <option v-for="event in currentEvents" :key="event.breweryEventId" :value="event">
            {{event.title}}
        </option>
    </select>
    <form v-show="toggleDeleteEvent">
        <table>
            <td id="confirm-delete">Confirm Delete: </td>
            <td id="checkbox"><input  type="checkbox" value="true" v-model="confirmedDelete"></td>
        </table>
      <button @click="deleteEvent" :disabled="!confirmedDelete">Submit</button>
      <button @click="toggleUpdateEvent = false">Cancel</button>
    </form>
  </div>
</template>

<script>
import api from "../services/apiService.js";
export default {
  data() {
    return {
      toggleDeleteEvent: false,
      currentEvents: [],
      eventToDelete: {},
      confirmedDelete: false
    };
  },
  methods: {
    getEventList() {
      this.toggleDeleteEvent = true;
      api.getEventsByBrewery(this.$route.params.breweryId).then((resp) => {
        this.currentEvents = resp.data;
      });
    },
    deleteEvent() {
        api.deleteEvent(this.eventToDelete.breweryEventId)
            .then(() => {
                this.eventToDelete = {};
            })
    }
  },
};
</script>

<style scoped>
select  {
  padding-left: 3px;
  font-size: 16px;
  color: #000000;
  background-color: #ffffff;
  background-image: none;
  border: 1px solid #dfd7ca;
  border-radius: 4px;
  height: 40px;
  margin-left: 6px;
}
#confirm-delete{
  font-weight: bold;
}

</style>