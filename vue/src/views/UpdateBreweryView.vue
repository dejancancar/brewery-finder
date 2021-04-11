<template>
    <div>
        <update-brewery></update-brewery>
        <update-hours />
        <upload-images />
        <add-beer />
    </div>
</template>

<script>
import UpdateBrewery from '../components/UpdateBrewery.vue'
import UpdateHours from '../components/UpdateBreweryHours.vue'
import UploadImages from '../components/AddBreweryImage.vue'
import AddBeer from '../components/AddBeer.vue'
export default {
    data(){
        return {
            
        }
    },
    components:{
        UpdateBrewery,
        UpdateHours,
        UploadImages,
        AddBeer
    },

}
</script>

<style>

</style>