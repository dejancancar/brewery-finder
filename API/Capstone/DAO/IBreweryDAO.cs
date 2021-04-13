using Capstone.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.DAO
{
    public interface IBreweryDAO
    {
        Brewery CreateBrewery(Brewery brewery);
        List<Brewery> GetBreweries();
        List<Brewery> GetBreweries(int userId);

        Brewery UpdateBrewery(Brewery brewery);
        List<Brewery> GetBreweriesByBrewer(int userId);
        Brewery GetBrewery(int breweryId);
        Brewery GetBrewery(int breweryId, int userId);
    }
}
