#include <iostream>
#include <string>
#include <unistd.h>
#include "array.h"
using namespace std;

template <typename T>
void print(const Array<T>& a, string name) {
  cout << name;
  for (int i=0; i<a.size(); ++i) {
    cout << ' ' << a[i];
  }
  cout << endl;
}

int main() {
  Array<string> a(2);

  a[0] = "hello";
  a[1] = "world";

  print(a, "a: ");

}
