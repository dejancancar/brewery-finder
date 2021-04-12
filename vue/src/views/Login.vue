<template>
  <div id="login" class="beerflow">
  <div>
    <div>
    <form class="form-signin" @submit.prevent="login">
      <div class="bubble">
        <h1 class="header">Please Sign In</h1>
        <div class="fields">
      <label for="username" class="label">Username:</label>
      <input
        type="text"
        id="username"
        class="text-box"
        placeholder="Username"
        v-model="user.username"
        required
        autofocus
      />
      <div class="fields-spacer"></div>
      <label for="password" class="label">Password:</label>
      <input
        type="password"
        id="password"
        class="text-box"
        placeholder="Password"
        v-model="user.password"
        required
      />
        </div>
        <button type="submit" class="submit-button">Sign in</button>
        <div class="hyperlink">
                <router-link :to="{ name: 'register' }" class="router-link">Need an account?</router-link>

        </div>
        <div
        class="badthing"
        role="alert"
        v-if="invalidCredentials"
      >Invalid username and password!</div>
      <div
        class="goodthing"
        role="alert"
        v-if="this.$route.query.registration"
      >Thank you for registering, please sign in.</div>

      </div>
      
    </form>
    </div>
    </div>

  </div>
</template>

<script>
import authService from "../services/AuthService";

export default {
  name: "login",
  components: {},
  data() {
    return {
      user: {
        username: "",
        password: ""
      },
      invalidCredentials: false
    };
  },
  methods: {
    login() {
      authService
        .login(this.user)
        .then(response => {
          if (response.status == 200) {
            this.$store.commit("SET_AUTH_TOKEN", response.data.token);
            this.$store.commit("SET_USER", response.data.user);
            //added redirect routes once a specific user is logged in, admin, brewer and user all go to different routes upon a successful log in.
            if(response.data.user.role === "admin"){
              this.$router.push("/admin/users")
            }else if(response.data.user.role === "brewer"){
              this.$router.push("/brewer")
            }
            else{
               this.$router.push("/");           
            }

          }
        })
        .catch(error => {
          const response = error.response;

          if (response.status === 401) {
            this.invalidCredentials = true;
          }
        });
    }
  }
};
</script>
