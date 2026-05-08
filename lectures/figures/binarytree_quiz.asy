import myutil;
srand(1123);

struct Node
{
  Node parent = null;
  Node left = null;
  Node right = null;
  int value = 0;
  static Node Node(Node p, int v) {Node n= new Node;
    n.parent=p;
    n.value=v;
    return n;
  }
}

from Node unravel Node;

Node operator init() {return new Node;}
  
Node newNode()
{
  return null;
}

string NodeString(Node n) {
  if (n==null)
    return "null";
  else
    return "("+string(n.value)+","+NodeString(n.left)+","+NodeString(n.right)+")";
}


real xlen=20;
real ylen=30;

picture drawNode(Node t) {
  picture subNode;
  picture nodelabel;
  label(nodelabel, string(t.value),(0,0));
  if (t.left==null && t.right==null) {
    add(subNode, bbox(nodelabel,white, FillDraw));
    add(subNode, nodelabel);
    return subNode;
  }
  if (t.left==null) {
    picture rt = drawNode(t.right);
    draw(subNode,(0,0)--(xlen,-ylen));
    add(subNode, bbox(nodelabel,white, FillDraw));
    add(subNode, nodelabel);
    add(subNode, rt, (xlen,-ylen));
    return subNode;
  }
  if (t.right==null) {
    picture lt = drawNode(t.left);
    draw(subNode,(0,0)--(-xlen,-ylen));
    add(subNode, bbox(nodelabel,white, FillDraw));
    add(subNode, nodelabel);
    add(subNode, lt, (-xlen,-ylen));
    return subNode;
  }
  picture lt = drawNode(t.left);
  picture rt = drawNode(t.right);
  real lp = -truepoint(lt, E).x -0.5*xlen;
  real rp = -truepoint(rt, W).x + 0.5*xlen;
  draw(subNode,(0,0)--(lp,-ylen));
  draw(subNode,(0,0)--(rp,-ylen));
  add(subNode, bbox(nodelabel,white, FillDraw));
  add(subNode, nodelabel);
  add(subNode, lt, (lp,-ylen));
  add(subNode, rt, (rp,-ylen));
  return subNode;
}


struct BinaryTree {
  Node root=null;
  int noElements=0;
  bool add(int value) {
    if (root==null) {
      root = Node(null, value);
      ++noElements;
      return true;
    }
    Node parent = null;
    Node currentNode = root;
    while (currentNode!=null) {
      if (value < currentNode.value) {
	parent = currentNode;
	currentNode = currentNode.left;
      } else if (value > currentNode.value) {
	parent = currentNode;
	currentNode = currentNode.right;
      } else {
	return false;
      }
    }
    if (value < parent.value) {
      parent.left = Node(parent, value);
    } else {
      parent.right = Node(parent,value);
    }
    ++noElements;
    return true;
  }

  void write() {
    write(NodeString(root));
  }

  picture draw() {return drawNode(root);}

  Node find(int value) {
    Node currentNode = root;
    while (currentNode != null) {
      if (value<currentNode.value) {
	currentNode = currentNode.left;
      } else if (value>currentNode.value) {
	currentNode = currentNode.right;
      } else
	return currentNode;
    }
    return null;
  }

  Node successor(Node node) {
    if (node.right!=null) {
      node = node.right;
      while (node.left!=null)
	node = node.left;
      return node;
    }
    Node p = node.parent;
    if (p==null) {
      return null;
    }
    while (p.right==node) {
      node = p;
      p = p.parent;
      if (p==null)
	return null;
    }
    return p;
  }
  
  void deleteNode(Node node) {
    if (node.left==null) {
      if (node.parent==null) {
	if (node.right==null) {
	  root = null;
	} else {
	  root = node.right;
	}
	return;
      }
      if (node.right!=null)
	node.right.parent = node.parent;
      if (node.parent.left!=null && node.parent.left==node)
	node.parent.left = node.right;
      else
	node.parent.right = node.right;
      return;
    }
    if (node.right==null) {
      node.left.parent = node.parent;
      if (node.parent.left!=null && node.parent.left==node)
	node.parent.left = node.left;
      else
	node.parent.right = node.left;
      return;
    }
    write(3);
    Node s = successor(node);
    write(s.value);
    node.value = s.value;
    deleteNode(s);
    return;
  }

  bool delete(int value) {
    Node node = find(value);
    if (node==null)
      return false;
    deleteNode(node);
    --noElements;
    return true;
  }

  Node leastNode() {
    if (root==null)
      return null;
    Node node = root;
    while (node.left!=null) {
      node = node.left;
    }
    return node;
  }

}

BinaryTree init() {return new BinaryTree;}




void add(BinaryTree bt, int n) {
  string items;
  for(int i=0; i<n; ++i) {
    int r = floor(100*(rand()/randMax));
    if (i>0)
      items += ", ";
    items += string(r);
    bt.add(r);
  }
  write(items);
}


BinaryTree bt;
add(bt, 20);

add(bt.draw());

ship();
erase();
bt.add(80);
add(bt.draw());
ship();

