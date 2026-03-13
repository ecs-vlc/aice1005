#ifndef ARRAY_H
#define ARRAY_H

class Array {
private:
  int *data;
  int length;
public:
  Array(int n);
  Array(Array& other);
  int& operator[](int index);
  int size();
};

#endif
