using Capstone.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.DAO
{
    public interface IHoursDAO
    {
        Hours UpdateHours(Hours hours);
        //Hours CreateHours(Hours hours);
        List<Hours> GetHours();
    }
}
