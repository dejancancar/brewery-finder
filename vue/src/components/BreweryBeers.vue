<template>
  <ul>
      <li v-for="beer in beers" :key="beer.beerId">
          <h2>{{beer.beerName}}</h2>
          <div>{{beer.beerType}}</div>
          <div>{{beer.abv}}</div>
          <img src="beer.imageUrl" alt="Beer Picture">
      </li>
  </ul>
</template>

<script>
import api from '../services/apiService.js'
export default {
    data() {
        return {
            beers:[],
        }
    },
    methods: {
        getBeers(){
            api.getBeers(this.$route.params.breweryId)
                .then((resp) => {
                    this.beers = resp.data;
                })

        }
    },
    created() {
        this.getBeers();
    }


}
</script>

<style>

</style>