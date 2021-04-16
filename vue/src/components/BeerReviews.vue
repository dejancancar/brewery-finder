<template>
  <div>
    <h2>Reviews</h2>
    <button v-show="$store.state.token" @click="toggleAddReview = true">
      Add Review
    </button>
    <form v-show="toggleAddReview">
      <table>
        <tr id="select-name">
          <td>Rating</td>
        </tr>
        <tr>
          <td>
            <select id="review-input" v-model="newReview.rating">
              <option value="1">1</option>
              <option value="2">2</option>
              <option value="3">3</option>
              <option value="4">4</option>
              <option value="5">5</option>
            </select>
          </td>
        </tr>
        <tr id="select-name">
          <td>Title</td>
        </tr>
        <tr>
          <td>
            <input type="text" v-model="newReview.reviewTitle" />
          </td>
        </tr>
        <tr id="select-name">
          <td>Review</td>
        </tr>
        <tr>
          <td>
            <textarea
              cols="30"
              rows="10"
              v-model="newReview.reviewBody"
            ></textarea>
          </td>
        </tr>
      </table>
      <button @click="addReview">Submit</button>
      <button @click="toggleAddReview = false">Cancel</button>
    </form>
    <ul>
      <li v-for="review in reviews" :key="review.beerReviewId">
        <div>
          <img id="user-icon" src="../images/user-icon.png" />
          <span id="username">{{ review.username }}</span>
          <span id="star-icon" v-for="star in review.rating" :key="star">
            <img class="ratingImg" src="../images/star.png" alt="star" />
          </span>
        </div>
        <div id="date-of-review">{{ formatDate(review.dateOfReview) }}</div>
        <h3>{{ review.reviewTitle }}</h3>
        <div id="review-body">{{ review.reviewBody }}</div>
      </li>
    </ul>
  </div>
</template>

<script>
import api from "../services/apiService.js";
import moment from "moment";

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
      },
    };
  },
  methods: {
    getReviews() {
      api.getReviews(this.$route.params.beerId).then((resp) => {
        this.reviews = resp.data;
      });
    },
    addReview() {
      api.addReview(this.newReview).then(() => {
        this.newReview = {};
      });
    },
    checkUser() {
      if (this.$store.state.token) {
        return true;
      } else {
        return false;
      }
    },
    formatDate(date) {
      return moment(String(date)).format("MMMM Do YYYY");
    },
  },
  created() {
    this.getReviews();
  },
};
</script>

<style scoped>
#review-input {
  width: 25%;
  padding-left: 15px;
  font-size: 20px;
}
.ratingImg {
  width: 2%;
}
li {
  list-style: none;
}
#user-icon {
  max-height: 1.8%;
  max-width: 1.8%;
  margin-right: 0.8%;
  margin-bottom: 0px;
}
#username {
  margin-right: 2%;
  font-size: 30px;
  font-weight: bold;
}
#review-body {
  margin-bottom: 3%;
  margin-top: 3px;
  font-size: 17px;
}
h3 {
  margin: auto;
  font-size: 20px;
}
h2 {
  margin: auto;
}
#date-of-review {
  font-size: 16px;
  font-style: italic;
}
#select-name {
  font-weight: bold;
  font-size: 17px;
  margin-right: 3px;
}
select, input {
  padding-left: 3px;
  font-size: 16px;
  color: #000000;
  background-color: #ffffff;
  background-image: none;
  border: 1px solid #dfd7ca;
  border-radius: 4px;
  height: 40px;
  margin-left: 6px;
}
textarea {
  padding-left: 3px;
  font-size: 16px;
  color: #000000;
  background-color: #ffffff;
  background-image: none;
  border: 1px solid #dfd7ca;
  border-radius: 4px;
  height: 40px;
  margin-left: 6px;
  height: 150px;
  width: 100%;
 
}input{
    width: 100%;
}
</style>