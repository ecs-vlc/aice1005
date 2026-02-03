#include <iostream>
#include <string>
#include <unistd.h>
#include "array.h"
using namespace std;

void print(const Array& a, string name) {
  cout << name;
  for (int i=0; i<a.size(); ++i) {
    cout << ' ' << a[i];
  }
  cout << endl;
}

int main() {
  Array a(11);

  for (int i=0; i<a.size(); ++i) {
    a[i] = i*i;
  }

  print(a, "a: ");

  Array b(a);

  print(b, "b: ");
  b[0] = 1000;
  
  print(a, "a: ");
  print(b, "b: ");

}
