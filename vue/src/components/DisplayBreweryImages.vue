<template>
  <div class="container">
    <div
      class="brewery-images"
      v-for="image in breweryImages"
      :key="image.imageId"
    >
    <ul>
      <li> <img class="image" :src="image.imageUrl" /> </li>
    </ul>
     
    </div>
  </div>
</template>

<script>
import api from "../services/apiService.js";
export default {
    data() {
        return{
            breweryImages: [],
        }
    },
    methods: {
    getBreweryImages() {
      api.getBreweryImages(this.$route.params.breweryId).then((resp) => {
        this.breweryImages = resp.data;
      });
    },        
    },
    created() {
    this.getBreweryImages();        
    }
};
</script>

<style scoped>

ul {
  display: flex;
  flex-wrap: wrap;
  flex: 1 0;
}

li {
  height: 35vh;
  flex-grow: 1;
  list-style-type: none;
}

img {
  max-height: 100%;
  min-width: 100%;
  object-fit: cover;
  vertical-align: bottom;
}
</style> 