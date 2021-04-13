<template>
  <div>
    <display-basic-brewery-info />
    <display-brewery-hours />
    <display-brewery-beers />
    <display-brewery-images />
    <display-events-one-brewery />
  </div>
</template>

<script>
import DisplayBasicBreweryInfo from "../components/DisplayBasicBreweryInfo.vue";
import DisplayBreweryImages from "../components/DisplayBreweryImages.vue";
import DisplayBreweryHours from "../components/DisplayBreweryHours.vue";
import DisplayBreweryBeers from "../components/DisplayBreweryBeers.vue";
import DisplayEventsOneBrewery from "../components/DisplayEventsOneBrewery.vue";
export default {
  components: {
    DisplayBasicBreweryInfo,
    DisplayBreweryHours,
    DisplayBreweryBeers,
    DisplayBreweryImages,
    DisplayEventsOneBrewery
  },
};
</script>

<style>
</style>