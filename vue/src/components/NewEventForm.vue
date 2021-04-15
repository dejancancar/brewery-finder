<template>
  <div>
    <button v-show="!toggleAddEvent" @click="toggleAddEvent = true">
      Add Event
    </button>
    <form v-show="toggleAddEvent">
      <table>
        <tr id="select-name">
          <td>When</td>
        </tr>
        <tr>
          <td>
            <input id="date" type="datetime-local" v-model="newEvent.dateAndTime" />
          </td>
        </tr>
        <tr id="select-name">
          <td>Event Name</td>
        </tr>
        <tr id="select-name">
          <td>
            <input type="text" v-model="newEvent.title" />
          </td>
        </tr>
        <tr id="select-name">
          <td>Event Details</td>
        </tr>
        <tr>
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
import api from "../services/apiService.js";
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
      api.addEvent(this.newEvent).then(() => {
        this.newEvent = {};
      });
    },
  },
};
</script>

<style scoped>
select, input {
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
textarea {
  padding-left: 3px;
  font-size: 16px;
  color: #000000;
  background-color: #ffffff;
  background-image: none;
  border: 1px solid #dfd7ca;
  border-radius: 4px;
  height: 40px;
  margin-left: 6px;
  height: 150px;
  width: 100%;
}
#select-name {
  font-weight: bold;
  font-size: 17px;
  margin-right: 3px;
}
#date{
  font-weight: bold;
  padding-left: 10px;
}
</style>