using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class BreweryImage
    {
        public int BreweryImageId { get; set; }
        public int BreweryId { get; set; }
        public string ImageUrl { get; set; }

    }
}
