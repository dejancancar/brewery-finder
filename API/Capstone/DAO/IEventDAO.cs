using Capstone.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.DAO
{
    public interface IEventDAO
    {
        List<BreweryEvent> GetEvents();
        List<BreweryEvent> GetEvents(int userId);

        List<BreweryEvent> GetEventsByBrewery(int breweryId);
        BreweryEvent CreateEvent(BreweryEvent breweryEvent);
        bool DeleteEvent(int eventId);
    }
}
