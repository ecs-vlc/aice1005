#include <map>
#include <iostream>
using namespace std;

/* Abstract base class for Huffman tree */
class HuffmanTree {
protected:
  unsigned occurrence_frequency;
public:
  int occurrence()  const {return occurrence_frequency;}
  virtual void extractCodes(std::map<char, std::string>& codes, std::string codeString) const = 0;
  virtual bool is_leaf() const = 0;
  virtual char symbol() const = 0;
  virtual HuffmanTree* decode(char ch) = 0;
};


/* class used to sort Huffman subtrees */
class CompareHuffman {
public:
  bool operator()(HuffmanTree* ht1, HuffmanTree* ht2) {
    return ht1->occurrence() > ht2->occurrence();
  }
};

/* Leaf node for Huffman tree */
class HuffmanTreeLeaf: public HuffmanTree {
private:
  char character;

public:
  HuffmanTreeLeaf(char ch, int occ) {
    occurrence_frequency = occ;
    character = ch;
  }

  void extractCodes(map<char, string>& codeMap, string codeString) const {
    codeMap[character] = codeString;
  }
  
  char symbol() const {return character;}

  bool is_leaf() const {return true;}

  HuffmanTree* decode(char ch) {
    std::cerr << "Should not reach here!\n";
    return 0;
  }

};

/* Non-leaf node */
class HuffmanTreeNode: public HuffmanTree {
private:
  HuffmanTree* left_child;
  HuffmanTree* right_child;
public:
  HuffmanTreeNode(HuffmanTree* left, HuffmanTree* right) {
    occurrence_frequency = left->occurrence() + right->occurrence();
    left_child = left;
    right_child = right;
  }
  bool is_leaf() const {return false;}
  char symbol() const {return 0;}
  
  HuffmanTree* decode(char ch) {
    if (ch=='0')
      return left_child;
    else
      return right_child;
  }

  void extractCodes(map<char, string>& codeMap, string codeString) const {
    left_child->extractCodes(codeMap, codeString+"0");
    right_child->extractCodes(codeMap, codeString+"1");
  }
  
};

