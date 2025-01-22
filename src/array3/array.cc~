#include "array.h"

Array<T>::Array(int n) {
  data = new T[n];
  length = n;
}

Array::Array(const Array& other) {
  data = new T[other.size()];
  length = other.size();
  for(int i=0; i<size(); ++i) {
    data[i] = other[i];
  }
}

Array::~Array() {
  delete[] data;
}

T& Array::operator[](unsigned index) {
  return data[index];
}

T Array::operator[](unsigned index) const {
  return data[index];
}

unsigned Array::size() const {
  return length;
}
