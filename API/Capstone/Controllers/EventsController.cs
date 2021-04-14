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
        public ActionResult<List<BreweryEvent>> GetEvents(bool byBrewery = false, int breweryId = 0, bool byFavorites = false, int userId = 0)
        {
            List<BreweryEvent> events = null;

            if (byBrewery == false && byFavorites == false)
            {
                events = eventDAO.GetEvents();
            }
            else if (byBrewery == false && byFavorites == true)
            {
                events = eventDAO.GetEvents(userId);
            }
            else
            {
                events = eventDAO.GetEventsByBrewery(breweryId);
            }

            return Ok(events);
        }

        [HttpPost]
        public ActionResult<BreweryEvent> CreateEvent(BreweryEvent breweryEvent)
        {
            BreweryEvent createdEvent = eventDAO.CreateEvent(breweryEvent);

            if (createdEvent != null)
            {
                return Created($"{createdEvent.BreweryEventId}", createdEvent);
            }
            else
            {
                return BadRequest();
            }
        }

        [HttpDelete("{eventId}")]
        public ActionResult DeleteEvent(int eventId)
        {
            bool wasDeleted = eventDAO.DeleteEvent(eventId);

            if (wasDeleted)
            {
                return NoContent();
            }
            else
            {
                return BadRequest();
            }
        }
    }
}
