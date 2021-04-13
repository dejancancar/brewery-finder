<template>
  <div>
    <ul>
      <li v-for="beer in activeBeer" :key="beer.beerId">
        <router-link :to="{name: 'beer', params: {beerId: beer.beerId }}">
        <h2>{{ beer.beerName }}</h2>
        <!-- <div>Description: {{beer.description}}</div>
        <div>Type: {{ beer.beerType }}</div>
        <div>ABV: {{ beer.abv }}%</div> -->
        <div v-if="showOnTapBrewer">Currently on tap: {{beer.isActive ? "Yes" : "No"}}</div>
        <img class="image" :src="beer.imageUrl" alt="Beer Picture" />
        </router-link>
      </li>
      
    </ul>
  </div>
</template>

<script>
import api from "../services/apiService.js";
export default {
  data() {
    return {
      beers: [],
      showOnTapBrewer: false,
    };
  },
  computed:{
      activeBeer(){
        if(this.$route.name === 'brewery'){
          return this.beers.filter( (beer) => {
            return beer.isActive === true;
          }) 
      }
      return this.beers;
      
    }
  },
  methods: {
    getBeers() {
      api.getBeers(this.$route.params.breweryId).then((resp) => {
        this.beers = resp.data;
      });
    },
    //if on brewer page, beers display whether active or not. If on user page only displays beer
    updateInfoOnly(){
      if(this.$route.name === 'update-brewery'){
         this.showOnTapBrewer = true;
      }


    },

  },
  created() {
    this.getBeers();
    this.updateInfoOnly();
  },
};
</script>

<style scoped>
  .image {
    max-height: 15%;
    max-width: 15%;
  }
</style>