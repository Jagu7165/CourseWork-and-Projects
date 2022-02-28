using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Hw1Part1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            DialogResult myResult;
            myResult = MessageBox.Show("You typed: " + textBox1.Text,"Caption 1", MessageBoxButtons.OKCancel, MessageBoxIcon.Question);
            label1.Text = "You clicked the " + myResult.ToString() + " button";


        }

        private void button2_Click(object sender, EventArgs e)
        {
            DialogResult myResult;
            myResult = MessageBox.Show("You typed: " + textBox2.Text, "Caption 1", MessageBoxButtons.YesNo, MessageBoxIcon.Stop);
            label2.Text = "You clicked the " + myResult.ToString() + " button";

        }

        private void button3_Click(object sender, EventArgs e)
        {
            DialogResult myResult;
            myResult = MessageBox.Show("You typed: " + textBox3.Text, "Caption 1", MessageBoxButtons.AbortRetryIgnore, MessageBoxIcon.Information);
            label3.Text = "You clicked the " + myResult.ToString() + " button";

        }

        private void label6_Click(object sender, EventArgs e)
        {

        }
    }
}
