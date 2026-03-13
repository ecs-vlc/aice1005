#include <iostream>
#include "mylist.h"
using namespace std;


int main() {
  MyList<int> list;

  for(int i=0; i<10; ++i) {
    list.push(i*i);
  }

  for(auto pt=list.begin(); pt!=list.end(); ++pt) {
    cout << *pt << ' ';
  }
  cout << endl;

  for(int elem: list) {
    cout << elem << ' ';
  }
  cout << endl;

  while (!list.empty()) {
    cout << list.top() << ' ';
    list.pop();
  }
  cout << endl;


}
