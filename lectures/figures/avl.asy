int piccnt=0;
void out() {
  draw(box((-170,-160),(170,10)),white);
  string fn = "avl-"+string(piccnt);
  shipout(fn);
  piccnt+=1;
  erase();
}

struct treenode
{
  treenode left = null;
  treenode right = null;
  treenode parent = null;
  int key = 0;
  int balanceFactor = 0;

  static treenode treenode(int key, treenode parent) {
    treenode tn = new treenode;
    tn.key = key;
    tn.parent = parent;
    return tn;
  }
}



treenode operator init() {return new treenode;}

struct tree
{
  treenode root = null;
  int cnt = 0;

  static real xlen=15;
  static real ylen=30;

  picture drawsubtree(treenode current) {
    picture subtree;
    picture nodelabel;
    filldraw(nodelabel, circle((0,0),8), white);
    label(nodelabel, string(current.key),(0,0));
    label(nodelabel, "$"+string(current.balanceFactor)+"$",
	  (8,0),E,red+fontsize(8));
    if (current.left==null && current.right==null) {
      add(subtree, nodelabel);
      return subtree;
    }
    if (current.left==null) {
      picture rt = drawsubtree(current.right);
      draw(subtree,(0,0)--(xlen,-ylen));
      add(subtree, nodelabel);
      add(subtree, rt, (xlen,-ylen));
      return subtree;
    }
    if (current.right==null) {
      picture lt = drawsubtree(current.left);
      draw(subtree,(0,0)--(-xlen,-ylen));
      add(subtree, nodelabel);
      add(subtree, lt, (-xlen,-ylen));
      return subtree;
    }
    picture lt = drawsubtree(current.left);
    picture rt = drawsubtree(current.right);
    real lp = -truepoint(lt, E).x -0.5*xlen;
    real rp = -truepoint(rt, W).x + 0.5*xlen;
    draw(subtree,(0,0)--(lp,-ylen));
    draw(subtree,(0,0)--(rp,-ylen));
    add(subtree, nodelabel);
    add(subtree, lt, (lp,-ylen));
    add(subtree, rt, (rp,-ylen));
    return subtree;
  }

  picture draw() {
    picture subtree;
    if (root==null)
      return subtree;
    return drawsubtree(root);
  }

  void rotateLeft(treenode p) {
    treenode r = p.right;
    p.right = r.left;
    if (r.left != null)
      r.left.parent = p;
    r.parent = p.parent;
    if (p.parent == null)
      root = r;
    else if (p.parent.left==p)
      p.parent.left = r;
    else
      p.parent.right = r;
    r.left = p;
    p.parent = r;
    if (p.balanceFactor==-2) {
      r.balanceFactor = 0;
    } else {
      r.balanceFactor = 1;
    }
    p.balanceFactor = 0;
  }

  void rotateRight(treenode p) {
    treenode r = p.left;
    p.left = r.right;
    if (r.right != null)
      r.right.parent = p;
    r.parent = p.parent;
    if (p.parent == null)
      root = r;
    else if (p.parent.right==p)
      p.parent.right = r;
    else
      p.parent.left = r;
    r.right = p;
    p.parent = r;
    if (p.balanceFactor==2) {
      r.balanceFactor = 0;
    } else {
      r.balanceFactor = -1;
    }
    p.balanceFactor = 0;
  }

  void rotateLeftRight(treenode p) {
    rotateLeft(p.left);
    rotateRight(p);
  }
      
  void rotateRightLeft(treenode p) {
    rotateRight(p.right);
    rotateLeft(p);
  }

  treenode  updateBalanceFactor(treenode current, int bf) {
    current.balanceFactor += bf;
    if (abs(current.balanceFactor)>1)
      return current;
    if (current.balanceFactor==0)
      return null;
    if (current.parent==null)
      return null;
    if (current.parent.left==current)
      return updateBalanceFactor(current.parent, +1);
    else
      return updateBalanceFactor(current.parent, -1);
  }


  void correct(treenode t, int key) {
    if (t==null)
      return;
    add(draw());
    if (t.balanceFactor==2) {
      if (key<t.left.key) {
	label("\texttt{RotateRight}",(-140,0),E,red);
	out();
	rotateRight(t);
      } else {
	label("\texttt{RotateLeftRight}",(-140,0),E,red);
	out();
	rotateLeftRight(t);
      }
    } else {
      if (key>t.right.key) {
	label("\texttt{RotateLeft}",(-140,0),E,red);
	out();
	rotateLeft(t);
      } else {
	label("\texttt{RotateRightLeft}",(-140,0),E,red);
	out();
	rotateRightLeft(t);
      }
    }
  }

  bool add(int key) {
    if (root == null) {
      root = treenode.treenode(key, null);
      return true;
    }
    treenode current = root;
    do {
      if (current.key == key) {
	false;
      }
      if (key < current.key) {
	if (current.left == null) {
	  current.left = treenode.treenode(key,current);
	  cnt += 1;
	  treenode t = updateBalanceFactor(current, +1);
	  correct(t,key);
	  return true;
	} else {
	  current = current.left;
	}
      } else {
	if (current.right == null) {
	  current.right = treenode.treenode(key,current);
	  cnt += 1;
	  treenode t = updateBalanceFactor(current, -1);
	  correct(t,key);
	  return true;
	} else {
	  current = current.right;
	}
      }
    } while (true);
    return false;
  }



  bool contains(int key) {
    treenode current = root;
    while (current != null) {
      if (current.key == key)
	return true;
      if (key < current.key)
	current = current.left;
      else
	current = current.right;
    }
    return false;
  }

  treenode getNode(int key) {
    treenode current = root;
    while (current != null) {
      if (current.key == key)
	return current;
      if (key < current.key)
	current = current.left;
      else
	current = current.right;
    }
    return null;
  }

}

tree operator init() {return new tree;}

srand(131);

tree bt;
for (int i=0; i<16; i+=1) {
  int r = floor(100.0*rand()/randMax);
  while (bt.contains(r))
    r = floor(100.0*rand()/randMax);
  label("\texttt{add("+string(r)+")}",(-140,0),E,red);
  if (i>0)
    add(bt.draw());
  out();
  bt.add(r);
  add(bt.draw());
  out();
}


