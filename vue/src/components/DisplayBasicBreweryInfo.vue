<template>
  <div id="brewery-info-main">


    <h2 class="brewery-name">
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
        <!-- <span v-if="!readMore"
          >{{ breweryInfo.history.slice(0, 30) }}...<a
            v-show="!readMore"
            @click="readMore = true"
            href="#"
            >(read more)</a
          ></span
        > -->
        <span v-if="readMore">{{ breweryInfo.history }}</span>
      </div>
    </div>
        <div v-if="showFavoritesButton">
        <button @click="addToFavorite" v-show="!breweryInfo.isFavorite">
        Add To Favorites
        </button>
        <button @click="deleteFavorite" v-show="breweryInfo.isFavorite">Remove Favorite</button>
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
      showFavoritesButton: false,
    };
  },
  methods: {
    getBreweryInfo() {
      // if (this.$store.state.token === "") {
        api.getBreweryWithLoggedInUser(this.$store.state.user.userId, this.$route.params.breweryId).then((resp) => {
          this.breweryInfo = resp.data;
          // this.showFavoritesButton = false;
        });
      // } else {
      //   api
      //     .getBreweryLoggedInUser(
      //       this.$store.state.user.userId,
      //       this.$route.params.breweryId
      //     )
      //     .then((resp) => {
      //       this.breweryInfo = resp.data;
      //       this.showFavoritesButton = true;
      //     });
      // }
    },
    checkIfUserIsLoggedIn(){
      if(this.$store.state.token != "")
      this.showFavoritesButton = true;
    },
    addToFavorite() {
      api.addFavoriteBrewery(this.breweryInfo, this.$store.state.user.userId).then(() => {
        this.breweryInfo.isFavorite = true;
        window.alert(
          `${this.breweryInfo.breweryName} has been added to your favorites!`
        );
      });
    },
    deleteFavorite(){
      api.deleteFavoriteBrewery(this.$store.state.user.userId, this.breweryInfo.breweryId)
        .then(() =>{
          this.breweryInfo.isFavorite = false;
          window.alert(
          `${this.breweryInfo.breweryName} has been removed from your favorites.`
          );
        });
    }
    // checkIfFavorite() {
    //   api.checkIfFavorite(this.$route.params.breweryId)
    //     .then((resp) => {
    //       this.isFavorite = resp.data;
    //     })
    //   }
    // },
  },
  created() {
     this.getBreweryInfo();
     this.checkIfUserIsLoggedIn();
  },
};
</script>

<style scoped>
button{
  max-height: 4em;
  max-width: 10em;
  font-size: .7em;
  margin-left: 0px;
}
#brewery-info-main{
  display: flex;
  flex-direction: column;
  margin-left: 10%;
}
.brewery-name{
  font-weight: bold;
  font-size: 30px;
  text-decoration: underline;
  font-variant: small-caps;
}

</style>