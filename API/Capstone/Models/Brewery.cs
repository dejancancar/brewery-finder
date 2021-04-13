using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class Brewery
    {
        public int BreweryId { get; set; }
        public string BreweryName { get; set; }
        public int UserId { get; set; }
        public string History { get; set; } = "";
        public string StreetAddress { get; set; } = "";
        public string Phone { get; set; } = "";
        public string City { get; set; } = "";
        public string ZipCode { get; set; } = "";
        public string DefaultImageUrl { get; set; } = "https://res.cloudinary.com/breweryfinderte/image/upload/v1618351293/o7nsfdtjw8ogmyndjabe.png";
        public bool IsActive { get; set; } = true;
        public bool IsFavorite { get; set; } = false;

    }

    public class BreweryFavorite
    {
        public int BreweryId { get; set; }
        public int UserId { get; set; }
    }

}
