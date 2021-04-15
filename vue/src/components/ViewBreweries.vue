<template>
  <div>
    <div class="container">
      <h1>Breweries</h1>
      <ul class="all-breweries">
        <li
          class="breweries"
          v-for="brewery in breweries"
          :key="brewery.breweryId"
        >
          <div id="address-text">
            <router-link
              class="link"
              :to="{
                name: 'brewery',
                params: { breweryId: brewery.breweryId },
              }"
              ><img id="tile-img" :src="brewery.defaultImageUrl" />
              <p>
                {{ brewery.breweryName }}
                <img
                  v-show="brewery.isFavorite"
                  id="favorite-img"
                  src="../images/star.png"
                  alt=""
                />
              </p>
              <span
                >{{ brewery.streetAddress }} {{ brewery.city }}
                {{ brewery.zipCode }} {{ brewery.phone }}</span
              >
            </router-link>
            <div></div>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import api from "../services/apiService.js";
export default {
  name: "viewBreweries",
  data() {
    return {
      breweries: [],
    };
  },
  methods: {
    getBreweries() {
      if (this.$store.state.token === "") {
        api.getBreweries().then((resp) => {
          this.breweries = resp.data;
        });
      } else {
        api
          .getBreweriesLoggedInUser(
            this.$store.state.user.userId
            // this.$route.params.breweryId
          )
          .then((resp) => {
            this.breweries = resp.data;
            // this.showFavoritesButton = true;
          });
      }
    },
  },
  created() {
    this.getBreweries();
  },
};
</script>

<style scoped>
.container {
  display: grid;
  align-items: center;
}
ul {
  display: flex;
  flex-wrap: wrap;
  flex-direction: row;
  justify-content: center;
}
li {
  background-color: white;
  border: 1px solid grey;
  border-radius: 5px;
  list-style-type: none;
  width: 390px;
  height: 350px;
  margin: 2%;
  align-content: space-around;
}
#tile-img {
  width: 100%;
  height: 100%;
  image-rendering: auto;
  image-rendering: crisp-edges;
  image-rendering: pixelated;
  border-radius: 5px 5px 0px 0px;
}
#tile-img:hover {
  opacity: 50%;
}
p {
  text-decoration: underline;
  margin: 0px 0px 0px 5px;
  font-size: 20px;
  display: flex;
  justify-content: space-between;
  margin: 0px 5px;
}
span {
  margin-left: 5px;
  color: black;
}

#address-text {
  border: 1px solid grey;
  height: 80%;
  border-radius: 5px 5px 0px 0px;
}
.link {
  color: #d29f13;
  text-decoration: none;
}
.link:hover {
  text-decoration: none;
}
h1 {
  display: flex;
  justify-content: center;
  margin: 40px 0px 15px 0px;
}
#favorite-img {
  max-height: 8%;
  max-width: 8%;
  /* border: thin solid black;
  border-radius: 25%;
  background-color: black;
  opacity: 95%; */
}
/* #favorite-img:hover{
  opacity: 100%;
} */
@media (max-width: 1024px) {
  li {
    width: 340px;
    height: 200px;
  }
}

@media (max-width: 425px) {
  li {
    width: 340px;
    height: 200px;
  }
}
</style>