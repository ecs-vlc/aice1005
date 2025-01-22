#include "heapPQ.h"

#include <iostream>
using namespace std;

int main() {
  heapPQ<string, int> pq;

  pq.push("hello", 0);
  pq.push("world", 4);
  pq.push("how", 10);
  pq.push("are", 11);
  pq.push("you", 12);
  pq.push("today", 3);
  pq.push("I'm", 1);
  pq.push("fine", 2);

  while(!pq.empty()) {
    cout << pq.top() << " ";
    pq.pop();
  }
}
