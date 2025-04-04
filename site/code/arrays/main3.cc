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
  Array<string> a(5);

  a[0] = "hello";
  a[1] = "world.";
  a[2] = "How";
  a[3] = "are";
  a[4] = "you?";
  a.push_back("Nice");
  a.push_back("so");
  a.push_back("see");
  a.push_back("you.");

  Array<string> b = a;
  b[2] = "Who";
  print(a, "a: ");
  print(b, "b: ");

  Array<int> c;
  c.push_back(1);
  c.push_back(3);
  c.push_back(5);
  print(c, "c: ");

  for (auto pt = a.begin(); pt!=a.end(); ++pt) {
    cout << *pt << " ";
  }
  cout << endl;

  for(string entry: b) {
    cout << entry << " ";
  }

}
