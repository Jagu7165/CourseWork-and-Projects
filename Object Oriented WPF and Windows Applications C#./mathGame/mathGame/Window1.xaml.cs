using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.Windows.Threading;
using System.Reflection;
using System.Media;

namespace mathGame
{
    /// <summary>
    /// Interaction logic for Window1.xaml
    /// </summary>
    public partial class Window1 : Window
    {
        private string type;
        clsUser Player;
        clsGame Gameboi;
       
        DispatcherTimer MyTimer;
        private int time = 0;
        public Window1()
        {
            try
            {
                InitializeComponent();
                Player = new clsUser();
                Gameboi = new clsGame();
                Submitbtn.IsEnabled = false;
            }
            catch(Exception ex)
            {
                throw new Exception(MethodInfo.GetCurrentMethod().DeclaringType.Name +
                    "." + MethodInfo.GetCurrentMethod().Name + "->" + ex.Message);
            }


        }
        /// <summary>
        /// method used to recieve the type of math game user gets to play
        /// </summary>
        /// <param name="type"></param>
        public void getType(string type)
        {
            
            this.type = type;
        }
        /// <summary>
        /// Method that is called when the Start button is pressed
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                MyTimer = new DispatcherTimer();
                MyTimer.Interval = TimeSpan.FromSeconds(1);
                MyTimer.Start();
                MyTimer.Tick += MyTimer_Tick1;
                Questionlbl.Content = Gameboi.giveQuestion(type);
                Submitbtn.IsEnabled = true;
                Startbtn.IsEnabled = false;
            }
            catch (Exception ex)
            {
                throw new Exception(MethodInfo.GetCurrentMethod().DeclaringType.Name +
                    "." + MethodInfo.GetCurrentMethod().Name + "->" + ex.Message);
            }
        }
        /// <summary>
        /// The method that is called when the submit button is pressed
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            try
            {
                int num;

                bool valid = Int32.TryParse(UserGuess.Text, out num);
                if (valid)
                {
                    Gameboi.getAnswer(UserGuess.Text);

                    SoundPlayer simpleSound = new SoundPlayer("8bit-right.WAV");
                    SoundPlayer simpleSound2 = new SoundPlayer("8bit-wrong.WAV");


                    if (Gameboi.wincheck())
                    {
                        WinCheck.Content = "Thats Correct!";
                        simpleSound.Play();
                    }
                    else
                    {
                        WinCheck.Content = "Incorrect!";
                        simpleSound2.Play();
                    }

                    Questionlbl.Content = Gameboi.giveQuestion(type);
                    if (Gameboi.limitCheck())
                    {
                        MyTimer.Stop();
                        Window2 scores = new Window2();
                        scores.UserGameInfo(Gameboi.wins(), Gameboi.loses(), Player, time);
                        scores.Show();
                        this.Close();
                    }
                }
                else
                {
                    WinCheck.Content = "Enter a Number";
                }
            }
            catch (Exception ex)
            {
                throw new Exception(MethodInfo.GetCurrentMethod().DeclaringType.Name +
                    "." + MethodInfo.GetCurrentMethod().Name + "->" + ex.Message);
            }
        }

        /// <summary>
        /// Methis that is used to recieve the User info
        /// </summary>
        /// <param name="Us"></param>
        public void getPlayerInfo(clsUser Us)
        {
            try
            {
                Player.age = Us.age;
                Player.Name = Us.Name;
                WinCheck.Content = Player.Name;
                WinCheck.Content = "Hi " + Player.Name;
            }
            catch (Exception ex)
            {
                throw new Exception(MethodInfo.GetCurrentMethod().DeclaringType.Name +
                    "." + MethodInfo.GetCurrentMethod().Name + "->" + ex.Message);
            }
        }

        /// <summary>
        /// Timer click method used to update the label
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void MyTimer_Tick1(Object sender, EventArgs e)
        {
            try
            {
                time++;
                Timerlbl.Content = time.ToString();
            }
            catch (Exception ex)
            {
                throw new Exception(MethodInfo.GetCurrentMethod().DeclaringType.Name +
                    "." + MethodInfo.GetCurrentMethod().Name + "->" + ex.Message);
            }
        }

        /// <summary>
        /// The method used to return to main menu
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Button_Click_2(object sender, RoutedEventArgs e)
        {
            try
            {
                this.Close();
            }
            catch (Exception ex)
            {
                throw new Exception(MethodInfo.GetCurrentMethod().DeclaringType.Name +
                    "." + MethodInfo.GetCurrentMethod().Name + "->" + ex.Message);
            }
        }
    }
}
