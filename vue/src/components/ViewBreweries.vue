<template>
  <div>
      <h1>Breweries</h1>
      <div class="container">
      <ul class="all-breweries">
          <li class="breweries" v-for="brewery in breweries" :key="brewery.breweryId">
              <router-link class="link" :to="{ name: 'brewery', params: { breweryId: brewery.breweryId }}">{{brewery.breweryName}} </router-link>
              <div>{{brewery.streetAddress}} {{brewery.city}} {{brewery.zipCode}} {{brewery.phone}}</div></li>
      </ul>
      </div>
  </div>
</template>

<script>
import api from "../services/apiService.js"
export default {
    name: "viewBreweries",
    data(){
        return{
            breweries:[],
        }
    },
    methods:{
        getBreweries(){
            api.getBreweries()
                .then( (resp) => {
                    this.breweries = resp.data;
                })
        },
    },
    created(){
        this.getBreweries();
    }
}
</script>

<style scoped>
.container{
    display: grid;
    align-items: center;
}
ul {
    display: flex;
    flex-wrap:wrap;
    flex-direction: row;
    justify-content: center;
}   
li {
    background-color: white;
    border: 1px solid grey;
    border-radius: 5px;
    padding: 20px;
    list-style-type: none;
    width: 390px;
    height: 250px;
    margin: 2%;
    align-content:space-around;
}
.link{
      color: #d29f13;
      text-decoration: none;
}
.link:hover{
    text-decoration: underline;
}
@media(max-width: 1024px) {
    li{
        width: 340px;
        height: 200px;
    }
}

@media(max-width: 425px) {
    li{
        width: 340px;
        height: 200px;
    }

}
</style>