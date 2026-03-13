#include <memory>

template<typename T>
class Array {
public:
  Array(unsigned n);
  Array(const Array<T>& other);
  ~Array();
  Array& operator=(const Array&);
  T& operator[](unsigned i);
  const T& operator[](unsigned i) const;
  unsigned size() const;
private:
  T* data;
  unsigned my_size;
};


template<typename T>
Array<T>::Array(unsigned n) {
    data = new T[n];
    my_size = n;
}

template<typename T>
Array<T>::Array(const Array<T>& other) {
    data = new T[other.my_size];
    my_size = other.my_size;
    for(unsigned i=0; i< my_size; ++i) {
      data[i] = other.data[i];
    }
}

template<typename T>
Array<T>::~Array() {
  delete data;
}

template<typename T>
Array<T>& Array<T>::operator=(const Array<T>& rhs) {
    data = new unsigned[rhs.my_size];
    my_size = rhs.my_size;
    for(unsigned i=0; i< my_size; ++i) {
      data[i] = rhs.data[i];
    }
    return *this;
}

template<typename T>
unsigned Array<T>::size() const {
  return my_size;
}

template<typename T>
T& Array<T>::operator[](unsigned i) {
    return data[i];
}

template<typename T>
const T& Array<T>::operator[](unsigned i) const {
    return data[i];
}
