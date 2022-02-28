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
using System.Reflection;

namespace mathGame
{
    /// <summary>
    /// Interaction logic for Window2.xaml
    /// </summary>
    public partial class Window2 : Window
    {
        private int wins;
        private int losses;
        private clsUser Player;
        public Window2()
        {
            InitializeComponent();
            Player = new clsUser();

        }
       
        
        /// <summary>
        /// A method that is called to pass data in from Window 1, thi
        /// </summary>
        /// <param name="w"></param>
        /// <param name="l"></param>
        /// <param name="User"></param>
        /// <param name="t"></param>
        public void UserGameInfo(int w, int l, clsUser User, int t)
        {
            try
            {


                this.wins = w;
                this.losses = l;
                Player.age = User.age;
                Player.Name = User.Name;
                //Images were found on google by seaching 8bit images 
                if(w == 0 || w == 1|| w == 2 || w == 3 || w == 4)
                {
                    ImageBrush myBrush = new ImageBrush(new BitmapImage(new Uri(@"Images/lavalbl.jpg", UriKind.Relative)));

                    this.Background = myBrush; 
                }
                else if (w == 5 || w == 6 || w == 7)
                {
                    ImageBrush myBrush = new ImageBrush(new BitmapImage(new Uri(@"Images/Citylvl.jpg", UriKind.Relative)));

                    this.Background = myBrush;
                }
                else
                {
                    ImageBrush myBrush = new ImageBrush(new BitmapImage(new Uri(@"Images/skylvl.png.", UriKind.Relative)));

                    this.Background = myBrush;
                }
                UserDisplay.Content = "Name: " + Player.Name + "    Age:  " + Player.age;
                Correctlbl.Content = "Correct : " + wins;
                Incorrectlbl.Content = "Incorrect : " + losses;
                Timelbl.Content = "Total time : " + t;
            }
            catch (Exception ex)
            {
                throw new Exception(MethodInfo.GetCurrentMethod().DeclaringType.Name +
                    "." + MethodInfo.GetCurrentMethod().Name + "->" + ex.Message);
            }
        }
         
        
    }
}
