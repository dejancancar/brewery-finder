using Capstone.DAO;
using Capstone.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Controllers
{
    [Route("Breweries")]
    [ApiController]
    public class BreweriesController : AuthorizedControllerBase
    {
        IBreweryDAO breweryDAO;
        IHoursDAO hoursDAO;
        IBreweryImagesDAO breweryImagesDAO;
        IBeerDAO beerDAO;

        public BreweriesController(IBreweryDAO breweryDAO, IHoursDAO hoursDAO, IBreweryImagesDAO breweryImagesDAO, IBeerDAO beerDAO)
        {
            this.breweryDAO = breweryDAO;
            this.hoursDAO = hoursDAO;
            this.breweryImagesDAO = breweryImagesDAO;
            this.beerDAO = beerDAO;

        }

        [HttpGet]
        public ActionResult<List<Brewery>> GetListBreweries(int userId = 0)
        {
            List<Brewery> breweries;

            if (userId == 0)
            {
                breweries = breweryDAO.GetBreweries();
            }
            else
            {
                breweries = breweryDAO.GetBreweriesByBrewer(userId);
            }


            if (breweries != null)
            {
                return Ok(breweries);
            }
            else
            {
                return BadRequest();
            }
        }

        [HttpGet("{breweryid}")]
        public ActionResult<Brewery> GetBrewery(int breweryId)
        {
            Brewery brewery = breweryDAO.GetBrewery(breweryId);

            if (brewery != null)
            {
                return Ok(brewery);
            }
            else
            {
                return BadRequest();
            }
        }

        [HttpGet("{breweryId}/beers")]
        public ActionResult<List<Beer>> GetBeers(int breweryId)
        {
            List<Beer> beers = beerDAO.GetBeers(breweryId);

            return Ok(beers);
        }

        [HttpGet("{breweryId}/hours")]
        public ActionResult<List<Hours>> GetHours(int breweryId)
        {
            List<Hours> hours = hoursDAO.GetHours(breweryId);

            return Ok(hours);
        }

        [HttpGet("{breweryId}/images")]
        public ActionResult<List<BreweryImage>> GetImages(int breweryId)
        {
            List<BreweryImage> images = breweryImagesDAO.GetImages(breweryId);

            return Ok(images);
        }


        [HttpPost]
        [Authorize(Roles = "admin")]
        public IActionResult CreateBrewery(Brewery brewery)
        {
            Brewery createdBrewery;
            createdBrewery = this.breweryDAO.CreateBrewery(brewery);

            if (createdBrewery != null)
            {
                return Created($"{createdBrewery.BreweryId}", createdBrewery);
            }
            else
            {
                return BadRequest();
            }
        }

        [HttpPost("breweries/{breweryId}/beers")]
        public ActionResult<Beer> CreateBeer(Beer beer)
        {
            Beer createdBeer;
            createdBeer = beerDAO.CreateBeer(beer);
            if (createdBeer != null)
            {
                return Created($"{createdBeer.BeerId}", createdBeer);
            }
            else
            {
                return BadRequest();
            }
        }

        [HttpPost("{breweryId}/images")]
        [Authorize(Roles = "brewer")]
        public ActionResult<BreweryImage> CreateImage(BreweryImage brewery)
        {
            BreweryImage image = this.breweryImagesDAO.CreateImage(brewery);

            if (image != null)
            {
                return Created($"{image.BreweryId}/images/{image.ImageId}", image);
            }
            else
            {
                return BadRequest();
            }
        }


        [HttpPut("{id}")]
        [Authorize(Roles = "brewer")]
        public ActionResult<Brewery> Update(Brewery brewery, int id)
        {
            if (id != brewery.BreweryId)
            {
                return BadRequest();
            }

            Brewery updatedBrewery;
            updatedBrewery = this.breweryDAO.UpdateBrewery(brewery);

            if (updatedBrewery != null)
            {
                return Ok(updatedBrewery);
            }
            else
            {
                return BadRequest();
            }
        }

        [HttpPut("{breweryId}/hours/{hoursId}")]
        [Authorize(Roles = "brewer")]
        public ActionResult<Hours> UpdateHours(Hours hours, int hoursId)
        {
            if (hoursId != hours.HoursId)
            {
                return BadRequest();
            }

            Hours updatedHours;
            updatedHours = this.hoursDAO.UpdateHours(hours);

            if (updatedHours != null)
            {
                return Ok(updatedHours);
            }
            else
            {
                return BadRequest();
            }
        }
    }
}
