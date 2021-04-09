using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class Beer
    {
        public int BeerId { get; set; }
        public string BeerName { get; set; }
        public int BreweryId { get; set; }
        public string ImageUrl { get; set; }
        public string Abv { get; set; }
        public string BeerType { get; set; }
        public bool IsActive { get; set; }
    }
}
