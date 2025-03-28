#include <vector>
#include <math.h>
#include <iostream>
#include <fstream>
#include <chrono>
#include "sos.h"
using namespace std::chrono;
using namespace std;

/* A heap that only stores priorities */
template <typename T>
class heap {
private:
  vector<T > array;

public:
  
  heap(unsigned initialSize=11) {
    array.reserve(initialSize);
  }

  inline
  unsigned size() {return array.size();}

  inline
  bool empty() {return array.empty();}

  void push(T value) {
    array.push_back(value);
    unsigned pos = size() - 1;
    while(pos!=0) {
      unsigned parent = (pos-1)>>1;
      if (array[parent] < array[pos])
	return;
      array[pos] = array[parent];
      array[parent] = value;
      pos = parent;
    }
  }

  inline
  const T& top() {return array[0];}

  void pop() {
    unsigned pos = 0;
    T tmp = array.back();
    array[0] = tmp;
    array.pop_back();
    while(true) {
      unsigned child = 2*pos + 1;
      if (child>=size()) {
	return;
      }
      if (child+1<=size() && array[child+1] < array[child])
	++child;
      if (array[child] > array[pos])
	return;
      array[pos] = array[child];
      array[child] = tmp;
      pos = child;
    }
  }
};

int main() {
  heap<int> myheap;

  for (int i=0; i<10; ++i)
    myheap.push(rand()>>20);

  while(!myheap.empty()) {
    cout << myheap.top() << ' ';
    myheap.pop();
  }

  ofstream out("heapSortTiming.dat");
  for(int n=10; n<1400000; n*=2) {
    Sos timeTaken;
    for(int run=0; run<1000; ++run) {
      heap<int> myheap(n);
      for(int i=0; i<n; ++i) {
	myheap.push(rand());
      }
      vector<int> sorted(n);
      auto start = high_resolution_clock::now();
      while(!myheap.empty()) {
	sorted.push_back(myheap.top());
	myheap.pop();
      }
      auto stop = high_resolution_clock::now();
      auto duration = duration_cast<microseconds>(stop - start);
      timeTaken += double(duration.count())/n;
    }
    cout << n << " " << timeTaken << endl;
    out << n << " " << timeTaken << endl;
  }
  out.close();
}
