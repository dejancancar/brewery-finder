<template>
  <div>
      <div class="day-of-week">
          Select Day: 
          <select v-model.number="breweryHours.dayOfWeek"> 
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

      <div>
        Open Time: 
        <select v-model.number="breweryHours.openHour">
            <option disabled  value="">Hour</option>
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
        :
        <select v-model.number="breweryHours.openMinute">
            <option disabled value="">minutes</option>
            <option value="0">00</option>
            <option value="15">15</option>
            <option value="30">30</option>
            <option value="45">45</option>
        </select>


          <select v-model="breweryHours.openAmPm">
            <option disabled value="">Select One</option>
            <option >AM</option>
            <option >PM</option>
          </select>
      </div>


        <div>
        Closing Time: 
        <select v-model.number="breweryHours.closeHour">
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
        :
        <select v-model.number="breweryHours.closeMinute">
            <option disabled  value="">minutes</option>
           <option value="0">00</option>
            <option value="15">15</option>
            <option value="30">30</option>
            <option value="45">45</option>
        </select>
           
          <select v-model="breweryHours.closeAmPm">
            <option disabled  value="">Select One</option>
            <option >AM</option>
            <option >PM</option>
          </select>
      </div>
      <div>

      </div>
      <button @click="updateHours" v-show="toggleForm">Update Info</button>
      <button @click="$router.go()" v-show="toggleForm">Cancel Update</button>


  </div>
</template>

<script>
import api from '../services/apiService.js'
export default {
    data(){
        return{
            breweryHours:{
                breweryId: parseInt(this.$route.params.breweryId),
                dayOfWeek: "",
                openHour: "",
                openMinute: "",
                openAmPm: "",
                closeHour: "",
                closeMinute: "",
                closeAmPm: "",
                
            },
            toggleForm: true,

        }
    },
    methods:{
        updateHours(){
        this.toggleForm = false;
        api.updateHours(this.breweryHours)
          .then( (resp) => {
            this.breweryHours = resp.data;
             window.alert('Hours have been updated!')
            
          });
          this.$router.go();
        },
    },
    created(){

    },
}
</script>

<style>

</style>