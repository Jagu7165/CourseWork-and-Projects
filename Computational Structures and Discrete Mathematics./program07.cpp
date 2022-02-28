//Jorge aguinaga
//CS2130 Program 07
#include <iostream>
#include <cmath>
using namespace std;

//this function uses euclids algorithm to test for gcd
int euclidsGCD(int a, int b)
{
    if(a>b)
    {
        swap(a,b);
    }
    while(b!=0){
        a=a%b;
        swap(a,b);
    }
    return a;
}

//this function will test to see if a number is prime
void isPrime(int n){
    int temp=0;


    for(int i=2; i<=n/2; i++){
        if(n%i==0){
            temp=1;
            break;
        }
    }
    if(temp==0){
        cout<<"\n"<<n<<" is a prime number \n";
    }
    else{
        cout<<"\n"<<n<< " is not a prime number \n";
    }
}

//solve for lcd using theorem 5 in the text

int leastCD( int x, int y){
    //using theorem 5 in the textbook

    return ((x*y)/euclidsGCD(x , y));
}

//Main Function
int main(){
    int num1;
    int num2;

    //user into and ask for user input
    cout<<"Hello Friend!";   
    cout<<"\nPlease enter your first intiger : ";
    cin>>num1;
    cout<<"\nPlease enter your second intiger : ";
    cin>>num2;
    isPrime(num1);
    isPrime(num2);
    cout<<"\nThe gcf of ("<<num1<<","<<num2<<")" <<" is : " << euclidsGCD(num1, num2);
    cout<<"\nThe lcm of ("<<num1<<","<<num2<<")" <<" is : " << leastCD(num1, num2);
    return 0;

}
