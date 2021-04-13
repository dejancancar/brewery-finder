<template>
  <div>
    <button v-show="isFavorite = false">Add To Favorites</button>
    <button v-show="isFavorite = true">Remove From Favorites</button>
    <h2>
      {{ breweryInfo.breweryName }}
    </h2>
    <div class="brewery-basic-info">
    <div>
      {{ breweryInfo.streetAddress }}
    </div>
    <div>{{ breweryInfo.city }} {{ breweryInfo.zipCode }}</div>

    <div>
      {{ breweryInfo.phone }}
    </div>
    <div>
      <span v-if="!readMore">{{ breweryInfo.history.slice(0,30)}}...<a v-show="!readMore" @click="readMore = true" href="#">(read more)</a></span>
      <span v-if="readMore">{{breweryInfo.history}}</span>

    </div>
    </div>
  </div>
</template>

<script>
import api from "../services/apiService.js";
export default {
    data() {
        return {
            breweryInfo: {},
            readMore: false,
            isFavorite: false
        }
        
    },
    methods: {
    getBreweryInfo() {
      api.getBreweryById(this.$route.params.breweryId).then((resp) => {
        this.breweryInfo = resp.data;
      });
    },
    checkIfFavorite() {
      api.checkIfFavorite(this.$route.params.breweryId)
        .then((resp) => {
          this.isFavorite = resp.data;
        })
    }
    },
    created() {
        this.getBreweryInfo();
        this.checkIfFavorite();
    }
};
</script>

<style>
</style>