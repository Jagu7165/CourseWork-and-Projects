
namespace StudentGradesDisplay
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.SubmitBtn = new System.Windows.Forms.Button();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.textBox2 = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.LastBtn = new System.Windows.Forms.Button();
            this.NextBtn = new System.Windows.Forms.Button();
            this.PrevBtn = new System.Windows.Forms.Button();
            this.FirstBtn = new System.Windows.Forms.Button();
            this.ResetBtn = new System.Windows.Forms.Button();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.NameBtn = new System.Windows.Forms.Button();
            this.textBox3 = new System.Windows.Forms.TextBox();
            this.studentLabel = new System.Windows.Forms.Label();
            this.groupBox4 = new System.Windows.Forms.GroupBox();
            this.SubmitScoreBtn = new System.Windows.Forms.Button();
            this.textBox5 = new System.Windows.Forms.TextBox();
            this.textBox4 = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.Asslbl = new System.Windows.Forms.Label();
            this.DisplayBtn = new System.Windows.Forms.Button();
            this.textBox6 = new System.Windows.Forms.TextBox();
            this.CountsValidlbl = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.Invalidlbl = new System.Windows.Forms.Label();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.groupBox3.SuspendLayout();
            this.groupBox4.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.CountsValidlbl);
            this.groupBox1.Controls.Add(this.SubmitBtn);
            this.groupBox1.Controls.Add(this.textBox1);
            this.groupBox1.Controls.Add(this.textBox2);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Location = new System.Drawing.Point(78, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(554, 100);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Counts";
            this.groupBox1.Enter += new System.EventHandler(this.groupBox1_Enter);
            // 
            // SubmitBtn
            // 
            this.SubmitBtn.Location = new System.Drawing.Point(380, 37);
            this.SubmitBtn.Name = "SubmitBtn";
            this.SubmitBtn.Size = new System.Drawing.Size(75, 23);
            this.SubmitBtn.TabIndex = 3;
            this.SubmitBtn.Text = "Submit";
            this.SubmitBtn.UseVisualStyleBackColor = true;
            this.SubmitBtn.Click += new System.EventHandler(this.SubmitBtn_Click);
            // 
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(233, 28);
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(36, 20);
            this.textBox1.TabIndex = 1;
            this.textBox1.Text = " ";
            // 
            // textBox2
            // 
            this.textBox2.Location = new System.Drawing.Point(233, 56);
            this.textBox2.Name = "textBox2";
            this.textBox2.Size = new System.Drawing.Size(36, 20);
            this.textBox2.TabIndex = 2;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(54, 59);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(126, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = "Number Of Assignments :";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(54, 31);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(109, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "Number Of Students: ";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.LastBtn);
            this.groupBox2.Controls.Add(this.NextBtn);
            this.groupBox2.Controls.Add(this.PrevBtn);
            this.groupBox2.Controls.Add(this.FirstBtn);
            this.groupBox2.Location = new System.Drawing.Point(78, 118);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(663, 77);
            this.groupBox2.TabIndex = 1;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Navigate ";
            // 
            // LastBtn
            // 
            this.LastBtn.Enabled = false;
            this.LastBtn.Location = new System.Drawing.Point(504, 29);
            this.LastBtn.Name = "LastBtn";
            this.LastBtn.Size = new System.Drawing.Size(112, 23);
            this.LastBtn.TabIndex = 3;
            this.LastBtn.Text = "Last Student >>";
            this.LastBtn.UseVisualStyleBackColor = true;
            this.LastBtn.Click += new System.EventHandler(this.LastBtn_Click);
            // 
            // NextBtn
            // 
            this.NextBtn.Enabled = false;
            this.NextBtn.Location = new System.Drawing.Point(346, 29);
            this.NextBtn.Name = "NextBtn";
            this.NextBtn.Size = new System.Drawing.Size(109, 23);
            this.NextBtn.TabIndex = 2;
            this.NextBtn.Text = "Next Student > ";
            this.NextBtn.UseVisualStyleBackColor = true;
            this.NextBtn.Click += new System.EventHandler(this.NextBtn_Click);
            // 
            // PrevBtn
            // 
            this.PrevBtn.Enabled = false;
            this.PrevBtn.Location = new System.Drawing.Point(180, 29);
            this.PrevBtn.Name = "PrevBtn";
            this.PrevBtn.Size = new System.Drawing.Size(120, 23);
            this.PrevBtn.TabIndex = 1;
            this.PrevBtn.Text = "< Previous Student";
            this.PrevBtn.UseVisualStyleBackColor = true;
            this.PrevBtn.Click += new System.EventHandler(this.PrevBtn_Click);
            // 
            // FirstBtn
            // 
            this.FirstBtn.Enabled = false;
            this.FirstBtn.Location = new System.Drawing.Point(23, 29);
            this.FirstBtn.Name = "FirstBtn";
            this.FirstBtn.Size = new System.Drawing.Size(111, 23);
            this.FirstBtn.TabIndex = 0;
            this.FirstBtn.Text = "<< First Student";
            this.FirstBtn.UseVisualStyleBackColor = true;
            this.FirstBtn.Click += new System.EventHandler(this.FirstBtn_Click);
            // 
            // ResetBtn
            // 
            this.ResetBtn.Location = new System.Drawing.Point(656, 36);
            this.ResetBtn.Name = "ResetBtn";
            this.ResetBtn.Size = new System.Drawing.Size(75, 48);
            this.ResetBtn.TabIndex = 2;
            this.ResetBtn.Text = "Reset ";
            this.ResetBtn.UseVisualStyleBackColor = true;
            this.ResetBtn.Click += new System.EventHandler(this.ResetBtn_Click);
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.NameBtn);
            this.groupBox3.Controls.Add(this.textBox3);
            this.groupBox3.Controls.Add(this.studentLabel);
            this.groupBox3.Location = new System.Drawing.Point(78, 222);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(663, 77);
            this.groupBox3.TabIndex = 3;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Student Info";
            this.groupBox3.Enter += new System.EventHandler(this.groupBox3_Enter);
            // 
            // NameBtn
            // 
            this.NameBtn.Enabled = false;
            this.NameBtn.Location = new System.Drawing.Point(456, 23);
            this.NameBtn.Name = "NameBtn";
            this.NameBtn.Size = new System.Drawing.Size(75, 23);
            this.NameBtn.TabIndex = 2;
            this.NameBtn.Text = "Save Name";
            this.NameBtn.UseVisualStyleBackColor = true;
            this.NameBtn.Click += new System.EventHandler(this.NameBtn_Click);
            // 
            // textBox3
            // 
            this.textBox3.Location = new System.Drawing.Point(213, 25);
            this.textBox3.Name = "textBox3";
            this.textBox3.Size = new System.Drawing.Size(148, 20);
            this.textBox3.TabIndex = 1;
            // 
            // studentLabel
            // 
            this.studentLabel.AutoSize = true;
            this.studentLabel.Location = new System.Drawing.Point(77, 28);
            this.studentLabel.Name = "studentLabel";
            this.studentLabel.Size = new System.Drawing.Size(103, 13);
            this.studentLabel.TabIndex = 0;
            this.studentLabel.Text = "Student Number # 1";
            this.studentLabel.Visible = false;
            // 
            // groupBox4
            // 
            this.groupBox4.Controls.Add(this.Invalidlbl);
            this.groupBox4.Controls.Add(this.label5);
            this.groupBox4.Controls.Add(this.SubmitScoreBtn);
            this.groupBox4.Controls.Add(this.textBox5);
            this.groupBox4.Controls.Add(this.textBox4);
            this.groupBox4.Controls.Add(this.label4);
            this.groupBox4.Controls.Add(this.Asslbl);
            this.groupBox4.Location = new System.Drawing.Point(78, 305);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size(663, 100);
            this.groupBox4.TabIndex = 4;
            this.groupBox4.TabStop = false;
            this.groupBox4.Text = "Student Info ";
            // 
            // SubmitScoreBtn
            // 
            this.SubmitScoreBtn.Enabled = false;
            this.SubmitScoreBtn.Location = new System.Drawing.Point(456, 31);
            this.SubmitScoreBtn.Name = "SubmitScoreBtn";
            this.SubmitScoreBtn.Size = new System.Drawing.Size(98, 23);
            this.SubmitScoreBtn.TabIndex = 4;
            this.SubmitScoreBtn.Text = "Submit Score";
            this.SubmitScoreBtn.UseVisualStyleBackColor = true;
            this.SubmitScoreBtn.Click += new System.EventHandler(this.SubmitScoreBtn_Click);
            // 
            // textBox5
            // 
            this.textBox5.Location = new System.Drawing.Point(289, 54);
            this.textBox5.Name = "textBox5";
            this.textBox5.Size = new System.Drawing.Size(72, 20);
            this.textBox5.TabIndex = 3;
            // 
            // textBox4
            // 
            this.textBox4.Location = new System.Drawing.Point(289, 16);
            this.textBox4.Name = "textBox4";
            this.textBox4.Size = new System.Drawing.Size(72, 20);
            this.textBox4.TabIndex = 2;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(77, 54);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(137, 13);
            this.label4.TabIndex = 1;
            this.label4.Text = "Assignment Score (0-100) : ";
            // 
            // Asslbl
            // 
            this.Asslbl.AutoSize = true;
            this.Asslbl.Location = new System.Drawing.Point(77, 16);
            this.Asslbl.Name = "Asslbl";
            this.Asslbl.Size = new System.Drawing.Size(162, 13);
            this.Asslbl.TabIndex = 0;
            this.Asslbl.Text = "Enter Assignment Number  (1-5) :";
            this.Asslbl.Visible = false;
            // 
            // DisplayBtn
            // 
            this.DisplayBtn.Enabled = false;
            this.DisplayBtn.Location = new System.Drawing.Point(234, 425);
            this.DisplayBtn.Name = "DisplayBtn";
            this.DisplayBtn.Size = new System.Drawing.Size(83, 34);
            this.DisplayBtn.TabIndex = 5;
            this.DisplayBtn.Text = "Display\r\n Scores";
            this.DisplayBtn.UseVisualStyleBackColor = true;
            this.DisplayBtn.Click += new System.EventHandler(this.DisplayBtn_Click);
            // 
            // textBox6
            // 
            this.textBox6.AcceptsReturn = true;
            this.textBox6.Location = new System.Drawing.Point(78, 465);
            this.textBox6.Multiline = true;
            this.textBox6.Name = "textBox6";
            this.textBox6.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.textBox6.Size = new System.Drawing.Size(663, 224);
            this.textBox6.TabIndex = 6;
            this.textBox6.WordWrap = false;
            // 
            // CountsValidlbl
            // 
            this.CountsValidlbl.AutoSize = true;
            this.CountsValidlbl.Location = new System.Drawing.Point(275, 63);
            this.CountsValidlbl.Name = "CountsValidlbl";
            this.CountsValidlbl.Size = new System.Drawing.Size(269, 26);
            this.CountsValidlbl.TabIndex = 4;
            this.CountsValidlbl.Text = "Invalid Input! Please keep student count between 1-10,\r\n              and Assignm" +
    "ent count bwtween (1-100)";
            this.CountsValidlbl.Visible = false;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(419, 60);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(10, 13);
            this.label5.TabIndex = 5;
            this.label5.Text = " ";
            // 
            // Invalidlbl
            // 
            this.Invalidlbl.AutoSize = true;
            this.Invalidlbl.Location = new System.Drawing.Point(439, 71);
            this.Invalidlbl.Name = "Invalidlbl";
            this.Invalidlbl.Size = new System.Drawing.Size(115, 13);
            this.Invalidlbl.TabIndex = 3;
            this.Invalidlbl.Text = "Invalid Input! Try again";
            this.Invalidlbl.Visible = false;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 726);
            this.Controls.Add(this.textBox6);
            this.Controls.Add(this.DisplayBtn);
            this.Controls.Add(this.groupBox4);
            this.Controls.Add(this.groupBox3);
            this.Controls.Add(this.ResetBtn);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            this.groupBox4.ResumeLayout(false);
            this.groupBox4.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Button SubmitBtn;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.TextBox textBox2;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Button LastBtn;
        private System.Windows.Forms.Button NextBtn;
        private System.Windows.Forms.Button PrevBtn;
        private System.Windows.Forms.Button FirstBtn;
        private System.Windows.Forms.Button ResetBtn;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.Button NameBtn;
        private System.Windows.Forms.TextBox textBox3;
        private System.Windows.Forms.Label studentLabel;
        private System.Windows.Forms.GroupBox groupBox4;
        private System.Windows.Forms.Button SubmitScoreBtn;
        private System.Windows.Forms.TextBox textBox5;
        private System.Windows.Forms.TextBox textBox4;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label Asslbl;
        private System.Windows.Forms.Button DisplayBtn;
        private System.Windows.Forms.TextBox textBox6;
        private System.Windows.Forms.Label CountsValidlbl;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label Invalidlbl;
    }
}

