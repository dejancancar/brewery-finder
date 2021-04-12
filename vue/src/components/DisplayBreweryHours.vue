<template>
  <div>
    <ul class = "brewery-hours">
      <li v-for="displayHours in breweryHours" :key="displayHours.hoursId">
        {{ displayDayOfWeek(displayHours.dayOfWeek) }}:
        <span v-show="!displayHours.isClosed">
          {{ displayHours.openHour }}:{{
            displayMinutesProperly(displayHours.openMinute)
          }}
          {{ displayHours.openAmPm }} - {{ displayHours.closeHour }}:{{
            displayMinutesProperly(displayHours.closeMinute)
          }}
          {{ displayHours.closeAmPm }}
        </span>
        <span v-show="displayHours.isClosed">CLOSED</span>
      </li>
    </ul>
  </div>
</template>

<script>
import api from "../services/apiService.js";
export default {
  data() {
    return {
      breweryHours: [],
    };
  },
  methods: {
    getHours() {
      api.getBreweryHours(this.$route.params.breweryId).then((resp) => {
        this.breweryHours = resp.data;
      });
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
    displayMinutesProperly(minutes) {
      if (minutes == 0) {
        return "00";
      } else {
        return minutes;
      }
    },
  },
  created() {
    this.getHours();
  },
};
</script>

<style>
</style>