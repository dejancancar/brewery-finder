<template>
  <div>
    <table>
      <h1>Brewery Info</h1>
      <tr>
        <td>Name:</td>
        <td>{{brewery.name}}</td>
      </tr>
      <tr>
        <td>Address: </td>
        <td>{{brewery.streetAddress}}, {{brewery.city}} {{brewery.zipCode}}</td>
      </tr>
      <tr>
        <td>Phone: </td>
        <td>{{brewery.phone}}</td>
      </tr>
      <tr>
        <td>History: </td>
        <td>{{brewery.history}}</td>
      </tr>
      <tr>
        <td>Status: </td>
        <td>{{brewery.isActive ? "Active" : "Inactive"}}</td>
      </tr>
    </table>

    <table>
      <tr>
        <td>Day: </td>
        <td>Open Time: </td>
        <td>Closing Time: </td>
        <td></td>
      </tr>
      <tr>
        <td></td>
      </tr>
      <tr>
        <td></td>
      </tr>
    </table>

    <h1>Update Brewery</h1> 
    <button type="button" v-on:click="toggleUpdateBrewery = true" v-show="!toggleUpdateBrewery">Show Brewery</button>
    <form v-show="toggleUpdateBrewery">
    <table>
      <tr>
        <td>Name: </td>
        <td><input type="text" v-model="updateBrewery.name" /></td>
      </tr>
      <tr>
        <td>Phone Number: </td>
        <td>
          <input type="text" v-model="updateBrewery.phone" />
        </td>
      </tr>
      <tr>
        <td>Street Address: </td>
        <td>
          <input type="text" v-model="updateBrewery.streetAddress" />
        </td>
      </tr>
      <tr>
          <td>City: </td>
          <td>
              <input type="text" v-model="updateBrewery.city" />
          </td>
      </tr>
      <tr>
          <td> Zip Code: </td>
          <td>
              <input type="text" v-model="updateBrewery.zipCode" />
          </td>
      </tr>
      <tr>
        <td>Brewery History: </td>
        <textarea type="text-area" v-model="updateBrewery.history" ></textarea>
      </tr>
      <tr>
          <td>Currently Active: </td>
          <select v-model="updateBrewery.isActive" >
              <option value=true>Active</option>
              <option value=false>Inactive</option>
          </select>
      </tr>

    </table>
    <button @click="updateBreweryInfo">Update Info</button>
    <button @click="toggleUpdateBrewery = false">Cancel Update</button>
    </form>
    <div>
    <h1>Update Brewery Hours</h1>
    <button type="button" @click="toggleUpdateHours = true" v-show="!toggleUpdateHours" >Update Hours</button>
    <hours v-show="toggleUpdateHours" />
    </div>
  </div>
</template>

<script>
import api from '../services/apiService.js'
import hours from '../components/UpdateBreweryHours.vue'
export default {
  data() {
    return {
      //brewery that gets sent to server and info to update it.
      updateBrewery: {
        breweryId:0,
        userId: 0,
        name: "",
        phone: "",
        streetAddress: "",
        city:"",
        zipCode:"",
        history: "",
        // sets it to a string. Make sure there's no error server side
        isActive: true,
        
      },
      //brewery information to display to user
      brewery: {
      },
      toggleUpdateBrewery: false,
      toggleUpdateHours: false,
    };

  },
  components:{
    hours
  },
  computed:{

  },
  methods:{
      updateBreweryInfo(){
        api.updateBreweryInfo(this.updateBrewery)
            .then( (resp) =>{
                if(resp.status === 200){
                    this.updateBrewery = resp.data;
                    window.alert('Information has been updated!')
                    this.$router.go();
                }})

      },
      getBreweryById(){
        api.getBreweryById(this.$route.params.breweryId)
          .then( (resp) => {
            //todo if response is bad request add error catch
            this.brewery = resp.data;
              this.updateBrewery = Object.assign({},this.brewery);
          })
        
      },

      // cancelUpdate(){
      //   this.$router.push(`/brewerdashboard`)
      // }
  },
  created(){
    this.getBreweryById();
    if (this.$store.state.user.role != "brewer") {
      this.$router.push("/");
    }
  }

  
};
</script>

<style scoped>
</style>