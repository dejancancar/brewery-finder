<template>
  <div>
    <beer-list />
    <brewery />

  </div>
</template>

<script>
import brewery from "../components/ViewBrewery.vue";
import BeerList from "../components/BreweryBeers.vue"
export default {
  components: {
    brewery,
    BeerList
  },
};
</script>

<style>
</style>