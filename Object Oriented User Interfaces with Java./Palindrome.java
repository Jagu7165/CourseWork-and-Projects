import java.util.Scanner;

public class Palindrome {

    //This program will test to see if user inputs a palendrome in either the
    //command line or as input 
    public static void main(String[] args)
    {

        //case 1 : command line args is greater than zero, treat args as a single string
        if (args.length > 0)
		{			
            String test = "";

                for (int i = 0; i < args.length; i++){
                    test += args[i];
                }
                System.out.println(palindromeTester(test));

			System.exit(1);
		}
        //case 2: prompt the user to enter a string
        else
        {
            System.out.print("Hello! Enter a String for me to test: ");
            Scanner input = new Scanner(System.in);
            String test = input.nextLine();
            if (test != null && test != "")
            {
                System.out.println(palindromeTester(test));
            }
            else{
                while(test == "" || test == null)
                {
                System.out.println("Lets try that again : ");
                test = input.nextLine();
                }
                System.out.println(palindromeTester(test));
            }

        }
		

    }

    private static String palindromeTester(String test){

        //filter the string of any spaces  
        String testing = test.replace(" ", ""); 

        //create a reverse string to compare too
        String rev = "";
        for(int i = testing.length()-1; i>=0; i--){
            rev += testing.charAt(i);
        }
        
        //compare character by character
        Boolean flag = true;
        for(int i = 0; i< testing.length(); i++){
            if(testing.charAt(i) != rev.charAt(i))
            {
                flag = false;
            }
        }

        //return string result 
        if (flag == true){
            return "Yes, that be a Palindrome";
        }
        else{
            return "No sir, that is no Palindrome";
        }
    }

}
