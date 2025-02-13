#include "binary_tree.h"

int main() {
  binary_tree<int> tree;
  tree.insert(5);
  tree.insert(3);
  tree.insert(4);
  tree.insert(8);
  tree.insert(10);
  tree.insert(9);
  tree.insert(2);
  tree.insert(3);

  tree.show_tree();
  tree.print_tree();
  for (int element: tree) {
    cout << element << ' ';
  }
  cout << endl;
  
  for (auto pt=tree.find(5); pt!=tree.find(9); ++pt) {
    cout << *pt << ' ';
  }
  cout << endl;
}
