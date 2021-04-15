<template>
  <div>
    <button v-show="!toggleUpdateBeer" @click="getBeerList">Update Beer</button>
    <span id="select-names" v-show="toggleUpdateBeer"
      >Select to Update
      <div>
        <select v-model="updatedBeer">
          <option v-for="beer in currentBeers" :key="beer.beerId" :value="beer">
            {{ beer.beerName }}
          </option>
        </select>
      </div>
    </span>
    <form v-show="toggleUpdateBeer">
      <table>
        <tr id="select-names">
          <td>Beer Name</td>
        </tr>
        <tr>
          <td>
            <input type="text" v-model="updatedBeer.beerName" />
          </td>
        </tr>
        <tr id="select-names">
          <td>Description</td>
        </tr>
        <tr>
          <td>
            <textarea
              cols="30"
              rows="10"
              v-model="updatedBeer.description"
            ></textarea>
          </td>
        </tr>
        <tr id="select-names">
          <td>ABV</td>
        </tr>
        <tr>
          <td>
            <input
              id="abv-input"
              type="number"
              step=".1"
              min="0"
              max="100"
              v-model="updatedBeer.abv"
              value="0.00"
            />
          </td>
        </tr>
        <tr id="select-names">
          <td>Beer Type</td>
        </tr>
        <tr>
          <td>
            <input type="text" v-model="updatedBeer.beerType" />
          </td>
        </tr>
        <tr>
          <td id="select-names">Currently on Tap</td>
        </tr>
        <tr>
          <td>
            <select v-model="updatedBeer.isActive">
              <option value="true">Yes</option>
              <option value="false">No</option>
            </select>
          </td>
        </tr>
        <tr id="select-names">
          <td>Image URL</td>
        </tr>
        <tr>
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
import api from "../services/apiService.js";
import vue2Dropzone from "vue2-dropzone";
import "vue2-dropzone/dist/vue2Dropzone.min.css";
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
    created() {},
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
#abv-input {
  width: 15%;
  padding-left: 15px;
  font-size: 20px;
}
#text-area-td {
  height: 100%;
  width: 100%;
}
input {
  width: 100%;
}
/* .brewery-beers {
    max-height: 320px;
    padding-bottom: 0px;
}
#add-beer-table{
  margin-top:269px
} */
h2 {
  font-size: 40px;
  margin-top: 0px;
}
#select-names {
  font-weight: bold;
  font-size: 17px;
  margin-right: 3px;
}
select,
input {
  padding-left: 3px;
  font-size: 16px;
  color: #000000;
  background-color: #ffffff;
  background-image: none;
  border: 1px solid #dfd7ca;
  border-radius: 4px;
  height: 40px;
  margin-left: 6px;
}
textarea {
  padding-left: 3px;
  font-size: 16px;
  color: #000000;
  background-color: #ffffff;
  background-image: none;
  border: 1px solid #dfd7ca;
  border-radius: 4px;
  height: 40px;
  margin-left: 6px;
  height: 150px;
  width: 100%;
}
</style>