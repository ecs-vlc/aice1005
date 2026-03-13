#ifndef STACK_H
#define STACK_H

#include <vector>

template <typename T>
class MyStack
{
private:
  std::vector<T> stack;

public:
  void push(const T& obj) {stack.push_back(obj);}

  T top() const {return stack.back();}

  T pop() {
    T tmp = stack.back();
    stack.pop_back();
    return tmp;
  }

  T empty() {return stack.size()==0;}
};

#endif
