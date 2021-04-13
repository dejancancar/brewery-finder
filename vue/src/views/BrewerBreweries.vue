<template>
    <div> 
      <!-- <button class="big-button" type="button" @click="getBreweriesByBrewerId" v-show="showFormButton" >View Breweries</button> -->
      <table>
        <thead>
          <tr>
          <td>Brewery Id</td>
          <td>Brewery Name</td>
          <td>Brewery Address</td>
          </tr>
        </thead>
        <tbody>
          <tr v-for="brewery in breweries" :key="brewery.breweryId">
            <td>{{brewery.breweryId}}</td>
            <td><router-link :to="{name: 'update-brewery', params:{breweryId: brewery.breweryId}}">{{brewery.breweryName}}</router-link></td>
            <td>{{brewery.streetAddress}} {{brewery.city}} {{brewery.zipCode}}</td>
          </tr>
        </tbody>
        <!-- <button @click="cancelView" v-show="!showFormButton">Cancel</button> -->
      </table>
    </div>
</template>

<script>
import api from '../services/apiService.js';


export default {
  data() {
    return {
      showFormButton: true,
      breweries:[],
    };
  },
  methods: {
    getBreweriesByBrewerId(){
      // this.showFormButton = false;
      api.getBreweriesByBrewerId(this.$store.state.user.userId)
        .then( (resp) => {
          this.breweries = resp.data;
        })
    },
    cancelView(){
      this.showFormButton = true;
    }
  },
  components: {

  },
  created() {
    //check to make sure the user attempting to access this route is a brewer only
    if (this.$store.state.user.role != "brewer") {
      this.$router.push("/");
    }
    this.getBreweriesByBrewerId();
  },
};
</script>

<style>
</style>