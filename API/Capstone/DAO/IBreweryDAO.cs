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
        Brewery UpdateBrewery(Brewery brewery);
    }
}
