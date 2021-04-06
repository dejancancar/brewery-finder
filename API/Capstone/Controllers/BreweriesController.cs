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
    [Route("Breweries")]
    [ApiController]
    public class BreweriesController : AuthorizedControllerBase
    {
        IBreweryDAO breweryDAO;

        public BreweriesController(IBreweryDAO breweryDAO)
        {
            this.breweryDAO = breweryDAO;
        }



        [HttpPost]
        public IActionResult Create(Brewery brewery)
        {
            Brewery createdBrewery = null;
            createdBrewery = this.breweryDAO.CreateBrewery(brewery);

            // make sure something's created
            if (createdBrewery != null)
            {
                return Created($"{createdBrewery.BreweryId}", createdBrewery);
            }
            else
            {
                return BadRequest();
            }
        }
    }
}
