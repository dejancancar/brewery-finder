using Capstone.DAO;
using Capstone.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Controllers
{
    [Route("beers")]
    [ApiController]
    public class BeersController : AuthorizedControllerBase
    {
        IBeerDAO beerDAO;
        IReviewDAO reviewDAO;

        public BeersController(IBeerDAO beerDAO, IReviewDAO reviewDAO)
        {
            this.beerDAO = beerDAO;
            this.reviewDAO = reviewDAO;
        }

        [HttpGet("{beerId}")]
        public ActionResult<Beer> GetBeer(int beerId)
        {
            Beer beer = beerDAO.GetBeerById(beerId);

            if (beer != null)
            {
                return Ok(beer);
            }
            else
            {
                return BadRequest();
            }
        }

        [HttpGet("{beerId}/reviews")]
        public ActionResult<List<Review>> GetReviews(int beerId)
        {
            List<Review> reviews = reviewDAO.GetReviews(beerId);

            return Ok(reviews);
        }

        [HttpPost("{beersId}/reviews")]
        public ActionResult<Review> CreateReview(Review review)
        {
            Review createdReview = reviewDAO.CreateReview(review);

            if (createdReview != null)
            {
                return Created($"{createdReview.BeerReviewId}", createdReview);
            }
            else
            {
                return BadRequest();
            }
        }
    }
}
