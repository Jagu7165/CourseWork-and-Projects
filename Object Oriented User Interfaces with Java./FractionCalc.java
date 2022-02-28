//Jorge Aguinaga
//CS3230

import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class FractionCalc {
//pattern for valid input
	static String regex ="(-?[0-9]+)([ \t]*/[ \t]*)(-?[0-9]+)([ \t]*)([+-/\\*])([ \t]*)(-?[0-9]+)([ \t]*/[ \t]*)(-?[0-9]+)";
	
	public static void main(String[] args) {
        //left side
		int lnum = 0;
		int lden = 0;

        //right side
		int rnum = 0;
		int rden = 0;

        //oporation
        String mathcase = "";
		
		System.out.println("Please provide a fraction string : ");
		

		Scanner scanner = new Scanner(System.in);
		String input = scanner.nextLine();
		scanner.close();

		input = input.trim();
		
//use regex to determin the pattern
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(input);


//find the intiger values and exit for invalid input
		if(m.find()) {
			lnum = Integer.parseInt(m.group(1));
			lden = Integer.parseInt(m.group(3));
			mathcase = m.group(5);
			rnum = Integer.parseInt(m.group(7));
			rden = Integer.parseInt(m.group(9));
		} else {
			System.out.println("String is not a valid Fraction Expression.");
			System.exit(0);
		}
		
		//create Fraction objects with found intigers
		Fraction first = new Fraction(lnum, lden);
		Fraction second = new Fraction(rnum, rden);

		Fraction result = new Fraction(2,2);

        //use mathcase to determine the expression
        if(mathcase.equals("+")){
            result = first.add(second);
        }
        else if (mathcase.equals("-")){
            result = first.sub(second);
        }
        else if (mathcase.equals("*")){
            result = first.mult(second);
        }
        else if (mathcase.equals("/")){
            result = first.div(second);
        }

		
		//return result
		System.out.println(result);
	}
}
