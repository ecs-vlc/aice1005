#include "stack.h"
#include <iostream>
using namespace std;


int main() {
  MyStack<int> stack;
  stack.push(3);
  stack.push(2);
  stack.push(1);
  while(!stack.empty()) {
    cout << stack.pop() << endl;
  }
}
