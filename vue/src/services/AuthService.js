import axios from 'axios';

const http = axios.create({
  baseURL: process.env.VUE_APP_REMOTE_API
})
export default {

  login(user) {
    return http.post('/login', user)
  },

  register(user) {
    return http.post('/register', user)
  },

  addBrewery(brewery){
    return http.post('/add-brewery', brewery)
  },

  getUsers(username){
    let path = '/users';
    if(username){
      path += `?username=${username}`
    }
    return http.get(path);
  }

}
