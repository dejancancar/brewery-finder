using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class BreweryEvent
    {
        public int BreweryEventId { get; set; }
        public int BreweryId { get; set; }
        public string BreweryName { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public DateTime DateAndTime { get; set; } = DateTime.Now;

    }
}
