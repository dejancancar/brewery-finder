<template>
  <div>
    <div v-show="showFormButton">
        <button type="button" v-on:click="toggleUpdateBreweryForm" v-show="showFormButton">BUTTON</button>
    </div>
    <update-brewery v-show="!showFormButton"></update-brewery>
  </div>
</template>

<script>
import updateBrewery from "../components/UpdateBrewery.vue"
export default {
  data(){
    return {
      showFormButton: true,
    }
  },
  methods:{
    toggleUpdateBreweryForm(){
      this.showFormButton = false;
    }
  },
  components:{
    updateBrewery
  }
}
</script>

<style>

</style>