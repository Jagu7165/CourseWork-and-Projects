using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace mathGame
{
    class clsGame
    {
        private int correctAns;
        private int incorrectAns;
        private int guess;
        private int answer;

        public int Correct()
        {
            return correctAns;
        }
        public int Incorrect()
        {
            return incorrectAns;
        }

       public void getAnswer(string guess)
        {
            int g;
            bool valid2 = Int32.TryParse(guess, out g);
            this.guess = g;
        }

        public string giveQuestion(string kind)
        {
            string question = " ";

            switch (kind)
            {
                case "Add":
                        question = addquest();
                    break;
                case "Subtract":
                        question = subquest();
                    break;
                case "Multiply":
                        question = multiquest();
                    break;
                case "Divide":
                        question = divisionquest();
                    break;
            }
            return question;
        }

        public string divisionquest()
        {
            Random rand = new Random();
            int first = rand.Next(0, 10);
            int sec;
            do
            {
                sec = rand.Next(1, 10);
            } while (first % sec != 0 ||first < sec );

            answer = first / sec;

            return "" + first + " / " + sec + " = ";

        }
        public string addquest()
        {
            Random rand = new Random();
            int first = rand.Next(0, 10);
            int sec = rand.Next(0, 10);

            this.answer = first + sec;

            return "" + first + " + " + sec + " = ";

        }
        public string subquest()
        {
            Random rand = new Random();
            int first = rand.Next(0, 10);
            int sec;
            do
            {
                sec = rand.Next(0, 10);
            } while (first <= sec);

            answer = first - sec;

            return "" + first + " - " + sec + " = ";

        }
        public string multiquest()
        {
            Random rand = new Random();
            int first = rand.Next(0, 10);
            int sec = rand.Next(0, 10);

            answer = first * sec;

            return "" + first + " * " + sec + " = ";

        }

        public bool wincheck()
        {
            if (this.guess == this.answer)
            {
                this.correctAns++;
                return true;

            }
            else
            {
                this.incorrectAns++;
                return false;
            }
        }

        public bool limitCheck()
        {
            int limit;
            limit = correctAns + incorrectAns;
            if(limit == 10)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        public int wins()
        {
            return correctAns;
        }
        public int loses()
        {
            return incorrectAns;
        }


  








    }
}
