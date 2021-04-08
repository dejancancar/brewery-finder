<template>
    <div>
        <update-brewery v-show="!showFormButton"></update-brewery>
    </div>
</template>

<script>
import UpdateBrewery from '../components/UpdateBrewery.vue'
export default {
    components:{
        UpdateBrewery
    }
}
</script>

<style>

</style>