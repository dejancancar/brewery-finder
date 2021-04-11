import Vue from 'vue'
import Router from 'vue-router'
import Home from '../views/Home.vue'
import Login from '../views/Login.vue'
import Logout from '../views/Logout.vue'
import Register from '../views/Register.vue'
import store from '../store/index'
import AdminSearchUsers from '../views/AdminSearchUsers.vue'
import CreateBrewery from '../views/CreateBrewery.vue'
import BrewerBreweries from '../views/BrewerBreweries.vue'
import UpdateBrewery from '../views/UpdateBrewery.vue'
import Brewery from '../views/Brewery.vue'



Vue.use(Router)

/**
 * The Vue Router is used to "direct" the browser to render a specific view component
 * inside of App.vue depending on the URL.
 *
 * It also is used to detect whether or not a route requires the user to have first authenticated.
 * If the user has not yet authenticated (and needs to) they are redirected to /login
 * If they have (or don't need to) they're allowed to go about their way.
 */

const router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/login",
      name: "login",
      component: Login,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/logout",
      name: "logout",
      component: Logout,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/register",
      name: "register",
      component: Register,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/admin/users",
      name: "admin-search-users",
      component: AdminSearchUsers,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: "/admin/users/:username",
      name: "create-brewery", 
      component: CreateBrewery,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: "/brewer/",
      name: "brewer-breweries",
      component: BrewerBreweries,
      meta:{
        requiresAuth: true
      }
    },
    {
      path: '/breweries/:breweryId',
      name: "update-brewery",
      component: UpdateBrewery,
      meta:{
        requiresAuth: true
      }
    },
    {
      path: '/brewery/:breweryId',
      name: "brewery",
      component: Brewery,
      meta:{
        requiresAuth: false
      }
    },


  ]
})

router.beforeEach((to, from, next) => {
  // Determine if the route requires Authentication
  const requiresAuth = to.matched.some(x => x.meta.requiresAuth);

  // If it does and they are not logged in, send the user to "/login"
  if (requiresAuth && store.state.token === '') {
    next("/login");
  } else {
    // Else let them go to their next destination
    next();
  }
});



export default router;
