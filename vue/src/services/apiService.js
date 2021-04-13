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
  getBreweriesByBrewerId(userId) {
    let path = '/breweries';
    if (userId) {
      path += `?userId=${userId}`
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
  }

}