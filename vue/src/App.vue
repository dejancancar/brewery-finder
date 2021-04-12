<template>
<div class="app">
<div class="container"> 
    <div id="beerflow-background-image"></div>
      <div id="logo-and-nav-links">
      <img src="./images/logo.png" alt="Cleveland on Tap" id="logo"/>
      <div class="nav-links">
      <router-link v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;|&nbsp;
      <router-link v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>
      <router-link v-bind:to="{ name: 'login' }" v-if="$store.state.token === ''">Login</router-link>
      </div>
    </div>
  </div>
    <router-view />
    </div>
</template>

<style>
h1{
  font-size: 3rem;
  text-align:center;
}
body {
  background-image: url('images/beer.jpg');
  background-color: rgb(191, 168, 160);
  background-blend-mode: screen;

  font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto,
    'Helvetica Neue', Arial, 'Noto Sans', sans-serif, 'Apple Color Emoji',
    'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
}
#logo-and-nav-links{
  padding-top:80px;
  display: flex;
  width: stretch;
  justify-content: space-between;
  font-size: 30px;
  align-items: flex-end;
}
#beerflow-background-image{
  justify-content: start;
  position: absolute;
  z-index: -1;
  height: 150px;
  position: absolute;
  width: 100%;
  background: url(images/beer2.jpg) center repeat-x;
  background-size: auto 100%;
  opacity: 0.6;
}

button{
display:inline-block;
padding:0.3em 1.2em;
margin:0 0.3em 0.3em 0;
border-radius:2em;
box-sizing: border-box;
text-decoration:none;
font-family:'Roboto',sans-serif;
font-weight:300;
color:#FFFFFF;
background-color:#4eb5f1;
text-align:center;
transition: all 0.2s;
}

button:hover{
background-color:#4095c6;
}
@media all and (max-width:30em){
  button{
    display:block;
    margin:0.2em auto;
  }
}

.flex-box{
  display: flex;
}
</style>