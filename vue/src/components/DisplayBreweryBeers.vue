<template>
  <div>
    <ul>
      <li v-for="beer in beers" :key="beer.beerId">
        <h2>{{ beer.beerName }}</h2>
        <div>{{beer.description}}</div>
        <div>{{ beer.beerType }}</div>
        <div>ABV: {{ beer.abv }}</div>
        <img class="image" :src="beer.imageUrl" alt="Beer Picture" />
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
    };
  },
  methods: {
    getBeers() {
      api.getBeers(this.$route.params.breweryId).then((resp) => {
        this.beers = resp.data;
      });
    },
  },
  created() {
    this.getBeers();
  },
};
</script>

<style scoped>
  .image {
    max-height: 15%;
    max-width: 15%;
  }
</style>