<template>
  <div>
    <button v-show="!toggleUpdateBeer" @click="getBeerList">
      Update Beer
    </button>
    <select v-show="toggleUpdateBeer" v-model="updatedBeer">
      <option v-for="beer in currentBeers" :key="beer.beerId" :value="beer" >
        {{beer.beerName}}
      </option>
    </select>

    <form v-show="toggleUpdateBeer" >
      <table>
        <tr>
          <td>Beer Name:</td>
          <td>
            <input type="text" v-model="updatedBeer.beerName" />
          </td>
        </tr>
        <tr>
          <td>Description:</td>
          <td>
            <textarea
              cols="30"
              rows="10"
              v-model="updatedBeer.description"
            ></textarea>
          </td>
        </tr>
        <tr>
          <td>ABV:</td>
          <td>
            <input type="number" step=".1" min="0" max="100" v-model="updatedBeer.abv" value="0.00"/>
          </td>
        </tr>
        <tr>
          <td>Beer Type:</td>
          <td>
            <input type="text" v-model="updatedBeer.beerType" />
          </td>
        </tr>
        <tr>
          <td>Currently on Tap:</td>
          <td>
            <select v-model="updatedBeer.isActive">
              <option value="true">Yes</option>
              <option value="false">No</option>
            </select>
          </td>
        </tr>
        <tr>
          <td>Image URL:</td>
          <td>
            <!-- <vue-dropzone
              id="dropzone"
              class="mt-3"
              v-bind:options="dropzoneOptions"
              v-on:vdropzone-sending="addFormData"
              v-on:vdropzone-success="getSuccess"
              :useCustomDropzoneOptions="true"
            ></vue-dropzone> -->
          </td>
        </tr>
      </table>
      <button @click="updateBeer">Submit</button>
      <button @click="toggleUpdateBeer = false">Cancel</button>
    </form>
  </div>
</template>

<script>
import api from "../services/apiService.js";
export default {
  data() {
    return {
      updatedBeer: {
        breweryId: this.$route.params.breweryId,
        beerId: "",
        beerName: "",
        imageUrl: "",
        abv: "",
        beerType: "",
        isActive: true,
      },
      toggleUpdateBeer: false,
      currentBeers: [],
      
    };
  },
  methods: {
    updateBeer() {
      api.updateBeer(this.updatedBeer).then(() => {
        window.alert(`${this.updatedBeer.beerName} has been updated.`);
      });
    },
    getBeerList() {
        this.toggleUpdateBeer = true;
      api.getBeers(this.$route.params.breweryId).then((resp) => {
        this.currentBeers = resp.data;
      });
    },
    created() {

    },
    
  },
};
</script>

<style>
</style>