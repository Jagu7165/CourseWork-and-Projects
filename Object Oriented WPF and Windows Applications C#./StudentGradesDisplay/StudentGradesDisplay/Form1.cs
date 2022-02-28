using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace StudentGradesDisplay
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();

        }

        //variables for honding current student index
        //number of students and number of assignments
        int currentStudent = 0;
        int numOfStudents = 0;
        int numOfAssignments = 0;

        //arrrays for storing names and scores
        string[] studentNames;
        double[,] studentScors;


        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }

        private void groupBox3_Enter(object sender, EventArgs e)
        {

        }


        /// <summary>
        /// this method sets the assignment label apporpirately
        /// </summary>
        /// <param name="upperBound"></param>
        private void setAsslbl(int upperBound)
        {
            Asslbl.Text = string.Format("Enter Assignment Number (1-{0})", upperBound);
        }


        /// <summary>
        /// this method sets the display header
        /// </summary>
        public void setDisplay()
        {
            string header = "Student\t\t";
            int count = 1;
            for (int i = 0; i < numOfAssignments; i++)
            {

                header += string.Format("#{0}\t", count);
                count++;
            }
            header += string.Format("AVG\t Grade\t\n");
            textBox6.Text = header;
        }


        /// <summary>
        /// this method sets all students in the student array to student numbers and 
        /// sets all scores to zero
        /// </summary>
        private void setValues()
        {
            for (int i = 0; i < studentNames.Length; i++)
            {
                studentNames[i] = string.Format("Student {0}", i + 1);
            }

            for (int row = 0; row < studentScors.GetLength(0); row++)
            {
                for (int column = 0; column < studentScors.GetLength(1); column++)
                {
                    studentScors[row, column] = 0;
                }
            }
        }


        /// <summary>
        /// this method will be used to calculate grade
        /// </summary>
        /// <param name="dub"></param>
        /// <returns></returns>
        private char calculateGrade(double dub)
        {

            if (dub > 90)
            {
                return 'A';
            }
            else if (90 > dub && dub > 80)
            {
                return 'B';
            }
            else if (80 > dub && dub > 70)
            {
                return 'C';
            }
            else if (70 > dub && dub > 60)
            {
                return 'D';
            }
            else
            {
                return 'E';
            }

        }

        /// <summary>
        /// thios method will set appropriate values once the submit button is clicked
        /// and will enable the other buttons 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void SubmitBtn_Click(object sender, EventArgs e)
        {

            int studentCount; 
            int assignCount;
            bool valid = Int32.TryParse(textBox1.Text, out studentCount);
            bool valid2 = Int32.TryParse(textBox2.Text, out assignCount);
            if (studentCount < 1 || studentCount > 10 || !valid || assignCount<1 || assignCount > 100||!valid2)
            {
                CountsValidlbl.Visible = true;
            }
            else
            {
                CountsValidlbl.Visible = false;
                numOfAssignments = assignCount;
                numOfStudents = studentCount;
                studentNames = new string[studentCount];
                studentScors = new double[studentCount, assignCount];
                setAsslbl(assignCount);
                setValues();
                setDisplay();

                Asslbl.Visible = true;
                studentLabel.Visible = true;

                FirstBtn.Enabled = true;
                PrevBtn.Enabled = true;
                NextBtn.Enabled = true;
                NameBtn.Enabled = true;
                SubmitScoreBtn.Enabled = true;
                LastBtn.Enabled = true;
                DisplayBtn.Enabled = true;
                
            }
        }


        /// <summary>
        /// this method will update the scores 
        /// array as a score is submitted using the submit score button
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void SubmitScoreBtn_Click(object sender, EventArgs e)
        {

            int scoreNum;
            double Score;
            bool valid = Int32.TryParse(textBox4.Text, out scoreNum);
            bool valid2 = Double.TryParse(textBox5.Text, out Score);
            if (scoreNum < 1 || scoreNum > numOfAssignments || !valid || Score < 0 || Score> 100 || !valid2)
            {
                Invalidlbl.Visible = true;
            }
            else
            {
                Invalidlbl.Visible = false;
                studentScors[currentStudent, scoreNum-1] = Score;
            }
        }

        /// <summary>
        /// this method will set values into the name array
        /// no user input here because some people name their kids 
        /// wierd things irl
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void NameBtn_Click(object sender, EventArgs e)
        {
            string name = textBox3.Text; 
            if (name =="")
            {
                
            }
            else
            {
                studentNames[currentStudent] = name;
            }

        }


        /// <summary>
        /// this method sets the current index to the first student 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void FirstBtn_Click(object sender, EventArgs e)
        {
            currentStudent = 0;
            studentLabel.Text = string.Format("Student #{0} : ", 1);
        }


        //this method decriments the current index when it needs to 
        private void PrevBtn_Click(object sender, EventArgs e)
        {
            //this will wrap the array around if the user tries to decriment too far
            if (currentStudent == 0)
            {
                currentStudent = numOfStudents-1;
                studentLabel.Text = string.Format("Student #{0} : ", currentStudent+1);
            }
            else
            {
                currentStudent= currentStudent-1;
                studentLabel.Text = string.Format("Student #{0} : ", currentStudent+1);
            }
        }

        /// <summary>
        /// this method will incriment the current index if need to
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void NextBtn_Click(object sender, EventArgs e)
        {
            //this will wrap the array around if the user tries to incriment too far
            if(currentStudent == numOfStudents-1)
            {
                currentStudent = 0;
                studentLabel.Text = string.Format("Student #{0} : ", currentStudent+1);
            }
            else
            {
                currentStudent = currentStudent + 1;
                studentLabel.Text = string.Format("Student #{0} : ", currentStudent+1);
            }
        }

        /// <summary>
        /// this method sets the current index to the last student 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void LastBtn_Click(object sender, EventArgs e)
        {
            currentStudent = numOfStudents-1;
            studentLabel.Text = string.Format("Student #{0} : ", currentStudent+1);
        }


        /// <summary>
        /// this method will set and update the display as the user inters values  
        /// and then clicks the display button
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void DisplayBtn_Click(object sender, EventArgs e)
        {
            setDisplay();

           

            for(int row = 0; row<studentScors.GetLength(0); row++)
            {
                double sum = 0;
                double avg = 0;
                textBox6.Text += string.Format("\r\n{0}\t\t", studentNames[row]);
                for (int column = 0; column < studentScors.GetLength(1); column++)
                {
                    textBox6.Text += string.Format("{0}\t", studentScors[row, column]);
                    sum += studentScors[row,column];
                    avg++;
                }
                avg = sum / avg;
                char grade = calculateGrade(avg);
                textBox6.Text += string.Format( "{0:f2}\t {1}", avg, grade);
            }
        }

        /// <summary>
        /// this method will reset enerything to being blank 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void ResetBtn_Click(object sender, EventArgs e)
        {

            //clear text boxes
            textBox1.Text = "";
            textBox2.Text = "";
            textBox3.Text = "";
            textBox4.Text = "";
            textBox5.Text = "";
            textBox6.Text = "";

            //disable bottom buttons 
            FirstBtn.Enabled = false;
            PrevBtn.Enabled = false;
            NextBtn.Enabled = false;
            LastBtn.Enabled = false;
            DisplayBtn.Enabled = false;
            NameBtn.Enabled = false;
            SubmitScoreBtn.Enabled = false;

            studentLabel.Visible = false;
            Asslbl.Visible = false;

        }
    }
}
