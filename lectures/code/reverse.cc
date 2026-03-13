#include <stack>
#include <iostream>
#include <fstream>
#include <iterator>
#include <algorithm>
using namespace std;

int main(int argc, char *argv[]) {
  ifstream in(argv[1]);

  stack<string> stack;

  string word;
  while (in >> word)
    stack.push(word);

  while(!stack.empty()) {
      cout << stack.top() << ' ';
      stack.pop();
  }
}
