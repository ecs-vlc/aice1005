#include "array.h"

Array::Array(int n) {
  data = new int[n];
  length = n;
}

Array::Array(const Array& other) {
  data = new int[other.size()];
  length = other.size();
  for(int i=0; i<size(); ++i) {
    data[i] = other[i];
  }
}

Array::~Array() {
  delete[] data;
}

int& Array::operator[](unsigned index) {
  return data[index];
}

int Array::operator[](unsigned index) const {
  return data[index];
}

unsigned Array::size() const {
  return length;
}
