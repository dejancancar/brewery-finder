<template>
  <div id="container">
    <div class="brewery-hours">
      <h2>Hours</h2>
      <ul>
        <li v-for="displayHours in breweryHours" :key="displayHours.hoursId">
          <span id="day-of-week"
            >{{ displayDayOfWeek(displayHours.dayOfWeek) }}:</span
          >
          <span v-show="!displayHours.isClosed">
            {{ displayHours.openHour }}:{{
              displayMinutesProperly(displayHours.openMinute)
            }}
            {{ displayHours.openAmPm }} - {{ displayHours.closeHour }}:{{
              displayMinutesProperly(displayHours.closeMinute)
            }}
            {{ displayHours.closeAmPm }}
          </span>
          <span id="closed" v-show="displayHours.isClosed">CLOSED</span>
        </li>
      </ul>
    </div>
    <button
      id="update-button"
      type="button"
      @click="(toggleForm = true), (toggleButton = false)"
      v-show="toggleButton"
    >
      Update Hours
    </button>

    <div id="grid-two">
      <div v-show="toggleForm" class="brewery-hours">
        <div class="day-of-week">
          <div id="select-names">Select Day</div>
          <select v-model.number="updatedHours.dayOfWeek">
            <option disabled value="">Day</option>
            <option value="1">Monday</option>
            <option value="2">Tuesday</option>
            <option value="3">Wednesday</option>
            <option value="4">Thursday</option>
            <option value="5">Friday</option>
            <option value="6">Saturday</option>
            <option value="7">Sunday</option>
          </select>
        </div>
        <div id="is-closed">
          If closed select:
          <input type="checkbox" v-model="updatedHours.isClosed" />
        </div>

        <div v-show="!updatedHours.isClosed">
          <div id="hour-boxes">
            <div id="select-names">Open Time</div>
            <select v-model.number="updatedHours.openHour">
              <option disabled value="">Hour</option>
              <option value="1">1</option>
              <option value="2">2</option>
              <option value="3">3</option>
              <option value="4">4</option>
              <option value="5">5</option>
              <option value="6">6</option>
              <option value="7">7</option>
              <option value="8">8</option>
              <option value="9">9</option>
              <option value="10">10</option>
              <option value="11">11</option>
              <option value="12">12</option>
            </select>
            <span id="time-punct">:</span>
            <select v-model.number="updatedHours.openMinute">
              <option disabled value="">minutes</option>
              <option value="0">00</option>
              <option value="15">15</option>
              <option value="30">30</option>
              <option value="45">45</option>
            </select>

            <select v-model="updatedHours.openAmPm">
              <option disabled value="">Select One</option>
              <option>AM</option>
              <option>PM</option>
            </select>
          </div>

          <div id="select-names">Closing Time</div>
          <div id="hour-boxes">
            <select v-model.number="updatedHours.closeHour">
              <option disabled value="">Hour</option>
              <option value="1">1</option>
              <option value="2">2</option>
              <option value="3">3</option>
              <option value="4">4</option>
              <option value="5">5</option>
              <option value="6">6</option>
              <option value="7">7</option>
              <option value="8">8</option>
              <option value="9">9</option>
              <option value="10">10</option>
              <option value="11">11</option>
              <option value="12">12</option>
            </select>
            <span id="time-punct">:</span>
            <select v-model.number="updatedHours.closeMinute">
              <option disabled value="">minutes</option>
              <option value="0">00</option>
              <option value="15">15</option>
              <option value="30">30</option>
              <option value="45">45</option>
            </select>

            <select v-model="updatedHours.closeAmPm">
              <option disabled value="">Select One</option>
              <option>AM</option>
              <option>PM</option>
            </select>
          </div>
        </div>
        <div></div>
      </div>
      <button @click="updateHours" v-show="toggleForm">Update</button>
      <button @click="$router.go()" v-show="toggleForm">Cancel</button>
    </div>
  </div>
</template>

<script>
import api from "../services/apiService.js";
export default {
  data() {
    return {
      breweryHours: [],
      updatedHours: {
        breweryId: parseInt(this.$route.params.breweryId),
        hoursId: "",
        dayOfWeek: "",
        openHour: "",
        openMinute: "",
        openAmPm: "",
        closeHour: "",
        closeMinute: "",
        closeAmPm: "",
        isClosed: false,
      },
      toggleForm: false,
      toggleButton: true,
    };
  },
  computed: {
    // showDayOfWeek(){
    // }
  },
  methods: {
    updateHours() {
      this.toggleForm = false;
      this.toggleButton = false;
      this.updateHoursId();
      if (this.updatedHours.isClosed) {
        this.updatedHours.openHour = 0;
        this.updatedHours.openMinute = 0;
        this.updatedHours.closeHour = 0;
        this.updatedHours.closeMinute = 0;
      }
      api.updateHours(this.updatedHours).then((resp) => {
        let index = this.updatedHours.dayOfWeek - 1;
        this.breweryHours[index] = resp.data;
        window.alert("Hours have been updated!");
      });
      this.$router.go();
    },
    getHours() {
      api.getBreweryHours(this.$route.params.breweryId).then((resp) => {
        this.breweryHours = resp.data;
      });
    },
    updateHoursId() {
      this.breweryHours.forEach((hours) => {
        if (hours.dayOfWeek === this.updatedHours.dayOfWeek) {
          this.updatedHours.hoursId = hours.hoursId;
        }
      });
    },
    displayMinutesProperly(minutes) {
      if (minutes == 0) {
        return "00";
      } else {
        return minutes;
      }
    },
    displayDayOfWeek(day) {
      if (day === 1) {
        return "Monday";
      } else if (day === 2) {
        return "Tuesday";
      } else if (day === 3) {
        return "Wednesday";
      } else if (day === 4) {
        return "Thursday";
      } else if (day === 5) {
        return "Friday";
      } else if (day === 6) {
        return "Saturday";
      } else {
        return "Sunday";
      }
    },
  },
  created() {
    this.getHours();
  },
};
</script>

<style scoped>
.brewery-hours {
  max-height: 320px;
  padding-bottom: 0px;
}
li {
  list-style-type: none;
}
.brewery-hours {
  grid-area: one;
}
#grid-two {
  grid-area: two;

}
#container {
  display: grid;
  grid-template-areas: "one two";
  grid-template-columns: 1fr 1fr;
}
select {
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
#day-of-week, #select-names {
  font-weight: bold;
  font-size: 17px;
  margin-right: 3px;
}
#closed {
  font-weight: bold;
  color: red;
}
h2 {
  font-size: 40px;
  margin-top: 0px;
}
#update-button {
  max-width: 15%;
}
#hour-boxes{
  max-width: ;
}
#time-punct{
  margin: auto;
  padding-left: 1%;
}
#is-closed{
  padding-left: 2%;
  margin-top: .5%;
}

</style>