#include "array.h"

template<typename T>
Array::Array(int n) {
    data = new int[n];
    my_size = n;
}

template<typename T>
Array::Array(const Array& other) {
    data = new int[other.my_size];
    my_size = other.my_size;
    for(int i=0; i< my_size; ++i) {
      data[i] = other.data[i];
    }
}

template<typename T>
Array::~Array() {
  delete data;
}

template<typename T>
Array& Array::operator=(const Array& rhs) {
    data = new int[rhs.my_size];
    my_size = rhs.my_size;
    for(int i=0; i< my_size; ++i) {
      data[i] = rhs.data[i];
    }
    return *this;
}

template<typename T>
unsigned Array::size() const {
  return my_size;
}

template<typename T>
int& Array::operator[](int i) {
    return data[i];
}

template<typename T>
const int& Array::operator[](int i) const {
    return data[i];
}
