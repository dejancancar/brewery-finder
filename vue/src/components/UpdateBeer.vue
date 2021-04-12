<template>
<div>
    <!-- <button v-show="!toggleUpdateBeer" @click="toggleUpdateBeer = true">Update Beer</button> -->

    <form  v-show="toggleUpdateBeer">
      <table>
        <tr>
          <td>Beer Name:</td>
          <td>
            <input type="text" v-model="updateBeer.beerName" />
          </td>
        </tr>
        <tr>
          <td>Description:</td>
          <td>
            <textarea
              cols="30"
              rows="10"
              v-model="updateBeer.description"
            ></textarea>
          </td>
        </tr>
        <tr>
          <td>ABV:</td>
          <td>
            <input type="text" v-model="updateBeer.abv" />
          </td>
        </tr>
        <tr>
          <td>Beer Type:</td>
          <td>
            <input type="text" v-model="updateBeer.beerType" />
          </td>
        </tr>
        <tr>
          <td>Currently on Tap:</td>
          <td>
            <select v-model="updateBeer.isActive">
              <option value="true">Yes</option>
              <option value="false">No</option>
            </select>
          </td>
        </tr>
        <tr>
          <td>Image URL:</td>
          <td>
            <vue-dropzone
              id="dropzone"
              class="mt-3"
              v-bind:options="dropzoneOptions"
              v-on:vdropzone-sending="addFormData"
              v-on:vdropzone-success="getSuccess"
              :useCustomDropzoneOptions="true"
            ></vue-dropzone>
          </td>
        </tr>
      </table>
      <button @click="updateBeer">Submit</button>
      <button @click="toggleUpdateBeer = false">Cancel</button>
    </form>
  </div>
</template>

<script>
export default {
    data(){
        return{
            updateBeer:{
                breweryId: this.$route.params.breweryId,
                beerId: "",
                beerName: "",
                imageUrl: "",
                abv: "",
                beerType: "",
                isActive: true,

            },
            toggleUpdateBeer: false,
        }
    },
    methods:{
        //TODO write beer method
        updateBeer(){

        },
        //TODO write getbeer by id method
        getBeerById(){

        },
    }
}
</script>

<style>

</style>