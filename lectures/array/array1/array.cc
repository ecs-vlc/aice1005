#include "array.h"

Array::Array(int n) {
  data = new int[n];
  length = n;
}

Array::Array(Array& other) {
  data = new int[other.size()];
  length = other.size();
  for(int i=0; i<size(); ++i) {
    data[i] = other[i];
  }
}

int& Array::operator[](int index) {
  return data[index];
}

int Array::size() {
  return length;
}
