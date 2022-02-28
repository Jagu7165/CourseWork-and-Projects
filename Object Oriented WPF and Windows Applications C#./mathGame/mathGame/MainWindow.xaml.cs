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
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Reflection;

namespace mathGame
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            Warninglbl.Visibility = Visibility.Hidden;
            
        }

        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
          
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            try
            {

                if (UserValid() && radioCheck() && ageValid())
                {
                    //This is a test attribute
                    int Ageapp;
                    bool valid2 = Int32.TryParse(Age.Text, out Ageapp);
                    clsUser User = new clsUser(Useraneme.Text, Ageapp);
                    Window1 gameWindow = new Window1();
                    gameWindow.getPlayerInfo(User);
                    gameWindow.getType(getGameType());
                    gameWindow.ShowDialog();
                }
                else if (!UserValid())
                {
                    Warninglbl.Visibility = Visibility.Visible;
                    Warninglbl.Content = "Enter a valid Name ";
                }
                else if (!radioCheck())
                {
                    Warninglbl.Visibility = Visibility.Visible;
                    Warninglbl.Content = "Please Select a game";
                }
                else if (!ageValid())
                {
                    Warninglbl.Visibility = Visibility.Visible;
                    Warninglbl.Content = "Enter a correct age (1-10) ";
                }
                else
                {
                    Warninglbl.Visibility = Visibility.Visible;
                    Warninglbl.Content = "Please double check your input and try again";
                }
            }catch (Exception ex)
            {
                HandleError(MethodInfo.GetCurrentMethod().DeclaringType.Name,
                     MethodInfo.GetCurrentMethod().Name, ex.Message);
            }

        }
        private bool UserValid()
        {
            try
            {
                if (Useraneme.Text != "")
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }catch (Exception ex)
            {
                throw new Exception(MethodInfo.GetCurrentMethod().DeclaringType.Name +
                    "." + MethodInfo.GetCurrentMethod().Name + "->" + ex.Message);


            }
        }
        private bool ageValid()
        {
            try
            {
                int Ageapp;
                bool valid2 = Int32.TryParse(Age.Text, out Ageapp);
                if (Ageapp == 1 || Ageapp == 2 || Ageapp == 3 || Ageapp == 4 ||
                    Ageapp == 5 || Ageapp == 6 || Ageapp == 7 || Ageapp == 8 || Ageapp == 9
                    || Ageapp == 10)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(MethodInfo.GetCurrentMethod().DeclaringType.Name +
                    "." + MethodInfo.GetCurrentMethod().Name + "->" + ex.Message);


            }
        }

        private bool radioCheck()
        {
            try
            {
                if (Add.IsChecked == true || Subtract.IsChecked == true
                    || Divide.IsChecked == true || Multiply.IsChecked == true)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(MethodInfo.GetCurrentMethod().DeclaringType.Name +
                    "." + MethodInfo.GetCurrentMethod().Name + "->" + ex.Message);

            }
        }

        private string getGameType()
        {
            try
            {
                string gameName;
                if (Add.IsChecked == true)
                {
                    gameName = "Add";
                }
                else if (Subtract.IsChecked == true)
                {
                    gameName = "Subtract";
                }
                else if (Divide.IsChecked == true)
                {
                    gameName = "Divide";
                }
                else
                {
                    gameName = "Multiply";
                }
                return gameName;
            }
            catch (Exception ex) 
            {
                throw new Exception(MethodInfo.GetCurrentMethod().DeclaringType.Name +
                     "." + MethodInfo.GetCurrentMethod().Name + "->" + ex.Message);
            }
        }
        private void HandleError(String s , String m, String sm)
        {
            try
            {
                MessageBox.Show(s + "." + m + "." + sm);
            }
            catch(Exception ex)
            {
                System.IO.File.AppendAllText("C:\\Errortxt", Environment.NewLine +
                                            "Handle Error Exceptoin: " + ex.Message);
            }
        }
    
    }

}
