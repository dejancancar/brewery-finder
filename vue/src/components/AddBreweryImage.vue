<template>
<div>
      <vue-dropzone
        id="dropzone"
        class="mt-3"
        v-bind:options="dropzoneOptions"
        v-on:vdropzone-sending="addFormData"
        v-on:vdropzone-success="getSuccess"
        :useCustomDropzoneOptions="true">
        </vue-dropzone>
        <button @click="uploadBreweryImageUrl">Upload</button>
        <!-- <img v-bind:src="createdImageUrl"/> this was just to test that can load image by url after uploading -->
        </div>
</template>

<script>
/* eslint-disable */
import vue2Dropzone from "vue2-dropzone";
import "vue2-dropzone/dist/vue2Dropzone.min.css";
import api from "../services/apiService.js";

export default {
    name: "upload-photo",
    components: {
        vueDropzone: vue2Dropzone
    },
    data(){
        return {
            //-------------------------------------------------------------------------------------
            // TODO: substitute your actual Cloudinary cloud-name where indicated in the URL
            //-------------------------------------------------------------------------------------
            dropzoneOptions: {
                url: "https://api.cloudinary.com/v1_1/breweryfinderte/image/upload",  
                thumbnailWidth: 250,
                thumbnailHeight: 250,
                maxFilesize: 2.0,
                acceptedFiles: ".jpg, .jpeg, .png, .gif",
                uploadMultiple: false,
                addRemoveLinks: true,
                dictDefaultMessage: 'Drop files here to upload. </br> Alternatively, click to select a file for upload.',                
            }, 
            brewery:{
                breweryId: 1,
                imageUrl: "hello"
            } 
        }
    },

    methods:{
        /******************************************************************************************
         * The addFormData method is called when vdropzone-sending event is fired
         * it adds additional headers to the request
         ******************************************************************************************/
        //--------------------------------------------------------------------------------------------
        // TODO: substitute your actual Cloudinary api-key where indicated in the following code
        // TODO: substitute your actual Cloudinary upload preset where indicated in the following code
        //----------------------------------------------------------------------------==---------------   
        addFormData(file, xhr, formData) {
            formData.append("api_key", "261516181177151");  // substitute your api key
            formData.append("upload_preset", "kf7udt0t");   // substitute your upload preset
            formData.append("timestamp", (Date.now() / 1000) | 0);
            formData.append("tags", "vue-app");
        },
         /******************************************************************************************
         * The getSuccess method is called when vdropzone-success event is fired
         ******************************************************************************************/
        getSuccess(file, response) {
            const imgUrl = response.secure_url;   // store the url for the uploaded image
            this.brewery.imageUrl = imgUrl;
            this.$emit("image-upload", imgUrl);   // fire custom event with image url in case someone cares  
        },
        uploadBreweryImageUrl() {
            api.uploadBreweryImageUrl(this.brewery)
                .then((resp) => {
                    window.alert("image uploaded")
                })
        }
    }
}

</script>

<style>

</style>