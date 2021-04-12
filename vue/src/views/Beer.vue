<template>
  <div>
    <h2>{{ beer.beerName }}</h2>
    <div>{{ beer.description }}</div>
    <div>{{ beer.beerType }}</div>
    <div>ABV: {{ beer.abv }}</div>
    <img class="image" :src="beer.imageUrl" alt="Beer Picture" />
    <beer-reviews/>
  </div>
</template>

<script>
import api from "../services/apiService.js";
import BeerReviews from "../components/BeerReviews.vue";
export default {
  data() {
    return {
      beer: {},
    };
  },
  methods: {
    getBeer() {
      api.getBeerById(this.$route.params.beerId).then((resp) => {
        this.beer = resp.data;
      });
    },
  },
  components: {
      BeerReviews,
  },
  created() {
    this.getBeer();
  },
};
</script>

<style scoped>
    .image {
        max-width: 30%;
    }
</style>