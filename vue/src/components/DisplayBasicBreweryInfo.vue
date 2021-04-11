<template>
  <div>
    <div>
      {{ breweryInfo.breweryName }}
    </div>
    <div>
      {{ breweryInfo.streetAddress }}
    </div>
    <div>{{ breweryInfo.city }}, {{ breweryInfo.zipCode }}</div>

    <div>
      {{ breweryInfo.phone }}
    </div>
    <div>
      {{ breweryInfo.history }}
    </div>
  </div>
</template>

<script>
import api from "../services/apiService.js";
export default {
    data() {
        return {
            breweryInfo: {},
        }
    },
    methods: {
    getBreweryInfo() {
      api.getBreweryById(this.$route.params.breweryId).then((resp) => {
        this.brewery = resp.data;
      });
    },
    },
    created() {
        this.getBreweryInfo();
    }
};
</script>

<style>
</style>