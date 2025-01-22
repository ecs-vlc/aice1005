#ifndef HEAPPQ_H
#define HEAPPQ_H

#include <vector>
using namespace std;

template <typename T, typename P>
class heapPQ {
private:
  vector<pair<T, P> > array;

public:
  
  heapPQ(unsigned initialSize=11) {
    array.reserve(initialSize);
  }

  inline
  unsigned size() {return array.size();}

  inline
  bool empty() {return array.empty();}

  void push(T value, P priority) {
    pair<T,P> tmp(value, priority);
    array.push_back(tmp);
    unsigned child = size() - 1;
    while(child!=0) {
      unsigned parent = (child-1)>>1;
      if (array[parent].second < array[child].second)
	return;
      array[child] = array[parent];
      array[parent] = tmp;
      child = parent;
    }
  }

  inline
  const T& top() {return array[0].first;}

  void pop() {
    unsigned parent = 0;
    pair<T, P> tmp = array.back();
    array[0] = tmp;
    array.pop_back();
    unsigned child = 2*parent + 1;

    /* Percolate down */
    while(child<size()) {
      if (child+1<=size() && array[child+1].second < array[child].second)
	++child;
      if (array[child].second > array[parent].second)
	return;
      array[parent] = array[child];
      array[child] = tmp;
      parent = child;
      child = 2*parent + 1;
    }
  }
};

#endif
