using Capstone.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.DAO
{
    public interface IBeerDAO
    {
        Beer CreateBeer(Beer beer);
        List<Beer> GetBeers(int breweryId);
    }
}
