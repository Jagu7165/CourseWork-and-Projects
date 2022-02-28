//jorgeAguinaga
//CS3230


public class Fraction {
	private int numerator;
	private int denominator;
	
//2 constructors 

//Convert an single intiger into its fraction form
    public Fraction(int num)
	{
		this.numerator = num;
		this.denominator = 1;
	}

//form reduced fraction from given numberator and denominator
	public Fraction(int num, int den)
	{

		this.numerator = num;
        this.denominator = den;

        reduce(num, den);

	}

//reduce the fraction to lowest terms
    private void reduce(int num, int den){
        int red = gcd(num, den);

        this.numerator /= red;
        this.denominator /= red;
    }
	
//check denominator for easy addition, and use lcd when denominator is not equal
	public Fraction add(Fraction right)
	{
        if (this.denominator == right.denominator)
           return new Fraction(this.numerator + right.numerator, denominator);
        else{
            int denominator = lcd(this.denominator, right.denominator);
		    return new Fraction(this.numerator*(denominator/this.denominator)+right.numerator*(denominator/right.denominator), denominator);
        }
	}
//check denominator for easy subtraction, and use lcd when denominator is not equal
	public Fraction sub(Fraction right)
	{
        if (this.denominator == right.denominator)
            return new Fraction(this.numerator - right.numerator, denominator);
        else{
            int lcd = lcd(this.denominator, right.denominator);
            return new Fraction((this.numerator*(lcd/this.denominator) - right.numerator*(lcd/right.denominator)), lcd);
        }
	}
	
//multiply fraction
	public Fraction mult(Fraction right)
	{
		return new Fraction(this.numerator*right.numerator, this.denominator*right.denominator);
	}
//devide with cross multiplication
	public Fraction div(Fraction right)
	{
		return new Fraction(this.numerator*right.denominator, this.denominator*right.numerator);
	}

// equals compare with object class
	public boolean equals(Object other)
	{
		if(this == other) return true;
		
		if(other==null) return false;
		
		if(getClass() != other.getClass()) return false;
		
		Fraction otherFraction = (Fraction) other;
		
		return this.numerator==otherFraction.numerator && this.denominator == otherFraction.denominator;
	}
	
//override toString to print fraction object
    public String toString()
	{
		return this.numerator + "/" + this.denominator;
	}

//auclids algorithm fro gcd
	private int gcd(int u, int v)
	{
		u = (u<0)? -u:u; //make u non-negative
		v = (v<0)? -v:v; //make v non-negative
		
		while(u>0)
		{
			if(u<v)
			{
				int t = u;
				u=v;
				v=t;
			}
			u-=v;
		}
		if(v==0)
			v=1;
		return v; //the GCD of u and v
	}

//lcd needed for add and sub methods
    private int lcd(int first, int second)
    {
        int f = first;

        while ((first % second) != 0)
            first += f;
        return first;
    }

//main testing 
    public static void main(String args[]) {

        Fraction left = new Fraction(3,24);
        Fraction right = new Fraction(-6,12);


        System.out.println( right.add(left).toString());
        System.out.println( right.sub(left).toString());
        System.out.println( right.mult(left).toString());
        System.out.println( right.div(left).toString());

    }
	
}
