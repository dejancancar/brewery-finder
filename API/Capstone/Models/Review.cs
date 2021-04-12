using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class Review
    {
        public int BeerReviewId { get; set; }
        public int BeerId { get; set; }
        public int UserId { get; set; }
        public string UserName { get; set; }
        public int Rating { get; set; }
        public string ReviewTitle { get; set; }
        public string ReviewBody { get; set; }
        public DateTime DateOfReview { get; set; }

    }
}
