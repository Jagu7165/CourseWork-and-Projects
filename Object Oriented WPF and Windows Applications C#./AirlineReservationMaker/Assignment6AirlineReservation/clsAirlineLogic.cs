using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Reflection;
using System.Data;

namespace Assignment6AirlineReservation
{
    class clsAirlineLogic
    {
        /// <summary>
        /// create sql and dataacess obj
        /// </summary>
        clsAirlineSQL sql;
        clsDataAccess Data;

        /// <summary>
        /// cunstructor
        /// </summary>
        public clsAirlineLogic()
        {
            try
            {
                Data = new clsDataAccess();
                sql = new clsAirlineSQL();
            }
            catch (Exception ex)
            {
                throw new Exception(MethodInfo.GetCurrentMethod().DeclaringType.Name + "." + MethodInfo.GetCurrentMethod().Name + " -> " + ex.Message);
            }
        }

        /// <summary>
        /// get the lists for cb
        /// </summary>
        /// <returns></returns>
        public List<AirlineFlight> getFlightlst()
        {
            List<AirlineFlight> flightlst = new List<AirlineFlight>();

            try
            {
                DataSet ds = new DataSet();
                int iRet = 0;
                ds = Data.ExecuteSQLStatement(sql.getFlights(), ref iRet);
                for (int i = 0; i < iRet; ++i)
                {
                    AirlineFlight flight = new AirlineFlight();
                    flight.flightID = Convert.ToInt32(ds.Tables[0].Rows[i][0].ToString());
                    flight.Aircraft = ds.Tables[0].Rows[i][2].ToString();
                    flight.flightNumber = Convert.ToInt32(ds.Tables[0].Rows[i][1].ToString());
                    flightlst.Add(flight);
                }
            }
            catch (Exception ex)
            {
                throw new Exception(MethodInfo.GetCurrentMethod().DeclaringType.Name + "." + MethodInfo.GetCurrentMethod().Name + " -> " + ex.Message);
            }
            return flightlst;
        }

        /// <summary>
        /// get flight id
        /// </summary>
        /// <param name="num"></param>
        /// <returns></returns>
        public string getFlightID(string num)
        {

            string fID;
            try
            {
                fID = Data.ExecuteScalarSQL(sql.getFlightID(num));

            }
            catch (Exception ex)
            {
                throw new Exception(MethodInfo.GetCurrentMethod().DeclaringType.Name + "." + MethodInfo.GetCurrentMethod().Name + " -> " + ex.Message);
            }

            return fID;
        }
        /// <summary>
        /// get passengers for cb
        /// </summary>
        /// <param name="fID"></param>
        /// <returns></returns>
        public List<Passenger> GetFlightPassengers(string fID)
        {
            List<Passenger> passengerlst = new List<Passenger>();

            try
            {
                DataSet ds = new DataSet();
                int iRet = 0;
                ds = Data.ExecuteSQLStatement(sql.getAllPassengers(fID), ref iRet);
                for (int i = 0; i < iRet; ++i)
                {
                    Passenger pass = new Passenger();

                    pass.passfName = ds.Tables[0].Rows[i][1].ToString();
                    pass.passlName = ds.Tables[0].Rows[i][2].ToString();
                    pass.passID = Convert.ToInt32(ds.Tables[0].Rows[i][0].ToString());
                    pass.passSeat = Convert.ToInt32(ds.Tables[0].Rows[i][3].ToString());

                    passengerlst.Add(pass);
                }
            }
            catch (Exception ex)
            {
                throw new Exception(MethodInfo.GetCurrentMethod().DeclaringType.Name + "." + MethodInfo.GetCurrentMethod().Name + " -> " + ex.Message);
            }

            return passengerlst;
        }

        /// <summary>
        /// insert new passenger
        /// </summary>
        /// <param name="fID"></param>
        /// <param name="pass"></param>
        /// <returns></returns>
        public bool insertNewPassenger(String fID, Passenger pass)
        {
            try
            {
               Data.ExecuteNonQuery(sql.insertPassenger(pass));
               string first = pass.passfName;
               string last = pass.passlName;
               string id = Data.ExecuteScalarSQL(sql.getPassID(first, last));
               Data.ExecuteNonQuery(sql.insertPassengerLink(fID, id, pass.passSeat.ToString()));
            }
            catch (Exception ex)
            {
                throw new Exception(MethodInfo.GetCurrentMethod().DeclaringType.Name + "." + MethodInfo.GetCurrentMethod().Name + " -> " + ex.Message);
            }

            return true;
        }

        /// <summary>
        /// change the seat number
        /// </summary>
        /// <param name="fID"></param>
        /// <param name="passID"></param>
        /// <param name="seat"></param>
        public void UpdatePassengerSeatNumber(String fID, String passID, String seat)
        {
            try
            {
                Data.ExecuteNonQuery(sql.updateSeat(fID, passID, seat));
            }

            catch (Exception ex)
            {
                throw new Exception(MethodInfo.GetCurrentMethod().DeclaringType.Name + "." + MethodInfo.GetCurrentMethod().Name + " -> " + ex.Message);
            }

        }

        /// <summary>
        /// delete the passenger
        /// </summary>
        /// <param name="fID"></param>
        /// <param name="passID"></param>
        public void DeletePassenger(String fID, String passID)
        {
            try
            {
                Data.ExecuteNonQuery(sql.deletePassengerLink(fID, passID));
                Data.ExecuteNonQuery(sql.deletePassenger(passID));
                
            }
            catch (Exception ex)
            {
                throw new Exception(MethodInfo.GetCurrentMethod().DeclaringType.Name + "." + MethodInfo.GetCurrentMethod().Name + " -> " + ex.Message);
            }
        }


    }
}
