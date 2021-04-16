<template>
  <div class="container">
    <h1>Details</h1>
        <h3>UserId: {{ user.userId }}</h3>
        <h3>Username: {{ user.username }}</h3>
        <button type="button" @click="addUserIdToBrewerId" v-show="!toggleForm">
          Add New Brewery
        </button>
    <div v-show="toggleForm">
      <form class="newBrewery" v-on:submit.prevent="createBrewery">
            <div><label for="breweryName">Enter Brewery Name</label></div>
            <input type="text" class="form-look" v-model="brewery.breweryName" autofocus />
            <div class="both-buttons"><button type="submit" class="btn btn-submit">Submit Brewery</button>
            <button
              type="button"
              class="btn btn-cancel"
              v-on:click.prevent="cancelForm"
            >
              Cancel
            </button></div>
            <!-- i dont like how cancel redirects us to home -todd -->
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
          this.$router.push("/admin/users");
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

<style scoped>
.container{
  margin-top: 8%;
  margin-left: 3%;
}
h1{
  font-size: 40px;
  font-weight: bold;
}
button{
  margin-left: 0;
}
input {
  padding-left: 3px;
  font-size: 16px;
  color: #000000;
  background-color: #ffffff;
  background-image: none;
  border: 1px solid #dfd7ca;
  border-radius: 4px;
  height: 40px;
  width: 20%;

}
label {
  font-weight: bold;
  font-size: 17px;
  margin-right: 3px;
}

</style>