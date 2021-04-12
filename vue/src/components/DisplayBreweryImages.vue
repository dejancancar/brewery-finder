<template>
  <div>
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

<style>
</style>