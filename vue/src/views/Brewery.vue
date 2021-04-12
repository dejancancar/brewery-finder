<template>
<div class="beerflow">
  <div class = "flex-box">
    <display-basic-brewery-info />
    <display-brewery-hours />
    <display-brewery-beers />
    <display-brewery-images />
  </div>
    </div>

</template>

<script>
import DisplayBasicBreweryInfo from "../components/DisplayBasicBreweryInfo.vue";
import DisplayBreweryImages from "../components/DisplayBreweryImages.vue";
import DisplayBreweryHours from "../components/DisplayBreweryHours.vue";
import DisplayBreweryBeers from "../components/DisplayBreweryBeers.vue";
export default {
  components: {
    DisplayBasicBreweryInfo,
    DisplayBreweryHours,
    DisplayBreweryBeers,
    DisplayBreweryImages,
  },
};
</script>

<style>
</style>