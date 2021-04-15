<template>
  <div >
        <h2>{{ beer.beerName }}</h2>
    <div id="container" >

    <div id="description"><span>Description:</span> {{ beer.description }}</div>
    <div id="description"><span>Type:</span> {{ beer.beerType }}</div>
    <div id="description"><span>ABV:</span> {{ beer.abv }}%</div>
    <img class="image" :src="beer.imageUrl" alt="Beer Picture" />
    
    <beer-reviews/>
    </div>
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
#container{
  margin-top: 0px;
  margin-left: 5%;
  margin-right: 30%;
}
#description{
  font-size: 20px;
  margin-right: 30%;
}
h2{
    margin-top: 7% ;
  font-size: 40px;
  margin-left: 3%;
  margin-bottom: 0px;
}
span{
  font-weight: bold;
}
</style>