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

        public BeersController(IBeerDAO beerDAO)
        {
            this.beerDAO = beerDAO;
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
    }
}
