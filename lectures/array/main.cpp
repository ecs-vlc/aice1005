#include <iostream>
#include "array.h"
#include <unistd.h>
using namespace std;

template<typename T>
void print(const Array<T>& a, string name) {
  cout << name << ": " << a[0];
  for(int i=1; i<a.size(); ++i) {
    cout << ", "<< a[i];
  }
  cout << endl;
}

int oldmain(int, char**) {

  Array<string> a(3);

  a[0] = "Hello";
  a[1] = "World";
  a[2] = "!";

  print(a, "a");

  Array<string> b = a;

  print(b, "b");

  a[0] = "Good bye";
  cout << "-----------------\n";
  print(a, "a");
  print(b, "b");

  return 0;
}

int main() {

  ofstream file;
  file.open("some_numbers.txt");
  Array<int> a(10)
    while (!file.eof()) {
      a.push_back(file.get());
    }

  cout << a.size() << ", " << a[0] << endl;
    
}
