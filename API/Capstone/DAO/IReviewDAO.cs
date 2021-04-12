using Capstone.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.DAO
{
    public interface IReviewDAO
    {
        List<Review> GetReviews(int beerId);
        Review CreateReview(Review review);
    }
}
