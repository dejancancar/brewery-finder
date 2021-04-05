<template>
    <div>
      <h1>
        Add New Brewery
        <new-brewery-form />
      </h1>
    </div>
</template>

<script>
import NewBreweryForm from '../components/NewBreweryForm.vue'
export default {
    name: 'add-brewery',
    components: {
       NewBreweryForm
    }

}
</script>

<style>

</style>