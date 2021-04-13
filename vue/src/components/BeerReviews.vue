<template>
  <div>
      <h2>Reviews</h2>
      <button v-show="$store.state.token" @click="toggleAddReview = true" >Add Review</button>
      <form v-show="toggleAddReview">
          <table>
              <tr>
                  <td>Rating: </td>
                  <td>
                      <select v-model="newReview.rating">
                          <option value="1">1</option>
                          <option value="2">2</option>
                          <option value="3">3</option>
                          <option value="4">4</option>
                          <option value="5">5</option>
                      </select>
                  </td>
              </tr>
              <tr>
                  <td>Title: </td>
                  <td>
                      <input type="text" v-model="newReview.reviewTitle">
                  </td>
              </tr>
              <tr>
                  <td>Review: </td>
                  <td>
                      <textarea cols="30" rows="10" v-model="newReview.reviewBody"></textarea>
                  </td>
              </tr>
          </table>
          <button @click="addReview">Submit</button>
          <button @click="toggleAddReview = false">Cancel</button>
      </form>
      <ul>
          <li v-for="review in reviews" :key="review.beerReviewId">
              <div>User: {{review.username}} - rating: {{review.rating}}</div>
              <h3>{{review.reviewTitle}}</h3>
              <div>{{review.reviewBody}}</div>
          </li>
      </ul>
  </div>
</template>

<script>
import api from "../services/apiService.js";

export default {
    data() {
        return {
            reviews: [],
            toggleAddReview: false,
            newReview: {
                beerId: this.$route.params.beerId,
                userId: this.$store.state.user.userId,
                rating: 5,
                reviewTitle: "",
                reviewBody: "",
            }
        }
    },
    methods: {
        getReviews() {
            api.getReviews(this.$route.params.beerId)
                .then((resp) => {
                    this.reviews = resp.data;
                })
        },
        addReview() {
            api.addReview(this.newReview)
                .then(() => {
                    this.newReview = {};
                })
        },
        checkUser() {
            if (this.$store.state.token) {
                return true;
            }
            else {
                return false;
            }
        }
    },
    created() {
        this.getReviews();
    }

}
</script>

<style>

</style>