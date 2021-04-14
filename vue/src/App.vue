<template>
  <div class="app">

    <div class="container">
      <div id="logo-and-nav-links">
        <img src="./images/logo.png" alt="Cleveland on Tap" id="logo" />
        <div class="nav-links">
          <router-link class="navlink" v-bind:to="{ name: 'home' }"
            >Home</router-link
          >
          <router-link
            class="navlink"
            v-bind:to="{ name: 'logout' }"
            v-if="$store.state.token != ''"
            >Logout</router-link
          >
          <router-link
            class="navlink"
            v-bind:to="{ name: 'login' }"
            v-if="$store.state.token === ''"
            >Login</router-link
          >
        </div>
      </div>
    </div>
    <router-view />
  </div>
</template>

<style scoped>
/* *{
  box-sizing: border-box;
} */
h1 {
  font-size: 3rem;
  text-align: center;
  color: white;
}

body {
  font-family: century, brandonlight, arial, helvetica;
  font-size: 87.5%;
  height: 100%;
}
#logo-and-nav-links {
  align-content: center;
  display: flex;
  width: stretch;
  justify-content: space-between;
  font-size: 30px;
  align-items: flex-end;
  color: white;
}
.navlink {
  font-variant: small-caps;
  color: white;
  font-size: 75%;
  text-decoration: none;
  padding-right: 40px;
  font-weight: bold;
  transition: all 0.2s;
}
.navlink:hover {
  color: #dead30;
}
.app {
  justify-content: start;
  position: absolute;
  z-index: -2;
  height: 60px;
  width: 100%;
  background-size: auto 100%;
  background-color: black;
}

@media all and (max-width: 30em) {
  button {
    display: block;
    margin: 0.2em auto;
  }
}
</style>

<style>
* {
  font-family: century, brandonlight, arial, helvetica;
}
@font-face {
  font-family: brandonblack;
  src: url("fonts/BrandonText-Black.otf");
  font-family: brandonlight;
  src: url("fonts/BrandonText-Light.otf");
}
button {
  font-variant: small-caps;
  text-decoration: none;
  padding: 5px;
  font-weight: bold;
  color: #fff;
  background-color: #e0af1f;
  border: thin solid rgba(0, 0, 0, 0.137);
  font-size: 130%;
  text-align: center;
  transition: all 0.2s;
  margin: 17px 8px;
  cursor: pointer;
}
button:hover {
  text-decoration: underline;
}
</style>