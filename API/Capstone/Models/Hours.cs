using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class Hours
    {
        public int HoursId { get; set; }
        public int BreweryId { get; set; }
        public int DayOfWeek { get; set; }
        public int OpenHour { get; set; }
        public int OpenMinute { get; set; }
        public string OpenAmPm { get; set; }
        public int CloseHour { get; set; }
        public int CloseMinute { get; set; }
        public string CloseAmPm { get; set; }
        public bool IsClosed { get; set; } = false;
    }
}
