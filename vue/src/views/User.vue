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
        <button type="button" @click="addUserIdToBrewerId" v-show="!addBrewery">
          Add New Brewery
        </button>
        <!-- <new-brewery :userId="brewery.userId" v-show="addBrewery" /> -->
      </tr>
    </table>
    <div v-show="addBrewery">
      <form class="newBrewery" v-on:submit.prevent="createBrewery">
        <div>
          <div>
            <label for="breweryName">Enter Brewery Name:</label>
            <input type="text" class="form-look" v-model="brewery.name" />
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
import api from "../services/AuthService.js";
// import newBrewery from "../components/NewBreweryForm.vue";
export default {
  name: "user",

  //   components: {
  //     newBrewery,
  //   },

  data() {
    return {
      user: {
        userId: 0,
        username: "",
      },
      brewery: {
        breweryId: 0,
        name: "",
        userId: 0,
      },
      addBrewery: false,
    };
  },
  methods: {
    getUser(username) {
      api.getUsers(username).then((resp) => {
        this.user = resp.data[0];
      });
    },
    addUserIdToBrewerId() {
      this.addBrewery = true;
      return (this.brewery.userId = this.user.userId);
    },
    createBrewery() {
      api.createBrewery(this.brewery, this.$store.state.token).then((resp) => {
        if (resp.status === 201) {
          this.brewery = resp.data;
          window.alert(
            `A new brewery with the ID# ${this.brewery.breweryId} has been added.`
          );
        }
      });
    },
    cancelForm() {
      this.$router.push("/");
    },
  },
  created() {
    this.getUser(this.$route.params.username);
  },
};
</script>

<style>
</style>