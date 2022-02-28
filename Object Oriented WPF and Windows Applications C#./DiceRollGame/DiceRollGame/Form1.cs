using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DiceRollGame
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        //Game Info variables
        int numOfTimesPLayed=0;    
        int numOftimesWon=0;
        int NumofTimesLost=0;
        //result and user guess variables
        int ones=0, twos=0, threes=0, fours=0, fives=0, sixs=0;
        int onesG=0, twosG=0, threesG=0, foursG=0, fivesG=0, sixsG=0;

    

        /// <summary>
        /// This method symulates a dice roll and stores the result
        /// </summary>
        /// <returns></returns>
        private int diceRollMethod()
        {
            int rnd = 0;
            Random rand = new Random();

            for (int i = 1; i < 7; ++i)
            {
                rnd = rand.Next(1, 7);
                pb.Image = Image.FromFile("die" + rnd.ToString() + ".gif");

                pb.Refresh();
                Thread.Sleep(300);
            }

            return rnd;
        }


        /// <summary>
        /// This method will update the variables every time the roll button is pressed
        /// </summary>
        /// <param name="guess"></param>
        /// <param name="answer"></param>
        private void updateInfo(int guess, int answer)
        {


            //switch statement will incriment correct variable
            switch (answer) 
            {
                case 1:
                    ones++;
                    break;
                case 2:
                    twos++;
                    break;
                case 3:
                    threes++;
                    break;
                case 4:
                    fours++;
                    break;
                case 5:
                    fives++;
                    break;
                case 6:
                    sixs++;
                    break;
            }

            //switch statement will incriment correct guess
            switch (guess)
            {
                case 1:
                    onesG++;
                    break;
                case 2:
                    twosG++;
                    break;
                case 3:
                    threesG++;
                    break;
                case 4:
                    foursG++;
                    break;
                case 5:
                    fivesG++;
                    break;
                case 6:
                    sixsG++;
                    break;

            }
            if (guess == answer)
            {
                numOfTimesPLayed++;
                numOftimesWon++;
            }
            else
            {
                NumofTimesLost++;
                numOfTimesPLayed++;
            }
        }

        /// <summary>
        /// this method will display the updated information in game info, and update the game 
        /// statistics textrbox
        /// </summary>
        /// <param name="guess"></param>
        /// <param name="answer"></param>
        private void DisplayInfo(int guess, int answer)
        {
            played.Text = numOfTimesPLayed.ToString();
            Won.Text = numOftimesWon.ToString();
            Lost.Text = NumofTimesLost.ToString();

            textBox2.Text = String.Format("FACE\tFREQUENCY\t    PERCENT\tNUMBER OF TIMES GUESSED\n") +
                            String.Format("\r\n1\t\t{0}\t\t{1:f2}%\t\t{2}", ones, ((double)ones/numOfTimesPLayed)*100, onesG) +
                            String.Format("\r\n2\t\t{0}\t\t{1:f2}%\t\t{2}", twos, ((double)twos / numOfTimesPLayed)*100, twosG) +
                            String.Format("\r\n3\t\t{0}\t\t{1:f2}%\t\t{2}", threes,((double) threes / numOfTimesPLayed)*100, threesG) +
                            String.Format("\r\n4\t\t{0}\t\t{1:f2}%\t\t{2}", fours, ((double)fours / numOfTimesPLayed)*100, foursG) +
                            String.Format("\r\n5\t\t{0}\t\t{1:f2}%\t\t{2}", fives, ((double)fives / numOfTimesPLayed)*100, fivesG) +
                            String.Format("\r\n6\t\t{0}\t\t{1:f2}%\t\t{2}", sixs, ((double)sixs / numOfTimesPLayed)*100, sixsG);
        }

        /// <summary>
        /// This method will be used to clear the info on the screan and 
        /// will also be called when the reset buttion is pressed
        /// </summary>
        private void clearInfo()
        {

            //reset roll variables to 0
            ones = 0;
            twos = 0;
            threes = 0;
            fours = 0;
            fives = 0;
            sixs = 0;

            //reset user guesses to zero
            onesG = 0;
            twosG = 0;
            threesG = 0;
            foursG = 0;
            fivesG = 0;
            sixsG = 0;

            //reset game info to zero
            numOfTimesPLayed = 0;
            numOftimesWon = 0;
            NumofTimesLost = 0; 

            //display all zeros
            played.Text = numOfTimesPLayed.ToString();
            Won.Text = numOftimesWon.ToString();
            Lost.Text = NumofTimesLost.ToString();
            textBox2.Text = String.Format("FACE\tFREQUENCY\t    PERCENT\tNUMBER OF TIMES GUESSED") +
                            String.Format("\r\n1\t\t{0}\t\t{1:f2}%\t\t{2}", ones, 0, onesG) +
                            String.Format("\r\n2\t\t{0}\t\t{1:f2}%\t\t{2}", twos, 0, twosG) +
                            String.Format("\r\n3\t\t{0}\t\t{1:f2}%\t\t{2}", threes,0, threesG) +
                            String.Format("\r\n4\t\t{0}\t\t{1:f2}%\t\t{2}", fours, 0, foursG) +
                            String.Format("\r\n5\t\t{0}\t\t{1:f2}%\t\t{2}", fives, 0, fivesG) +
                            String.Format("\r\n6\t\t{0}\t\t{1:f2}%\t\t{2}", sixs, 0, sixsG);

            //clear input textbox
            textBox1.Text = "";

            //5 sided die will be default image
            pb.Image = Image.FromFile("die" + 5 + ".gif");
            pb.Refresh();
        }



        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// This method simulates a dice roll and dispays the correct information on the form when
        /// the roll button is pressed
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void button1_Click(object sender, EventArgs e)
        {


            int answer = 0;
            int userGuess;
            bool valid = Int32.TryParse(textBox1.Text, out userGuess);
            if (userGuess < 1 || userGuess > 6 || !valid)
            {
                DialogResult myResult;
                myResult = MessageBox.Show("Enter a value between 1 and 6 ", "Warning!", MessageBoxButtons.OK , MessageBoxIcon.Stop);
            }
            else
            {
                answer = diceRollMethod();
                updateInfo(userGuess, answer);
                DisplayInfo(userGuess, answer);
            }
        }


        /// <summary>
        /// this method calls clearInfo when the reset button is pressed
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void button2_Click(object sender, EventArgs e)
        {
            clearInfo();
        }

        //main method will display clear info when the form loads
        private void Form1_Load(object sender, EventArgs e)
        {
            clearInfo();
        }

    }
}