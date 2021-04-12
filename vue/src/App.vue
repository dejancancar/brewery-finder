<template>
  <div id="app">
    <div id="nav">
      <router-link v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;|&nbsp;
      <router-link v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>
      <router-link v-bind:to="{ name: 'login' }" v-if="$store.state.token === ''">Login</router-link>
    </div>
    <router-view />
  </div>
</template>

<style>
body {
  background-image: url('images/beer.jpg');
  background-color: rgb(191, 168, 160);
  background-blend-mode: screen;

  font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto,
    'Helvetica Neue', Arial, 'Noto Sans', sans-serif, 'Apple Color Emoji',
    'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
}
.beerflow{
  width: stretch;
  height: 340px;
  display: block;
  position: relative;
  
}
.beerflow::after {
  content: "";
    background: url('images/beer2.jpg');
    top: 0;
    left: 0;
    bottom: 0;
    right: 0;
    position: absolute;
    opacity: 0.75;
    z-index: -1;
      border-radius:10px;


}

.bubble {
  
    align-content: center;
    height: 340px;
    background-color: #f8f8f8;
    border: 1px solid #c8c8c8;
    border-radius: 15px;
    width: 600px;
    text-align: center;
}
.big-button{
  border-radius: 15px;
  height:340px;
  min-width: 400px;
  font-size: 1.5em;
  align-content: left;
}
table:not(.unstyled), .brewery-basic-info, .brewery-beers, .brewery-hours, .brewery-images, .update-beer {
    height: 340px;
    align-content: center;
    background-color: #c5e5ff;
    border: 1px solid #a5a8c9;
    border-radius: 15px;
    width: 400px;
    text-align: center;
    padding-top: 20px;
    padding-bottom: 20px;
}


.badthing{
  color: red;
  font-style: italic;
  align-content: center;

}
.goodthing{
  color: lightgreen;
  font-style: italic;
  align-content: center;
}


button{
  margin-top: 5px;
  margin-bottom: 5px;
  margin-left: 1px;
  margin-right: 1px;
}
.hyperlink {
  padding-top: 5px;
  font-style: italic;
  padding-bottom:5px;
}
ul{
  padding-right: 33px;
}
li{
  list-style-type: none;
}

.fields{
  justify-content: center;
  display: flex;
}

.fields-spacer{
  flex-basis: 3%;
}
#username{
  margin-left: 5px;
}
#password{
  margin-left: 5px;
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