#ifndef ARRAY_H
#define ARRAY_H

class Array {
private:
  int *data;
  unsigned length;
public:
  Array(int n);
  Array(const Array& other);
  ~Array();
  int& operator[](unsigned index);
  int operator[](unsigned index) const;
  unsigned size() const;
};


#endif
