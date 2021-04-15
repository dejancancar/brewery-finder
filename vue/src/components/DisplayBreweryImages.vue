<template>
  <div class="container">
    <div
      class="brewery-images"
      v-for="image in breweryImages"
      :key="image.imageId"
    >
      <img class="image" :src="image.imageUrl" />
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
/*
.brewery-images{
  display: flex;
  justify-content: space-between;
}
li {
  height: 40vh;
  flex-grow: 1;
  margin: 1%;
}

img {
  max-height: 100%;
  min-width: 100%;
  object-fit: cover;
  vertical-align: bottom;
}*/
</style> 