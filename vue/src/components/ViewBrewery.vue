<template>
  <div>
    <div>
      {{ brewery.breweryName }}
    </div>
    <div>
      {{ brewery.streetAddress }}
    </div>
    <div>
     {{brewery.city}}, {{brewery.zipCode}}
    </div>

    <div>
      {{ brewery.phone }}
    </div>
    <div>
        {{brewery.history}}
    </div>
    <div class="brewery-images" v-for="image in breweryImages" :key="image.imageId">
        <img class="image" :src="image.imageUrl" />
    </div>
    
  </div>
</template>

<script>
import api from "../services/apiService.js";
export default {
  data() {
    return {
      brewery: {},
      breweryImages: [],
    };
  },
  methods: {
    getBreweryInfo() {
      api.getBreweryById(this.$route.params.breweryId).then((resp) => {
        this.brewery = resp.data;
      });
    },
    getBreweryImages() {
      api.getBreweryImages(this.$route.params.breweryId).then((resp) => {
        this.breweryImages = resp.data;
      });
    },
  },
  created() {
    this.getBreweryInfo();
    this.getBreweryImages();
  },
};
</script>

<style>
.image {
    display:flex;
    flex-direction: row;
    border-radius: 10px;
    max-height: 20%;
    max-width: 20%;
}
</style>