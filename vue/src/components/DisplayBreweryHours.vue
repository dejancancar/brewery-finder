<template>
      <div>
      <ul>
        <li v-for="displayHours in breweryHours" :key="displayHours.hoursId">
        {{displayDayOfWeek(displayHours.dayOfWeek)}}: 
        <span v-show="!displayHours.isClosed">
        {{displayHours.openHour}}:{{displayMinutesProperly(displayHours.openMinute)}} {{displayHours.openAmPm}} -
        {{displayHours.closeHour}}:{{displayMinutesProperly(displayHours.closeMinute)}} {{displayHours.closeAmPm}}
        </span>
        <span v-show="displayHours.isClosed">CLOSED</span>
        </li>
      </ul>
    </div>
</template>

<script>
import api from '../services/apiService.js';
export default {
    data() {
        return{
            breweryHours: [],
        }
    },
    methods: {
        getHours(){
          api.getBreweryHours(this.$route.params.breweryId)
            .then( (resp) => {
              this.breweryHours = resp.data;
            })
        },
    }
}
</script>

<style>

</style>