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
        public static IHostingEnvironment _hostingEnvironment;

        public BreweriesController(IBreweryDAO breweryDAO, IHoursDAO hoursDAO,IBreweryImagesDAO breweryImagesDAO, IHostingEnvironment hostingEnvironment)
        {
            this.breweryDAO = breweryDAO;
            this.hoursDAO = hoursDAO;
            this.breweryImagesDAO = breweryImagesDAO;
            _hostingEnvironment = hostingEnvironment;
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

        [HttpGet("{breweryId}/hours")]
        public ActionResult<List<Hours>> GetHours()
        {
            List<Hours> hours = hoursDAO.GetHours();

            return Ok(hours);
        }


        [HttpPost]
        [Authorize(Roles = "admin")]
        public IActionResult CreateBrewery(Brewery brewery)
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

        [HttpPost("{breweryId}/hours")]
        public ActionResult<Hours> CreateHours(Hours hours)
        {
            Hours createdHours;
            createdHours = this.hoursDAO.CreateHours(hours);

            if (createdHours != null)
            {
                return Created($"{createdHours.BreweryId}/hours/{createdHours.HoursId}", createdHours);
            }
            else
            {
                return BadRequest();
            }
        }

        [HttpPost("{breweryId}/images")]
        public IActionResult CreateImage([FromForm] Image file, int breweryId)
        {
            // TODO - check if ext is for an image file
            if (file.File.Length > 0)
            {
                string newFileName = $"{DateTime.Now.ToString("yyyyMMddHHmmss")}{file.File.FileName}";
                string path = $"{_hostingEnvironment.WebRootPath}\\imageuploads\\{newFileName}";

                using (FileStream fileStream = System.IO.File.Create(path))
                {
                    file.File.CopyTo(fileStream);
                    fileStream.Flush();
                }

                bool addedToDb = breweryImagesDAO.CreateImage(breweryId, newFileName);

                if (addedToDb == true)
                {
                    return Ok();
                }
                else
                {
                    System.IO.File.Delete(path);

                    return BadRequest();
                }
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
