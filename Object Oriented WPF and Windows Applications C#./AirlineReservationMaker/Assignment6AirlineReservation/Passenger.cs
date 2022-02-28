using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assignment6AirlineReservation
{
    class Passenger
    {
    
        public String passfName { get; set; }
        public String passlName { get; set; }
        public int passSeat { get; set; }
        public int passID { get; set; }

        public override String ToString()
        {
            return passfName + " " + passlName;
        }


    }
}
