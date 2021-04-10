<template>
    <div>
        <update-brewery></update-brewery>
        <update-hours />
        <upload-images />
    </div>
</template>

<script>
import UpdateBrewery from '../components/UpdateBrewery.vue'
import UpdateHours from '../components/UpdateBreweryHours.vue'
import UploadImages from '../components/AddBreweryImage.vue'
export default {
    data(){
        return {
            
        }
    },
    components:{
        UpdateBrewery,
        UpdateHours,
        UploadImages,
    },

}
</script>

<style>

</style>