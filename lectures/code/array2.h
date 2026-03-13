#ifndef ARRAY_H
#define ARRAY_H

template <typename T>
class Array {
private:
  T *data;
  unsigned length;
public:
  Array(int n);
  Array(const Array& other);
  ~Array();
  T& operator[](unsigned index);
  T operator[](unsigned index) const;
  unsigned size() const;
};

template <typename T>
Array<T>::Array(int n) {
  data = new T[n];
  length = n;
}

template <typename T>
Array<T>::Array(const Array& other) {
  data = new T[other.size()];
  length = other.size();
  for(int i=0; i<size(); ++i) {
    data[i] = other[i];
  }
}

template <typename T>
Array<T>::~Array() {
  delete[] data;
}

template <typename T>
T& Array<T>::operator[](unsigned index) {
  return data[index];
}

template <typename T>
T Array<T>::operator[](unsigned index) const {
  return data[index];
}

template <typename T>
unsigned Array<T>::size() const {
  return length;
}

#endif
