//jorge aguinaga
//permutations and combinations
#include <iostream>
#include <cmath>
using namespace std;

//function declarations
long long int permu(int n, int r);
long long int combo(int n, int r);
//main function
int main(){
//no input in this proram
//first problem: doctors and nurses
   cout<<"check the correctness of my functions below :\n"<<endl;
   cout<<"permutations   P(35, 12) =  "<<permu(35, 12)<<endl;
   cout<<"combinations   C(23, 11) =  "<<combo(23,11)<<endl;
   cout<<"\nways of selecting doctors for the first batch: "<<combo(12, 4)<<endl;
   cout<<"ways of selecting nurses for the first batch: "<<combo(36, 12)<<endl;
   cout<<"ways to administer first dose "<<(combo(36, 12)*combo(12,4))<<endl;

  cout<<"\nways of selecting doctors for the next batch: "<<combo(8, 4)<<endl; //4 less doctors 
  cout<<"ways of selecting nurses for the next batch: "<<combo(24, 12)<<endl; //12 less nurses
  cout<<"ways to administer second dose "<<(combo(24, 12)*combo(8,4))<<endl;

  cout<<"\ntotal ways to administer doses "<<((combo(36, 12)*combo(12,4))*(combo(24, 12)*combo(8,4)))<<endl; //product rule

//second problem: employee bonuses
  cout<<"\nthe number of ways to distribute 4 bonuses to 23 people is: "<<permu(23,4)<<endl;
  cout<<"if the bonuses are the same then its "<<combo(23, 4)<<endl;

    return 0;
}

//this function calculates permutations
long long int permu(int n, int r)
{
    long long int perm = n;
    for(int i=1; i<=r-1; i++){
        perm=perm*(n-i);
    }
    return perm;
}
//this function calculates combinations
long long int combo(int n, int r){
    long long int dev=1;
    for(int i=1; i<=r; i++)
    {
        dev=dev*i;
    }
    long long int combo =permu(n, r)/dev;
    return combo;
}