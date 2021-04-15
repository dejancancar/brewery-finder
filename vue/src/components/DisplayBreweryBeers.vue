<template>
  <div>
    <ul>
      <li v-for="beer in activeBeer" :key="beer.beerId">
        <router-link id="beer-row" :to="{name: 'beer', params: {beerId: beer.beerId }}">

        
        <span id="beer-decoration"><img class="image" :src="beer.imageUrl" alt="Beer Picture" />
        <h2 id="beer-name">{{ beer.beerName }}</h2></span>
        <div id="brewer-on-tap" v-if="showOnTapBrewer"><span id="currently-on-tap">Currently on tap:</span><span id="on-tap"> {{beer.isActive ? "Yes" : "No"}}</span></div>
        </router-link>
      </li>
      <li></li>
      
    </ul>
  </div>
</template>

<script>
import api from "../services/apiService.js";
export default {
  data() {
    return {
      beers: [],
      showOnTapBrewer: false,
    };
  },
  computed:{
      activeBeer(){
        if(this.$route.name === 'brewery'){
          return this.beers.filter( (beer) => {
            return beer.isActive === true;
          }) 
      }
      return this.beers;
      
    }
  },
  methods: {
    getBeers() {
      api.getBeers(this.$route.params.breweryId).then((resp) => {
        this.beers = resp.data;
      });
    },
    //if on brewer page, beers display whether active or not. If on user page only displays beer
    updateInfoOnly(){
      if(this.$route.name === 'update-brewery'){
         this.showOnTapBrewer = true;
      }


    },

  },
  created() {
    this.getBeers();
    this.updateInfoOnly();
  },
};
</script>

<style scoped>
ul{
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
}
li {
  height: 40vh;
  flex-grow: 1;
  margin-top: 2%;
  margin-bottom: 2%;
  list-style-type: none;
}

img {
  max-height: 100%;
  min-width: 100%;
  object-fit: cover;
  vertical-align: bottom;
  
}
#beer-name{
  display: flex;
  justify-content: center;
  margin-top: 1%;
  margin-bottom: 0px;
}
#beer-decoration:hover{
  text-decoration: underline;
}
#beer-row{
  text-decoration: none;
  font-size: 75%;
  color: #e0af1f;
  font-variant: small-caps;  
  
}

#beer-row:hover{
  opacity: 50%;
}
li:last-child{
  flex-grow: 100;
}
#currently-on-tap{
  color: black;
  font-size: 14px;
  font-weight: bold;
}
#on-tap{
  color: red;
  font-size: 14px;
  margin-left: 5px;
}
#brewer-on-tap{
  display: flex;
  justify-content: center;
  margin-top: 0px;
  font-weight: bold;

}

  
</style>