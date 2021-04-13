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
    [Route("Events")]
    [ApiController]
    public class EventsController : ControllerBase
    {
        IEventDAO eventDAO;
        public EventsController(IEventDAO eventDAO)
        {
            this.eventDAO = eventDAO;
        }

        [HttpGet]
        public ActionResult<List<BreweryEvent>> GetEvents(bool byBrewery = false, int breweryId = 0)
        {
            List<BreweryEvent> events = null;

            if (byBrewery == false)
            {
                events = eventDAO.GetEvents();
            }
            else
            {
                events = eventDAO.GetEventsByBrewery(breweryId);
            }

            return Ok(events);
        }
    }
}
