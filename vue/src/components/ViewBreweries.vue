<template>
  <div>
      <h2>Breweries</h2>
      <ul class="all-breweries">
          <li v-for="brewery in breweries" :key="brewery.breweryId">
              <router-link :to="{ name: 'brewery', params: { breweryId: brewery.breweryId }}">{{brewery.breweryName}} </router-link>
              {{brewery.streetAddress}} {{brewery.city}} {{brewery.zipCode}} {{brewery.phone}}</li>
      </ul>
  </div>
</template>

<script>
import api from "../services/apiService.js"
export default {
    name: "viewBreweries",
    data(){
        return{
            breweries:[],
        }
    },
    methods:{
        getBreweries(){
            api.getBreweries()
                .then( (resp) => {
                    this.breweries = resp.data;
                })
        },
    },
    created(){
        this.getBreweries();
    }
}
</script>

<style scoped>
.all-breweries{
    list-style: none;
}
</style>