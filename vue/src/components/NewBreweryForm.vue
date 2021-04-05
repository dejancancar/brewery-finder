<template>
  <div>
    <form class="newBrewery" v-on:submit.prevent="addBrewery">
      <div>
        <label for="breweryName">Enter Brewery Name:</label>
        <input type="text" class="form-look" v-model="brewery.name" />
        <div class="form-group">

        </div>
        <button class="btn btn-submit" >Submit</button>
        <button class="btn btn-cancel" v-on:click.prevent="cancelForm">Cancel</button>
      </div>
    </form>
  </div>
</template>

<script>
import api from '../services/AuthService.js';
export default {
  name: 'new-brewery-form',
  data(){
    return{
      brewery:{
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
          }});
    },
    cancelForm(){
      this.$router.push('/');
    }
  }

}
</script>

<style scoped>

</style>