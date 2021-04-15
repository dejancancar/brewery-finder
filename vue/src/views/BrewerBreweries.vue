<template>
    <div class="container"> 
      <!-- <button class="big-button" type="button" @click="getBreweriesByBrewerId" v-show="showFormButton" >View Breweries</button> -->
      <!-- <table>
        <thead>
          <tr>
          <td>Brewery Id</td>
          <td>Brewery Name</td>
          <td>Brewery Address</td>
          </tr>
        </thead>
        <tbody>
          <tr v-for="brewery in breweries" :key="brewery.breweryId">
            <td>{{brewery.breweryId}}</td>
            <td><router-link :to="{name: 'update-brewery', params:{breweryId: brewery.breweryId}}">{{brewery.breweryName}}</router-link></td>
            <td>{{brewery.streetAddress}} {{brewery.city}} {{brewery.zipCode}}</td>
          </tr>
        </tbody> -->
        <ul >
          <li id="address-text" v-for="brewery in breweries" :key="brewery.breweryId">
            <router-link class="link" :to="{name: 'update-brewery', params:{breweryId: brewery.breweryId}}"><img id="tile-img" :src="brewery.defaultImageUrl" /> <p>{{brewery.breweryName}}</p>
            
             <span>{{brewery.streetAddress}} {{brewery.city}} {{brewery.zipCode}}</span>
            </router-link>
            
          </li>
        </ul>
        <!-- <button @click="cancelView" v-show="!showFormButton">Cancel</button> -->
      <!-- </table> -->
    </div>
</template>

<script>
import api from '../services/apiService.js';


export default {
  data() {
    return {
      showFormButton: true,
      breweries:[],
    };
  },
  methods: {
    getBreweriesByBrewerId(){
      // this.showFormButton = false;
      api.getBreweriesByBrewerId(this.$store.state.user.userId)
        .then( (resp) => {
          this.breweries = resp.data;
        })
    },
    cancelView(){
      this.showFormButton = true;
    }
  },
  components: {

  },
  created() {
    //check to make sure the user attempting to access this route is a brewer only
    if (this.$store.state.user.role != "brewer") {
      this.$router.push("/");
    }
    this.getBreweriesByBrewerId();
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
#tile-img:hover{
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
span{
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

</style>