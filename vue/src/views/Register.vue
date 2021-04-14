<template>
  <div id="register" class="text-center">
    <form class="form-register" @submit.prevent="register">
      <h1 class="h3 mb-3 font-weight-normal">Create Account</h1>
      <div class="alert alert-danger" role="alert" v-if="registrationErrors">
        {{ registrationErrorMsg }}
      </div>
      <div>
        <label for="username" class="sr-only">Username</label>
        <input
          type="text"
          id="username"
          class="form-control"
          placeholder="Username"
          v-model="user.username"
          required
          autofocus
        />
      </div>
      <div>
        <label for="password" class="sr-only">Password</label>
        <input
          type="password"
          id="password"
          class="form-control"
          placeholder="Password"
          v-model="user.password"
          required
        />
      </div>
      <div>
        <input
          type="password"
          id="confirmPassword"
          class="form-control"
          placeholder="Confirm Password"
          v-model="user.confirmPassword"
          required
        />
      </div>
      <div >
        <router-link id="login-page" :to="{ name: 'login' }">>> Have an account?</router-link>      
      </div>

      <div>
      <button class="btn btn-lg btn-primary btn-block" type="submit">
        Create Account
      </button>        
      </div>

    </form>
  </div>
</template>

<script>
import authService from "../services/AuthService";

export default {
  name: "register",
  data() {
    return {
      user: {
        username: "",
        password: "",
        confirmPassword: "",
        role: "user",
      },
      registrationErrors: false,
      registrationErrorMsg: "There were problems registering this user.",
    };
  },
  methods: {
    register() {
      if (this.user.password != this.user.confirmPassword) {
        this.registrationErrors = true;
        this.registrationErrorMsg = "Password & Confirm Password do not match.";
      } else {
        authService
          .register(this.user)
          .then((response) => {
            if (response.status == 201) {
              this.$router.push({
                path: "/login",
                query: { registration: "Your account has been created!" },
              });
            }
          })
          .catch((error) => {
            const response = error.response;
            this.registrationErrors = true;
            if (response.status === 400) {
              this.registrationErrorMsg = "Bad Request: Validation Errors";
            }
          });
      }
    },
    clearErrors() {
      this.registrationErrors = false;
      this.registrationErrorMsg = "There were problems registering this user.";
    },
    
  },
  created(){
     document.getElementById("username").focus()
  }
};
</script>

<style scoped>

.sr-only{
  font-size: 15px;
}
.form-register{
  display: flexbox;
  max-width: 500px;
  justify-items: flex-end;
}
label{
  display:inline-block;
  max-width: 100%;
  font-weight: bold;
    margin-bottom: 2px;
  
}
#username, #password{
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
#login-page{
  font-size: 14px;
  color: #e0af1f;
  text-decoration: none;
}
#login-page:hover{
  text-decoration: underline;
}
button{
  margin: 17px 0px;
}
</style>
