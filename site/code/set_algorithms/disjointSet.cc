#include <iostream>
using namespace std;

class DisjointSets {
public:
  DisjointSets(unsigned numElements): num_elements(numElements) {
    s = new int[numElements];
    for(int i=0; i<numElements; i++)
      s[i] = -1;                   // roots are negative number
  }

  void union_(int root1, int root2) {
    if (s[root2]<s[root1]) {         // root2 is deeper
      s[root1] = root2;              // make root2 the root$\pause$
    } else {
      if (s[root1]==s[root2])      
	s[root1]--;                // update height if same
      s[root2] = root1;            // make root1 new root
    }
  }

  int find(int index) {
    if (s[index]<0)
      return index;
    else
      return s[index] = find(s[index]);
  }

  unsigned size() const {return num_elements;}

private:
  unsigned num_elements;
  int* s;

};

int main() {
  DisjointSets ds(10);

  ds.union_(ds.find(5), ds.find(6));
  ds.union_(ds.find(1), ds.find(8));
  ds.union_(ds.find(2), ds.find(6));
  ds.union_(ds.find(8), ds.find(6));
  ds.union_(ds.find(9), ds.find(0));

  for(int i=0; i<ds.size(); ++i) {
    cout << i << " " << ds.find(i) << endl;
  }
}
