using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assignment6AirlineReservation
{

    class AirlineFlight
    {


        public int flightID { get; set; }
        public int flightNumber { get; set; }
        public String Aircraft { get; set; }
        public override String ToString()
        {
            return flightNumber + " " + Aircraft;
        }

    }
}
