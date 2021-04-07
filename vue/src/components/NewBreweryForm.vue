<template>
  <div>
    <form class="newBrewery" v-on:submit.prevent="addBrewery">
      <div>
        <div>
        <label for="breweryName">Enter Brewery Name:</label>
        <input type="text" class="form-look" v-model="brewery.name" />
        </div>
        <div>
        <button type="button" class="btn btn-submit" >Submit Brewery</button>
        <button type="button" class="btn btn-cancel" v-on:click.prevent="cancelForm">Cancel</button>
        </div>
      </div>
    </form>
  </div>
</template>

<script>
import api from '../services/AuthService.js';
// import user from '../views/User.vue'
export default {
  name: 'new-brewery-form',
  props:{
    userId: Number
  },
  data(){
    return{
      brewery:{
        breweryId:0,
        name:"",
        userId: "",
      },
    };
  },
  methods:{
    addBrewery(){
      api.addBrewery(this.brewery)
        .then( (resp) => {
          if(resp.status === 201){
            this.brewery = resp.data
            window.alert(`A new brewery with the ID# ${this.brewery.breweryId} has been added.`)
          }});
    },
    cancelForm(){
      this.$router.push('/');
    },
  },
  created(){
    this.brewery.userId = this.userId
  },

}
</script>

<style scoped>

</style>