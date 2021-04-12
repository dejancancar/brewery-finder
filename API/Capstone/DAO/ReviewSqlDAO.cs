using Capstone.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.DAO
{
    public class ReviewSqlDAO : IReviewDAO
    {
        private readonly string connectionString;
        private const string SQL_GET_REVIEWS = @"SELECT r.*, u.username
	                                                FROM reviews r
	                                                JOIN users u ON u.user_id = r.user_id
	                                                WHERE r.beer_id = @beerId;";
        private const string SQL_CREATE_REVIEW = @"INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
                                                    VALUES (@beerId, @userId, @rating, @reviewTitle, @reviewBody, @dateOfReview)
                                                   SELECT r.*, u.username
	                                                FROM reviews r
	                                                JOIN users u ON u.user_id = r.user_id
	                                                WHERE r.beer_review_id = @@IDENTITY;";
        public ReviewSqlDAO(string dbConnectionString)
        {
            this.connectionString = dbConnectionString;
        }

        public List<Review> GetReviews(int beerId)
        {
            List<Review> reviews = new List<Review>();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(SQL_GET_REVIEWS, conn);
                    cmd.Parameters.AddWithValue("@beerId", beerId);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while(reader.Read())
                    {
                        Review review = RowToObject(reader);
                        reviews.Add(review);
                    }

                    return reviews;
                }
            }
            catch (SqlException ex)
            {

                throw;
            }
        }

        public Review CreateReview(Review review)
        {
            Review createdReview = null;
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();


                    SqlCommand cmd = new SqlCommand(SQL_CREATE_REVIEW, conn);
                    cmd.Parameters.AddWithValue("@beerId", review.BeerId);
                    cmd.Parameters.AddWithValue("@userId", review.UserId);
                    cmd.Parameters.AddWithValue("@rating", review.Rating);
                    cmd.Parameters.AddWithValue("@reviewTitle", review.ReviewTitle);
                    cmd.Parameters.AddWithValue("@reviewBody", review.ReviewBody);
                    cmd.Parameters.AddWithValue("@dateOfReview", review.DateOfReview);

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        createdReview = RowToObject(reader);
                    }

                    return createdReview;
                }
            }
            catch (SqlException ex)
            {

                throw;
            }
        }


        private static Review RowToObject(SqlDataReader r)
        {
            Review review = new Review();

            review.BeerReviewId = Convert.ToInt32(r["beer_review_id"]);
            review.BeerId = Convert.ToInt32(r["beer_id"]);
            review.UserId = Convert.ToInt32(r["user_id"]);
            review.Username = Convert.ToString(r["username"]);
            review.Rating = Convert.ToInt32(r["rating"]);
            review.ReviewTitle = Convert.ToString(r["review_title"]);
            review.ReviewBody = Convert.ToString(r["review_body"]);
            review.DateOfReview = Convert.ToDateTime(r["date_of_review"]);

            return review;

        }
    }
}
