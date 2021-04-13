<template>
  <div>
    <table>
      <h1>Brewery Info</h1>
      <tr>
        <td>Name:</td>
        <td>{{ brewery.breweryName }}</td>
      </tr>
      <tr>
        <td>Address:</td>
        <td>
          {{ brewery.streetAddress }}, {{ brewery.city }} {{ brewery.zipCode }}
        </td>
      </tr>
      <tr>
        <td>Phone:</td>
        <td>{{ brewery.phone }}</td>
      </tr>
      <tr>
        <td>Status:</td>
        <td>{{ brewery.isActive ? "Active" : "Inactive" }}</td>
      </tr>
      <tr>
        <td>History:</td>
        <td>{{ brewery.history }}</td>
      </tr>
    </table>

    <button
      class="medium-button"
      type="button"
      v-on:click="toggleUpdateBrewery = true"
      v-show="!toggleUpdateBrewery"
    >
      Update Info
    </button>
    <form v-show="toggleUpdateBrewery">
      <table>
        <tr>
          <td>Name:</td>
          <td><input type="text" v-model="updateBrewery.breweryName" /></td>
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
          <td>Zip Code:</td>
          <td>
            <input type="text" v-model="updateBrewery.zipCode" />
          </td>
        </tr>
        <tr>
          <td>Phone Number:</td>
          <td>
            <input type="text" v-model="updateBrewery.phone" />
            <div>Format: 123-456-7890</div>
          </td>
        </tr>
        <tr>
          <td>Currently Active:</td>
          <select v-model="updateBrewery.isActive">
            <option value="true">Active</option>
            <option value="false">Inactive</option>
          </select>
        </tr>
        <tr>
          <td>Brewery History:</td>
          <textarea type="text-area" v-model="updateBrewery.history"></textarea>
        </tr>
      </table>
      <button @click.prevent="updateBreweryInfo">Update Info</button>
      <button @click="toggleUpdateBrewery = false">Cancel Update</button>
    </form>
  </div>
</template>

<script>
import api from "../services/apiService.js";
export default {
  data() {
    return {
      //brewery that gets sent to server and info to update it.
      updateBrewery: {
        breweryId: 0,
        userId: 0,
        breweryName: "",
        phone: "",
        streetAddress: "",
        city: "",
        zipCode: "",
        history: "",
        // sets it to a string. Make sure there's no error server side
        isActive: true,
      },
      //brewery information to display to user
      brewery: {},
      toggleUpdateBrewery: false,
      checkZip: "",
    };
  },
  components: {},
  computed: {},
  methods: {
    updateBreweryInfo() {
      if (this.validateZip()) {
        if (this.validatePhone()) {
          api.updateBreweryInfo(this.updateBrewery).then((resp) => {
            if (resp.status === 200) {
              this.updateBrewery = resp.data;
              window.alert("Information has been updated!");
              this.$router.go();
            }
          });
        } else {
          window.alert(
            "Please enter a valid phone number. See format for example."
          );
        }
      } else {
        window.alert("Please enter a valid 5 digit zip code.");
      }
    },
    validateZip() {
      let validZip = /^([0-9]{5})?$/.test(this.updateBrewery.zipCode);
      if (validZip) {
        return true;
      } else {
        return false;
      }
    },
    validatePhone() {
      let validPhone = /^([0-9]{3}-[0-9]{3}-[0-9]{4})?$/.test(
        this.updateBrewery.phone
      );
      if (validPhone) {
        return true;
      } else {
        return false;
      }
    },
    getBreweryById() {
      api.getBreweryById(this.$route.params.breweryId).then((resp) => {
        //todo if response is bad request add error catch
        this.brewery = resp.data;
        this.updateBrewery = Object.assign({}, this.brewery);
      });
    },

    // cancelUpdate(){
    //   this.$router.push(`/brewerdashboard`)
    // }
  },
  created() {
    this.getBreweryById();
    if (this.$store.state.user.role != "brewer") {
      this.$router.push("/");
    }
  },
};
</script>

<style scoped>
</style>