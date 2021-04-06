using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class Brewery
    {
        public int BreweryId { get; set; }
        public string Name { get; set; }
        public int UserId { get; set; }
        public string History { get; set; } = "";
        public List<Location> Locations { get; set; } = new List<Location>();
        public bool IsActive { get; set; } = true;


    }

}
