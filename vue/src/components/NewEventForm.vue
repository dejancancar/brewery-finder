<template>
  <div>
    <button v-show="!toggleAddEvent" @click="toggleAddEvent = true">
      Add Event
    </button>
    <form v-show="toggleAddEvent">
      <table>
        <tr>
          <td>When:</td>
          <td>
            <input type="datetime-local" v-model="newEvent.dateAndTime" />
          </td>
        </tr>
        <tr>
          <td>Event Name:</td>
          <td>
            <input type="text" v-model="newEvent.title" />
          </td>
        </tr>
        <tr>
          <td>Event Details:</td>
          <td>
            <textarea
              cols="30"
              rows="10"
              v-model="newEvent.description"
            ></textarea>
          </td>
        </tr>
      </table>
      <button @click="addEvent">Submit</button>
      <button @click="toggleAddEvent = false">Cancel</button>
    </form>
  </div>
</template>

<script>
import api from '../services/apiService.js'
export default {
  data() {
    return {
      newEvent: {
        breweryId: this.$route.params.breweryId,
        title: "",
        description: "",
        dateAndTime: "",
      },
      toggleAddEvent: false,
    };
  },
  methods: {
      addEvent() {
          api.addEvent(this.newEvent)
            .then(() => {
                this.newEvent = {};
            })
      }
  }
};
</script>

<style>
</style>