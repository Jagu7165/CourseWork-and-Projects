using System;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)

        {
            string sfirst;
            string ssecond;
            int ifirst;
            int isecond;
            int result;
            Console.WriteLine("Hello User!");

            Console.WriteLine("\nEnter your first number");
            sfirst = Console.ReadLine();

            bool isValid = Int32.TryParse(sfirst, out ifirst);
            if (isValid == false)
            {
                Console.WriteLine("\nNo, please enter a valid intiger");
                sfirst = Console.ReadLine();
            }

            Console.WriteLine("\nEnter your second number");
            ssecond = Console.ReadLine();

            bool isValids = Int32.TryParse(ssecond, out isecond);
            if (isValids == false)
            {
                Console.WriteLine("\nNo, please enter a valid intiger");
                ssecond = Console.ReadLine();
            }

            result = ifirst + isecond;
            Console.WriteLine("\n{0} + {1} = {2}", ifirst, isecond, result);
            result = ifirst - isecond;
            Console.WriteLine("\n{0} - {1} = {2}", ifirst, isecond, result);
            result = ifirst * isecond;
            Console.WriteLine("\n{0} * {1} = {2}", ifirst, isecond, result);
            result = ifirst / isecond;
            Console.WriteLine("\n{0} / {1} = {2}", ifirst, isecond, result);
            result = ifirst % isecond;
            Console.WriteLine("\n{0} % {1} = {2}", ifirst, isecond, result);

            if(ifirst > isecond)
            {
                Console.WriteLine("\n{0} is greater than {1}", ifirst, isecond);
            }
            else
            {
                Console.WriteLine("\n{0} is not greater than {1}", ifirst, isecond);
            }
            if (ifirst < isecond)
            {
                Console.WriteLine("\n{0} is less than {1}", ifirst, isecond);
            }
            else
            {
                Console.WriteLine("\n{0} is not less than {1}", ifirst, isecond);
            }

            if (ifirst == isecond)
            {
                Console.WriteLine("\n{0} is equal to {1}", ifirst, isecond);
            }
            else
            {
                Console.WriteLine("\n{0} is not equal to {1}", ifirst, isecond);
            }


        }

        
    }
}
