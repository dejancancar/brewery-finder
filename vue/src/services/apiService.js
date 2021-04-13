import axios from 'axios';

// const http = axios.create({
//   baseURL: process.env.VUE_APP_REMOTE_API
// })
export default {
  //checks to make sure the user creating a brewery is logged in as admin.
  createBrewery(brewery) {
    // http.defaults.headers.common['Authorization'] = `Bearer ${token}`
    return axios.post('/breweries', brewery)
  },
  //Admin functions
  getUsers(username) {
    let path = '/users';
    if (username) {
      path += `?username=${username}`
    }
    return axios.get(path);
  },
  //Brewer functions - Breweries
  getBreweries() {
    return axios.get('/breweries');
  },
  getBreweriesByBrewerId(brewerId) {
    let path = '/breweries';
    if (brewerId) {
      path += `?userId=${brewerId}&isBrewer=true`
    }
    return axios.get(path);
  },
  getBreweryLoggedInUser(userId, breweryId){
    let path = `/breweries/${breweryId}`;
    if (userId) {
      path += `?userId=${userId}&isBrewer=true`
    }
    return axios.get(path);
  },
  updateBreweryInfo(brewery) {

    return axios.put(`/breweries/${brewery.breweryId}`, brewery);
  },
  getBreweryById(breweryId) {
    return axios.get(`/breweries/${breweryId}`);
  },


  //Brewer functions - Images
  uploadBreweryImageUrl(brewery) {
    return axios.post(`/breweries/${brewery.breweryId}/images`, brewery);
  },
  getBreweryImages(breweryId) {
    return axios.get(`/breweries/${breweryId}/images`);
  },


  //Brewer Functions - Hours
  updateHours(hours) {
    return axios.put(`/breweries/${hours.breweryId}/hours/${hours.hoursId}`, hours);
  },
  getBreweryHours(breweryId) {
    return axios.get(`/breweries/${breweryId}/hours`);
  },

  //Brewer Functions - Beers
  getBeers(breweryId) {
    return axios.get(`/breweries/${breweryId}/beers`);
  },
  getBeerById(beerId) {
    return axios.get(`beers/${beerId}`);
  },
  addBeer(beer) {
    return axios.post(`/breweries/${beer.breweryId}/beers`, beer);
  },
  updateBeer(updatedBeer) {
    return axios.put(`/breweries/${updatedBeer.breweryId}/beers/${updatedBeer.beerId}`, updatedBeer);
  },

  // Reviews
  getReviews(beerId) {
    return axios.get(`/beers/${beerId}/reviews`);
  },
  addReview(review) {
    return axios.post(`/beers/${review.beerId}/reviews`, review);
  },

  // Events
  getEvents() {
    return axios.get(`/events`);
  },
  getEventsByBrewery(breweryId) {
    return axios.get(`/events?byBrewery=true&breweryId=${breweryId}`);
  },
  addEvent(newEvent) {
    return axios.post(`/events`, newEvent);
  },
  deleteEvent(eventId) {
    return axios.delete(`/events/${eventId}`);
  },

  //Favorites
  addFavoriteBrewery(breweryFavorite, userId){
    return axios.post(`/users/${userId}/favorites`, breweryFavorite)
  },
  deleteFavoriteBrewery(userId, breweryId){
    return axios.delete(`/users/${userId}/favorites/${breweryId}`)
  }
  // checkIfFavorite(breweryId) {
  //   return axios.get(`/users/${this.store.state.user.userId}/favorites?brewery=${breweryId}`)
  // }

}