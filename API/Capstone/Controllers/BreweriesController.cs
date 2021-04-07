using Capstone.DAO;
using Capstone.Models;
using Microsoft.AspNetCore.Authorization;
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
        IHoursDAO hoursDAO;

        public BreweriesController(IBreweryDAO breweryDAO, IHoursDAO hoursDAO)
        {
            this.breweryDAO = breweryDAO;
            this.hoursDAO = hoursDAO;
        }

        [HttpGet]
        public ActionResult<List<Brewery>> Get()
        {
            List<Brewery> breweries = breweryDAO.GetBreweries();

            if (breweries != null)
            {
                return Ok(breweries);
            }
            else
            {
                return BadRequest();
            }
        }


        [HttpPost]
        [Authorize(Roles = "admin")]
        public IActionResult Create(Brewery brewery)
        {
            Brewery createdBrewery;
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
