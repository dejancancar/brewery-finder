<template>
    <div>
        <update-brewery-basic-info/>
        <update-hours />
        <upload-images />   
        <span class="update-beer">  
            <add-beer />
            <update-beer />
            <display-brewery-beers />
        </span>
    </div>
</template>

<script>
import UpdateBreweryBasicInfo from '../components/UpdateBreweryBasicInfo.vue'
import UpdateHours from '../components/UpdateBreweryHours.vue'
import UploadImages from '../components/AddBreweryImage.vue'
import AddBeer from '../components/AddBeer.vue'
import UpdateBeer from '../components/UpdateBeer.vue'
import DisplayBreweryBeers from '../components/DisplayBreweryBeers.vue'
export default {
    data(){
        return {
            
        }
    },
    components:{
        UpdateBreweryBasicInfo,
        UpdateHours,
        UploadImages,
        AddBeer,
        UpdateBeer,
        DisplayBreweryBeers
    },

}
</script>

<style>

</style>