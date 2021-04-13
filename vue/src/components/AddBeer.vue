<template>
  <div >
    <h2>Beers</h2>
    <button v-show="!toggleAddBeer" @click="toggleAddBeer = true">Add Beer</button>

    <form v-show="toggleAddBeer">
      <table id="add-beer-table">
        <tr>
          <td>Beer Name:</td>
          <td>
            <input type="text" v-model="newBeer.beerName" />
          </td>
        </tr>
        <tr>
          <td>Description:</td>
          <td>
            <textarea
              cols="30"
              rows="10"
              v-model="newBeer.description"
            ></textarea>
          </td>
        </tr>
        <tr>
          <td>ABV:</td>
          <td>
            <input type="number" step=".1" min="0" max="100" v-model="newBeer.abv" value="0.00"/>
          </td>
        </tr>
        <tr>
          <td>Beer Type:</td>
          <td>
            <input type="text" v-model="newBeer.beerType" />
          </td>
        </tr>
        <tr>
          <td>Currently on Tap:</td>
          <td>
            <select v-model="newBeer.isActive">
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
      <button @click="addBeer">Submit</button>
      <button @click="toggleAddBeer = false">Cancel</button>
    </form>
    <!-- <brewery-beers /> -->
  </div>
</template>

<script>
// import BreweryBeers from "./DisplayBreweryBeers.vue";
import vue2Dropzone from "vue2-dropzone";
import "vue2-dropzone/dist/vue2Dropzone.min.css";
import api from "../services/apiService.js";

export default {
  data() {
    return {
      newBeer: {
        breweryId: this.$route.params.breweryId,
        beerName: "",
        imageUrl: "",
        abv: "",
        beerType: "",
        isActive: true,
      },
      toggleAddBeer: false,
      dropzoneOptions: {
        url: "https://api.cloudinary.com/v1_1/breweryfinderte/image/upload",
        thumbnailWidth: 250,
        thumbnailHeight: 250,
        maxFilesize: 2.0,
        acceptedFiles: ".jpg, .jpeg, .png, .gif",
        uploadMultiple: false,
        addRemoveLinks: true,
        dictDefaultMessage:
          "Drop files here to upload. </br> Alternatively, click to select a file for upload.",
      },
    };
  },
  components: {
    vueDropzone: vue2Dropzone,
    // BreweryBeers,
  },
  methods: {
    addBeer() {
      api.addBeer(this.newBeer).then(() => {
        this.newBeer = {};
      });
    },
    /******************************************************************************************
     * The addFormData method is called when vdropzone-sending event is fired
     * it adds additional headers to the request
     ******************************************************************************************/
    //--------------------------------------------------------------------------------------------
    // TODO: substitute your actual Cloudinary api-key where indicated in the following code
    // TODO: substitute your actual Cloudinary upload preset where indicated in the following code
    //----------------------------------------------------------------------------==---------------
    addFormData(file, xhr, formData) {
      formData.append("api_key", "261516181177151"); // substitute your api key
      formData.append("upload_preset", "kf7udt0t"); // substitute your upload preset
      formData.append("timestamp", (Date.now() / 1000) | 0);
      formData.append("tags", "vue-app");
    },
    /******************************************************************************************
     * The getSuccess method is called when vdropzone-success event is fired
     ******************************************************************************************/
    getSuccess(file, response) {
      const imgUrl = response.secure_url; // store the url for the uploaded image
      this.newBeer.imageUrl = imgUrl;
      this.$emit("image-upload", imgUrl); // fire custom event with image url in case someone cares
    },
  },
};
</script>

<style scoped>
.brewery-beers {
    max-height: 320px;
    padding-bottom: 0px;
}
#add-beer-table{
  margin-top:269px
}
</style>
