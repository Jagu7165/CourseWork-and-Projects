using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assignment6AirlineReservation
{
    class clsAirlineSQL
    {


        public string getFlights()
        {

            string sSQL = "SELECT Flight_ID, Flight_Number, Aircraft_Type FROM FLIGHT";
            return sSQL;
        }

        public String getFlightID(string fnum)
        {
            String sSQL = String.Format("SELECT Flight_ID FROM FLIGHT Where Flight_Number = {0}", fnum);
            return sSQL;
        }

        public String getAllPassengers(string fID)
        {
            String sSQL = String.Format("SELECT Passenger.Passenger_ID, First_Name, Last_Name, FPL.Seat_Number " +
                              "FROM Passenger, Flight_Passenger_Link FPL " +
                              "WHERE Passenger.Passenger_ID = FPL.Passenger_ID AND " +
                              "Flight_ID = {0}", fID);
            return sSQL;
        }

        public string getPassID(string fname, string lname) 
        {
            string sSQL = string.Format("SELECT Passenger_ID FROM Passenger WHERE First_Name = {0} AND Last_Name = {1}", fname, lname);
            return sSQL;
        }

        public String updateSeat(String fID, String passID, String seat)
        {
            String sSQL = String.Format("UPDATE Flight_Passenger_Link " +
                                        "SET Seat_Number = {0} " +
                                        "WHERE Passenger_ID = {1} " +
                                        "AND Flight_ID = {2}", seat, passID, fID);
            return sSQL;
        }

        public String insertPassengerLink(String fID, String id, String seat)
        {
            String sSQL = String.Format("INSERT INTO Flight_Passenger_Link(Flight_ID, Passenger_ID, Seat_Number) " +
                                        "VALUES({0}, {1}, {2})", fID, id, seat);
            return sSQL;
        }

        public String deletePassengerLink(String fID, String passID)
        {
            String sSQL = String.Format("DELETE FROM Flight_Passenger_Link " +
                                        "WHERE Flight_ID = {0} " +
                                        "AND Passenger_ID = {1}", fID, passID);
            return sSQL;
        }

        public String deletePassenger(String passengerID)
        {
            String sSQL = String.Format("DELETE FROM Passenger " +
                                        "WHERE Passenger_ID = {0}", passengerID);
            return sSQL;
        }

        public String insertPassenger(Passenger passenger)
        {
            String sSQL = String.Format("INSERT INTO Passenger(First_Name, Last_Name) " +
                                        "VALUES('{0}', '{1}')", passenger.passfName, passenger.passlName);
            return sSQL;
        }

    }
}
