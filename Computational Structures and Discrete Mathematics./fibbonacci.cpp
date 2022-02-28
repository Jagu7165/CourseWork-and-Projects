//Jorge Aguinaga
//Program 05
// fibbonacci sequence
#include <iostream>
using namespace std;

int fibo(int z);
bool compareSum(int s, int n);

//this program will demonstrate the fibconacci sequence
int main(){
    //user input 
    int num1; int num2;
    cout<<"This program will demonstrate the fibbonacci sequence!\n";
    cout<<"Enter your first Intiger : ";
    cin>>num1;
    //diplay users fibbonaci number
    cout<<"\nthe fibboncci number for your intiger is : ";
    cout<<fibo(num1);
    cout<<"Now ill compute the sum for your second intiger and compare it to the given formula";
    cout<<"\nEnter your second intiger: ";
    cin>>num2;

    //find the sum
    int sum=0;
    for (int i=1; i<=num2; i++){
        sum=sum+i;
    };

    cout<<"\nSum is equal to : "<<sum<<endl;
    
    //compare to given formula
    if(compareSum(sum, num2)){
        cout<<"\nthe sum matches the formula";
    }
    else{
        cout<<"\nSum does not match the formula";
    }
    

    return 0;
}
//recursize fibbonacci sequance
 int fibo(int z){
     if(z<2)
     {
         return z;
     }
     else{
         return fibo(z-1) + fibo(z-2);
     }
 }
    //compare sum to formula
bool compareSum(int s, int n){
    bool match=false;
    if (s=(((n*(n+1))/2)))
    {
        match = true;
    }
    return match;
}