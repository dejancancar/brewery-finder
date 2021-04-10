<template>
  <div>
    <h1>Details</h1>
    <table>
      <tr>
        <td>UserId:</td>
        <td>{{ user.userId }}</td>
      </tr>
      <tr>
        <td>Username:</td>
        <td>{{ user.username }}</td>
      </tr>
    </table>
    <table>
      <tr>
        <button type="button" @click="addUserIdToBrewerId" v-show="!toggleForm">
          Add New Brewery
        </button>
      </tr>
    </table>
    <div v-show="toggleForm">
      <form class="newBrewery" v-on:submit.prevent="createBrewery">
        <div>
          <div>
            <label for="breweryName">Enter Brewery Name:</label>
            <input type="text" class="form-look" v-model="brewery.breweryName" />
          </div>
          <div>
            <button type="submit" class="btn btn-submit">Submit Brewery</button>
            <button
              type="button"
              class="btn btn-cancel"
              v-on:click.prevent="cancelForm"
            >
              Cancel
            </button>
          </div>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import api from "../services/apiService.js";
export default {
  name: "user",
  data() {
    return {
      //Returns info for the user selected from the server
      user: {
        userId: 0,
        username: "",
      },
      brewery: {
        breweryId: 0,
        breweryName: "",
        userId: 0,
      },
      toggleForm: false,
    };
  },
  methods: {
    //Gets info for the user selected by admin so the userId can be associated with the brewery.
    getUser(username) {
      api.getUsers(username).then((resp) => {
        this.user = resp.data[0];
      });
    },
    //Adds userId to brewerId so when a new brewery is created, the selected userId is transfered, not the logged in user.
    addUserIdToBrewerId() {
      this.toggleForm = true;
      return (this.brewery.userId = this.user.userId);
    },
    createBrewery() {
      api.createBrewery(this.brewery).then((resp) => {
        if (resp.status === 201) {
          this.brewery = resp.data;
          window.alert(
            `A new brewery with the ID# ${this.brewery.breweryId} has been added.`
          );
          this.$router.push("/users");
        }
      })
      
    },
    cancelForm() {
      this.$router.push("/");
    },
  },
  created() {
    //Checks to see if the user is an admin, if not it reroutes them to home.
    if (this.$store.state.user.role != "admin") {
      this.$router.push("/");
    }
    this.getUser(this.$route.params.username);
  },
};
</script>

<style>
</style>