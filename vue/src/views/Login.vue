<template>
    <form class="form-signin" @submit.prevent="login">
      <h1 class="header">Please Sign In</h1>
      <label for="username">Username</label>
      <input
        type="text"
        id="username"
        class="text-box"
        placeholder="Username"
        v-model="user.username"
        required
        autofocus
      />
      <label for="password">Password</label>
      <input
        type="password"
        id="password"
        class="text-box"
        placeholder="Password"
        v-model="user.password"
        required
      />
      <button type="submit">Sign in</button>
      <div class="hyperlink">
        <router-link :to="{ name: 'register' }" class="router-link">>> Need an account?</router-link>
        <div
        role="alert"
        v-if="invalidCredentials"
        >Invalid username and password!</div>
        <div
        role="alert"
        v-if="this.$route.query.registration"
        >Thank you for registering, please sign in.</div>
      </div>
    </form>
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
  },
  created(){
    document.getElementById("username").focus()
  }
};
</script>
<style scoped>

.form-signin{
  display: flex;
  flex-direction: column;
  max-width: 400px;
  justify-content: center;
  margin: auto;
  margin-top: 100px;
}
label{
  display:inline-block;
  max-width: 100%;
  font-weight: bold;
    margin-bottom: 2px;
    font-size: 13px;
  
}
input{
  display: block;
    width: 100%;
    height: 30px;
    padding: 10px 13px;
    font-size: 14px;
    color: #000000;
    background-color: #ffffff;
    background-image: none;
    border: 1px solid #dfd7ca;
    border-radius: 4px;
    margin-bottom: 5px;
}
.router-link{
  font-size: 14px;
  color: #e0af1f;
  text-decoration: none;
}
.router-link:hover{
  text-decoration: underline;
}
button{
  margin: 17px 0px;
  max-width: 25%;
}
h1 {
  margin-bottom: 30px;
  font-weight: bold;
  font-variant: small-caps;

}
</style>