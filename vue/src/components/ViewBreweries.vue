<template>
  <div>
      <ul class="all-breweries">
          <li v-for="brewery in breweries" :key="brewery.breweryId">{{brewery.breweryName}} {{brewery.streetAddress}} {{brewery.city}} {{brewery.zipCode}} {{brewery.phone}}</li>
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