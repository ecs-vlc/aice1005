#include <iostream>
#include "array.h"
#include <unistd.h>

using namespace std;

void print(Array& a, string name) {
  cout << name;
  for(int i=0; i<a.size(); i++) {
    cout << " " << a[i];
  }
  cout << endl;
}

int main() {

  for(int i=0; i<500000; i++) {
    Array a(10000000);
    if (i%10000==0) {
      cout << i << endl;
      sleep(1);
    }
  }


  return 0;
}
