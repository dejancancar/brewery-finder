<template>
<div class="container">
    <display-basic-brewery-info class ="info"/>
    <display-brewery-hours class ="hours"/>
    <display-brewery-beers class="beers"/>
    <display-events-one-brewery class="events"/>
    <display-brewery-images class="images"/>
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
<style scoped>
.info{
  grid-area: info;
}
.hours{
  grid-area: hours;
}
.events{
  grid-area: events;
}
.beers{
  grid-area: beers;
}
.images{
  grid-area: images;
}
.container{
  display: grid;
  grid-template-areas: 
  "info hours"
  "beers beers"
  "events events"
  "images images"
  ;
  grid-template-columns: 1fr 1fr;
  grid-template-rows: 1fr 1fr 1fr 1fr;
  height: 90vh;
}
</style>