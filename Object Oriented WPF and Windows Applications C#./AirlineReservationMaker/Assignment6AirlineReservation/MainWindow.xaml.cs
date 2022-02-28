using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Assignment6AirlineReservation
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        /// <summary>
        /// This variable declares dataacess
        /// </summary>
        clsDataAccess clsData;
        /// <summary>
        /// this variable declares the add passenger window
        /// </summary>
        wndAddPassenger wndAddPass;
        /// <summary>
        /// this variable will is of type passenger and will be used when added a new passenger
        /// </summary>
        Passenger passenger;
        /// <summary>
        /// this variable will be used for flights
        /// </summary>
        AirlineFlight flights;
        /// <summary>
        /// this variable will be used for any flight logic
        /// </summary>
        clsAirlineLogic Air;
        /// <summary>
        /// we will use this list to fill up the combobox
        /// </summary>
        List<Passenger> pass;
        /// <summary>
        /// this variable will hold the current flight id at any time
        /// </summary>
        string fID;
        /// <summary>
        /// this variable will be used in both updating seats and changing passengers
        /// </summary>
        bool flag;
        /// <summary>
        /// this variable will be used when deleting passengers
        /// </summary>
        bool deleting;
        /// <summary>
        /// this list will be used to when updating taken and available seats
        /// </summary>
        List<Label> AirlineSeats;
        /// <summary>
        /// this is for the chosen index customer
        /// </summary>
        Passenger current;
        /// <summary>
        /// this variable will hold the selected seat 
        /// </summary>
        string seatn;


        /// <summary>
        /// available
        /// </summary>
        SolidColorBrush blue;
        /// <summary>
        /// selected
        /// </summary>
        SolidColorBrush green;
        /// <summary>
        /// taken
        /// </summary>
        SolidColorBrush red;

        /// <summary>
        /// the main window
        /// </summary>
        public MainWindow()
        {
            try
            {
                InitializeComponent();
                Application.Current.ShutdownMode = ShutdownMode.OnMainWindowClose;
                
                
                DataSet ds = new DataSet();
                passenger = new Passenger();
                flights = new AirlineFlight();
                Air = new clsAirlineLogic();
                pass = new List<Passenger>();
                flag = false;
                deleting = false;
 

                blue = new SolidColorBrush(Color.FromRgb(0x00, 0x35, 0xFD));
                red = new SolidColorBrush(Color.FromRgb(0xFD, 0x00, 0x00));
                green = new SolidColorBrush(Color.FromRgb(0x00, 0xFD, 0x00));

                String FID;

                clsData = new clsDataAccess();

                cbChooseFlight.ItemsSource = Air.getFlightlst();

            }
            catch (Exception ex)
            {
                HandleError(MethodInfo.GetCurrentMethod().DeclaringType.Name,
                    MethodInfo.GetCurrentMethod().Name, ex.Message);
            }
        }

        /// <summary>
        /// this is when the combobox is selected, the appropriate flight must appear
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void cbChooseFlight_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            try
            {
                int selection = cbChooseFlight.SelectedIndex; 
                cbChoosePassenger.IsEnabled = true;
                gPassengerCommands.IsEnabled = true;

                if (selection == 0)
                {
                    CanvasA380.Visibility = Visibility.Visible;
                    Canvas767.Visibility = Visibility.Hidden;
                    addSeats(1);
                    cmdChangeSeat.IsEnabled = false;
                    cmdDeletePassenger.IsEnabled = false;
                    current = null;
                    fID = ((AirlineFlight)cbChooseFlight.SelectedItem).flightID.ToString();
                    cbChoosePassenger.ItemsSource = Air.GetFlightPassengers(fID);
                    updateSeats(fID);
                    
               
                }
                else
                {
                    Canvas767.Visibility = Visibility.Visible;
                    CanvasA380.Visibility = Visibility.Hidden;
                    addSeats(2);
                    cmdChangeSeat.IsEnabled = false;
                    cmdDeletePassenger.IsEnabled = false;
                    current = null;
                    fID = ((AirlineFlight)cbChooseFlight.SelectedItem).flightID.ToString();
                    cbChoosePassenger.ItemsSource = Air.GetFlightPassengers(fID);
                    updateSeats(fID);
                   
                }
            }
            catch (Exception ex)
            {
                HandleError(MethodInfo.GetCurrentMethod().DeclaringType.Name,
                    MethodInfo.GetCurrentMethod().Name, ex.Message);
            }
        }
        /// <summary>
        /// when the passenger changes the label must change
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void cbChoosePassenger_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            try
            {
                if (current == null)
                {
                    lblPassengersSeatNumber.Content = " ";
                }
                current = ((Passenger)cbChoosePassenger.SelectedItem);
                if (current != null)
                {
                    lblPassengersSeatNumber.Content = current.passSeat.ToString();
                    gPassengerCommands.IsEnabled = true;
                    cmdChangeSeat.IsEnabled = true;
                    cmdDeletePassenger.IsEnabled = true;

                }
            }
            catch (System.Exception ex)
            {
                System.IO.File.AppendAllText(@"C:\Error.txt", Environment.NewLine + "HandleError Exception: " + ex.Message);
            }

        }

        /// <summary>
        /// the seats must be updated based on flight changes and deleted/added customers
        /// </summary>
        /// <param name="fID"></param>
        public void updateSeats(string fID)
        {
            try
            {
                pass = Air.GetFlightPassengers(fID);

                foreach (Passenger p in pass)
                {
                    foreach (Label seat in AirlineSeats)
                    {
                        seat.Background = blue;

                    }
                }
                foreach (Passenger p in pass)
                {
                    foreach (Label seat in AirlineSeats)
                    {
                        if (p.passSeat.ToString() == seat.Content.ToString())
                        {
                            seat.Background = red;
                        }

                    }
                }
            }
            catch (System.Exception ex)
            {
                System.IO.File.AppendAllText(@"C:\Error.txt", Environment.NewLine + "HandleError Exception: " + ex.Message);
            }


        }

        /// <summary>
        /// the first time the customer clicks this the form will apear,
        /// the second time will be after the passengers seat is selected
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void cmdAddPassenger_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (flag == false)
                {
                    wndAddPass = new wndAddPassenger();
                    wndAddPass.ShowDialog();
                    passman(wndAddPass.firstName(), wndAddPass.lastname());
                    lblPassengersSeat.Content = "Select Seat";
                    cmdChangeSeat.IsEnabled = false;
                    cmdDeletePassenger.IsEnabled = false;
                    cbChooseFlight.IsEnabled = false;
                    cbChoosePassenger.IsEnabled = false;
                    flag = true;

                }
                else if (flag == true)
                {
                    passenger.passSeat = Convert.ToInt32(seatn);
                    Air.insertNewPassenger(fID, passenger);
                    lblPassengersSeat.Content = "Passenger's Seat:";
                    cmdChangeSeat.IsEnabled = false;
                    cmdDeletePassenger.IsEnabled = true; 
                    cbChooseFlight.IsEnabled = true;
                    cbChoosePassenger.IsEnabled = true;
                    flag = false;
                }
                cbChoosePassenger.ItemsSource = Air.GetFlightPassengers(fID);
                updateSeats(fID);

            }
            catch (Exception ex)
            {
                HandleError(MethodInfo.GetCurrentMethod().DeclaringType.Name,
                    MethodInfo.GetCurrentMethod().Name, ex.Message);
            }
        }

        /// <summary>
        /// this guy just holds the passenger information from the add passenger window
        /// </summary>
        /// <param name="first"></param>
        /// <param name="last"></param>
        private void passman(string first, string last)
        {
            try
            {
                passenger.passfName = first;
                passenger.passlName = last;
            }
            catch (System.Exception ex)
            {
                System.IO.File.AppendAllText(@"C:\Error.txt", Environment.NewLine + "HandleError Exception: " + ex.Message);
            }

        }


        /// <summary>
        /// this will add the apropriate labels based on the flight selected
        /// </summary>
        /// <param name="x"></param>
        private void addSeats(int x)
        {
            try
            {
                switch (x)
                {
                    case 1:
                        AirlineSeats = new List<Label>{SeatA1, SeatA2, SeatA3, SeatA4, SeatA5,
                                                SeatA6, SeatA7, SeatA8, SeatA9, SeatA10,
                                                SeatA11, SeatA12, SeatA13, SeatA14, SeatA15 };
                        break;
                    case 2:
                        AirlineSeats = new List<Label> {Seat1, Seat2, Seat3, Seat4, Seat5,
                                                Seat6, Seat7, Seat8, Seat9, Seat10,
                                                Seat11, Seat12, Seat13, Seat14, Seat15, Seat16 };
                        break;
                }
            }
            catch (System.Exception ex)
            {
                System.IO.File.AppendAllText(@"C:\Error.txt", Environment.NewLine + "HandleError Exception: " + ex.Message);
            }
        }

        /// <summary>
        /// error handling 
        /// </summary>
        /// <param name="sClass"></param>
        /// <param name="sMethod"></param>
        /// <param name="sMessage"></param>
        private void HandleError(string sClass, string sMethod, string sMessage)
        {
            try
            {
                MessageBox.Show(sClass + "." + sMethod + " -> " + sMessage);
            }
            catch (System.Exception ex)
            {
                System.IO.File.AppendAllText(@"C:\Error.txt", Environment.NewLine + "HandleError Exception: " + ex.Message);
            }
        }

        /// <summary>
        ///when the passenger firsh clicks this button, space click is enabled, he or she 
        /// may then click it again once a seat is selected 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void cmdChangeSeat_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (flag == false)
                {
                    lblPassengersSeat.Content = "Select Avalable ";
                    cmdAddPassenger.IsEnabled = false;
                    cmdDeletePassenger.IsEnabled = false;
                    cbChooseFlight.IsEnabled = false;
                    cbChoosePassenger.IsEnabled = false;
                    flag = true;
                }
                else if (flag == true)
                {
                    current = ((Passenger)cbChoosePassenger.SelectedItem);
                    current.passSeat = Convert.ToInt32(seatn);
                    lblPassengersSeatNumber.Content = current.passSeat.ToString();
                    Air.UpdatePassengerSeatNumber(fID, current.passID.ToString(), seatn);
                    lblPassengersSeat.Content = "Passenger's Seat: ";
                    cmdAddPassenger.IsEnabled = true;
                    cmdDeletePassenger.IsEnabled = true;
                    cbChooseFlight.IsEnabled = true;
                    cbChoosePassenger.IsEnabled = true;
                    flag = false;
                }
                updateSeats(fID);
            }
            catch (System.Exception ex)
            {
                System.IO.File.AppendAllText(@"C:\Error.txt", Environment.NewLine + "HandleError Exception: " + ex.Message);
            }

        }

        /// <summary>
        /// delete the selected customer and refresh the combobox
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void cmdDeletePassenger_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                deleting = true;
                if (deleting)
                {
                    Air.DeletePassenger(fID, current.passID.ToString());
                    deleting = false;
                    cbChoosePassenger.ItemsSource = Air.GetFlightPassengers(fID);
                    updateSeats(fID);
                }
            }
            catch (Exception ex)
            {
                HandleError(MethodInfo.GetCurrentMethod().DeclaringType.Name,
                    MethodInfo.GetCurrentMethod().Name, ex.Message);
            }

        }

        /// <summary>
        /// spaceclick for when selecting a new customer seat or updating a existing seat
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Space_Click(object sender, MouseButtonEventArgs e)
        {
            try
            {
                Label seat = (Label)sender;
                if (flag == true)
                {
                    
                    if (seat.Background == red)
                    {
                        lblPassengersSeat.Content = "Try Again";
                    }
                    else if (seat.Background == blue)
                    {
                        seat.Background = green;
                        seatn = seat.Content.ToString();
                    }
                }

               
            }
            catch (Exception ex)
            {
                HandleError(MethodInfo.GetCurrentMethod().DeclaringType.Name,
                    MethodInfo.GetCurrentMethod().Name, ex.Message);
            }
        }


    }
}
