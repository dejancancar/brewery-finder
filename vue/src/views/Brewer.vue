<template>
  <div>
    <div v-show="showFormButton">
      <button
        type="button"
        v-on:click="showFormButton = false"
        v-show="showFormButton"
      >
        Update Brewery
      </button>
    </div>
    <update-brewery v-show="!showFormButton"></update-brewery>
  </div>
</template>

<script>
import updateBrewery from "../components/UpdateBrewery.vue";
export default {
  data() {
    return {
      showFormButton: true,
    };
  },
  methods: {},
  components: {
    updateBrewery,
  },
  created() {
    //check to make sure the user attempting to access this route is a brewer only
    if (this.$store.state.user.role != "brewer") {
      this.$router.push("/");
    }
  },
};
</script>

<style>
</style>