#include <iostream>
#include <random>
using namespace std;

class FastSet {
private:  
  int* indexArray;
  int* memberArray;
  unsigned noMembers;

public:
  FastSet(int n) {
    indexArray = new int[n];
    memberArray = new int[n];
    for(int i=0; i<n; i++) {
      indexArray [i] = -1;
    }
    noMembers = 0;
  }

  unsigned size() {
    return noMembers;
  }

  bool add(int i) {
    if (indexArray[i]>-1)
      return false;
    memberArray[noMembers] = i;
    indexArray[i] = noMembers;
    ++noMembers;
    return true;
  }

  bool remove(int i) {
    if (indexArray[i]==-1)
      return false;
    --noMembers;
    memberArray[indexArray[i]] = memberArray[noMembers];
    indexArray[memberArray[noMembers]] = indexArray[i];
    indexArray[i] = -1;
    return true;
  }

  void clear() {
    for(int i=0; i<noMembers; i++) {
      indexArray[memberArray[i]] = -1;
    }
    noMembers = 0;
  }

  bool isEmpty() {
    return noMembers==0;
  }

  int operator[](int i) {
    if (i<0 || i>=noMembers)
      throw "out of bounds";
    return memberArray[i];
  }

  int* begin() {return &memberArray[0];}
  int* end() {return &memberArray[noMembers];}
};

  
int main() {
  FastSet fastSet(100);
  random_device rd;  // Seed for the random number engine
  mt19937 gen(rd()); // Mersenne Twister RNG
  uniform_int_distribution<int> dist(0, 99);

  unsigned cnt = 0;
  for(int i=0; i<40; ++i) {
    int r = dist(gen);
    bool success = fastSet.add(r);
    if (success)
      ++cnt;
    cout << "add " << r << " succeeded " << success << endl;
  }
  for(int i=0; i<10; ++i) {
    int r = dist(gen);
    bool success = fastSet.add(r);
    if (success)
      ++cnt;
    cout << "remove " << r << " succeeded " << success << endl;
  }

  for(int i: fastSet) {
    cout << i << " ";
  }
  cout << endl;
  cout << "number of elements = " << cnt << " = " << fastSet.size();
  
}
