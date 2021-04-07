<template>
  <div>
    <form>
    <h1>Update Brewery</h1> 
    <table>
      <tr>
        <td>Phone Number:</td>
        <td>
          <input type="text" v-model="updateBrewery.phone" />
        </td>
      </tr>
      <tr>
        <td>Street Address:</td>
        <td>
          <input type="text" v-model="updateBrewery.streetAddress" />
        </td>
      </tr>
      <tr>
          <td>City:</td>
          <td>
              <input type="text" v-model="updateBrewery.city" />
          </td>
      </tr>
      <tr>
          <td>State:</td>
          <td>
              <input type="text" v-model="updateBrewery.state" />
          </td>
      </tr>
      <tr>
          <td> Zip Code: </td>
          <td>
              <input type="text" v-model="updateBrewery.zipCode" />
          </td>
      </tr>
      <tr>
        <td>Brewery History:</td>
        <textarea type="text-area" v-model="updateBrewery.history" ></textarea>
      </tr>
      <tr>
          <td>Currently Active: </td>
          <select v-model="updateBrewery.toggleActive" >
              <option disabled value="">Select One</option>
              <option>Active</option>
              <option>Inactive</option>
          </select>
      </tr>

    </table>
    </form>
    <button @click="updateInfo">Update Info</button>
  </div>
</template>

<script>
import api from '../services/apiService.js'
export default {
  data() {
    return {
      updateBrewery: {
        phone: "",
        streetAddress: "",
        city:"",
        state: "",
        zipCode:"",
        history: "",
        toggleActive: "",
        
      },
    };

  },
  methods:{
      updateInfo(){
        api.updateInfo(this.updateBrewery)
            .then( (resp) =>{
                if(resp.status === 201){
                    this.city = resp.data;
                    window.alert('Information has been updated!')
                }})
      }
  }
  
};
</script>

<style scoped>
</style>