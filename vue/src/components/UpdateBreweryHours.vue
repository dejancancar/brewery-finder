<template>
  <div>
    <div v-for="hours in breweryHours" :key="hours.hoursId">
      <p>{{hours}}</p>
    </div>
      <div class="day-of-week">
          Select Day: 
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

      <div>
        Open Time: 
        <select v-model.number="updatedHours.openHour">
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
        <select v-model.number="updatedHours.openMinute">
            <option disabled value="">minutes</option>
            <option value="0">00</option>
            <option value="15">15</option>
            <option value="30">30</option>
            <option value="45">45</option>
        </select>


          <select v-model="updatedHours.openAmPm">
            <option disabled value="">Select One</option>
            <option >AM</option>
            <option >PM</option>
          </select>
      </div>


        <div>
        Closing Time: 
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
        :
        <select v-model.number="updatedHours.closeMinute">
            <option disabled  value="">minutes</option>
           <option value="0">00</option>
            <option value="15">15</option>
            <option value="30">30</option>
            <option value="45">45</option>
        </select>
           
          <select v-model="updatedHours.closeAmPm">
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
            breweryHours:[
            ],
            updatedHours:{
                breweryId: parseInt(this.$route.params.breweryId),
                hoursId: "",
                dayOfWeek: "",
                openHour: "",
                openMinute: "",
                openAmPm: "",
                closeHour: "",
                closeMinute: "",
                closeAmPm: "",
            },
            monday: "",
            toggleForm: true,

        }
    },
    methods:{
        updateHours(){
        this.toggleForm = false;
        this.updateHoursId();
        api.updateHours(this.updatedHours)
          .then( (resp) => {
            let index = this.updatedHours.dayOfWeek - 1;
            this.breweryHours[index] = resp.data;
             window.alert('Hours have been updated!')
            
          });
          this.$router.go();
        },
        getHours(){
          api.getBreweryHours(this.$route.params.breweryId)
            .then( (resp) => {
              this.breweryHours = resp.data;
            })
        },
        updateHoursId(){
          this.breweryHours.forEach( (hours) =>{
            if(hours.dayOfWeek === this.updatedHours.dayOfWeek){
              this.updatedHours.hoursId = hours.hoursId;
            }
          })
          

        }
    },
    created(){
      this.getHours();
    },
}
</script>

<style>

</style>