<template>
    <div>
        <update-brewery-basic-info/>
        <update-hours />
        <upload-images />
        <add-beer />
    </div>
</template>

<script>
import UpdateBreweryBasicInfo from '../components/UpdateBreweryBasicInfo.vue'
import UpdateHours from '../components/UpdateBreweryHours.vue'
import UploadImages from '../components/AddBreweryImage.vue'
import AddBeer from '../components/AddBeer.vue'
export default {
    data(){
        return {
            
        }
    },
    components:{
        UpdateBreweryBasicInfo,
        UpdateHours,
        UploadImages,
        AddBeer
    },

}
</script>

<style>

</style>