
namespace DiceRollGame
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.Lost = new System.Windows.Forms.Label();
            this.Won = new System.Windows.Forms.Label();
            this.played = new System.Windows.Forms.Label();
            this.lblLost = new System.Windows.Forms.Label();
            this.lblWon = new System.Windows.Forms.Label();
            this.lblPlayed = new System.Windows.Forms.Label();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.textBox2 = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.RollerBtn = new System.Windows.Forms.Button();
            this.ResetBtn = new System.Windows.Forms.Button();
            this.pb = new System.Windows.Forms.PictureBox();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pb)).BeginInit();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.Lost);
            this.groupBox1.Controls.Add(this.Won);
            this.groupBox1.Controls.Add(this.played);
            this.groupBox1.Controls.Add(this.lblLost);
            this.groupBox1.Controls.Add(this.lblWon);
            this.groupBox1.Controls.Add(this.lblPlayed);
            this.groupBox1.Location = new System.Drawing.Point(218, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(242, 126);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Game Info";
            this.groupBox1.Enter += new System.EventHandler(this.groupBox1_Enter);
            // 
            // Lost
            // 
            this.Lost.AutoSize = true;
            this.Lost.Location = new System.Drawing.Point(147, 95);
            this.Lost.Name = "Lost";
            this.Lost.Size = new System.Drawing.Size(0, 13);
            this.Lost.TabIndex = 5;
            // 
            // Won
            // 
            this.Won.AutoSize = true;
            this.Won.Location = new System.Drawing.Point(147, 55);
            this.Won.Name = "Won";
            this.Won.Size = new System.Drawing.Size(0, 13);
            this.Won.TabIndex = 4;
            // 
            // played
            // 
            this.played.AutoSize = true;
            this.played.Location = new System.Drawing.Point(144, 20);
            this.played.Name = "played";
            this.played.Size = new System.Drawing.Size(0, 13);
            this.played.TabIndex = 3;
            // 
            // lblLost
            // 
            this.lblLost.AutoSize = true;
            this.lblLost.Location = new System.Drawing.Point(7, 95);
            this.lblLost.Name = "lblLost";
            this.lblLost.Size = new System.Drawing.Size(121, 13);
            this.lblLost.TabIndex = 2;
            this.lblLost.Text = "Number Of Times Lost : ";
            // 
            // lblWon
            // 
            this.lblWon.AutoSize = true;
            this.lblWon.Location = new System.Drawing.Point(7, 55);
            this.lblWon.Name = "lblWon";
            this.lblWon.Size = new System.Drawing.Size(124, 13);
            this.lblWon.TabIndex = 1;
            this.lblWon.Text = "Number Of Times Won : ";
            // 
            // lblPlayed
            // 
            this.lblPlayed.AutoSize = true;
            this.lblPlayed.Location = new System.Drawing.Point(7, 20);
            this.lblPlayed.Name = "lblPlayed";
            this.lblPlayed.Size = new System.Drawing.Size(133, 13);
            this.lblPlayed.TabIndex = 0;
            this.lblPlayed.Text = "Number Of Times Played : ";
            // 
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(405, 156);
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(55, 20);
            this.textBox1.TabIndex = 1;
            // 
            // textBox2
            // 
            this.textBox2.AcceptsReturn = true;
            this.textBox2.AcceptsTab = true;
            this.textBox2.Location = new System.Drawing.Point(218, 272);
            this.textBox2.Multiline = true;
            this.textBox2.Name = "textBox2";
            this.textBox2.Size = new System.Drawing.Size(404, 137);
            this.textBox2.TabIndex = 2;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(242, 159);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(120, 13);
            this.label1.TabIndex = 3;
            this.label1.Text = "Enter Your Guess (1-6)! ";
            this.label1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // RollerBtn
            // 
            this.RollerBtn.Location = new System.Drawing.Point(479, 190);
            this.RollerBtn.Name = "RollerBtn";
            this.RollerBtn.Size = new System.Drawing.Size(75, 23);
            this.RollerBtn.TabIndex = 4;
            this.RollerBtn.Text = "Roll";
            this.RollerBtn.UseVisualStyleBackColor = true;
            this.RollerBtn.Click += new System.EventHandler(this.button1_Click);
            // 
            // ResetBtn
            // 
            this.ResetBtn.Location = new System.Drawing.Point(479, 243);
            this.ResetBtn.Name = "ResetBtn";
            this.ResetBtn.Size = new System.Drawing.Size(75, 23);
            this.ResetBtn.TabIndex = 5;
            this.ResetBtn.Text = "Reset";
            this.ResetBtn.UseVisualStyleBackColor = true;
            this.ResetBtn.Click += new System.EventHandler(this.button2_Click);
            // 
            // pb
            // 
            this.pb.InitialImage = ((System.Drawing.Image)(resources.GetObject("pb.InitialImage")));
            this.pb.Location = new System.Drawing.Point(221, 190);
            this.pb.Name = "pb";
            this.pb.Size = new System.Drawing.Size(100, 76);
            this.pb.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pb.TabIndex = 6;
            this.pb.TabStop = false;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.pb);
            this.Controls.Add(this.ResetBtn);
            this.Controls.Add(this.RollerBtn);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.textBox2);
            this.Controls.Add(this.textBox1);
            this.Controls.Add(this.groupBox1);
            this.Name = "Form1";
            this.Text = " ";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pb)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.TextBox textBox2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button RollerBtn;
        private System.Windows.Forms.Button ResetBtn;
        private System.Windows.Forms.PictureBox pb;
        private System.Windows.Forms.Label lblLost;
        private System.Windows.Forms.Label lblWon;
        private System.Windows.Forms.Label lblPlayed;
        private System.Windows.Forms.Label played;
        private System.Windows.Forms.Label Lost;
        private System.Windows.Forms.Label Won;
    }
}

