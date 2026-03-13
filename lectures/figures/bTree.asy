size(500,0);

import myutil;

int M = 4;
int L = 5;

struct Node {
  int[] key;
  int size;
  pair pos;
  static Node Node(pair p ... int[] keys) {
    Node n = new Node;
    n.pos = p;
    n.size = keys.length;
    n.key = new int[M];
    for (int i=0; i< n.size; ++i) {
      n.key[i] = keys[i];
    }
    return n;
  }
  void draw() {
    for(int i=0; i<M; ++i) {
      draw(pos+(1.2*i,0)--pos+(1.2*i,1));
      draw(pos+(1.2*i+0.2,0)--pos+(1.2*i+0.2,1));
      draw(pos+(1.2*i+1.2,0)--pos+(1.2*i+1.2,1));
      if (i<size) {
	label(string(key[i]), pos+(1.2*i+0.7, 0.5));
      }
    }
    draw(pos--pos+(1.2*M+0.2,0));
    draw(pos+(0,1)--pos+(1.2*M+0.2,1));
    draw(pos+(1.2*M+0.2,0)--pos+(1.2*M+0.2,1));
  }
  pair keypos(int i) {
    return pos + (1.2*i+0.1,0.5);
  }
  pair mid() {
    return pos + (0.6*M+0.1, 1);
  }
};

from Node unravel Node;

struct Leaf {
  int[] key;
  int size;
  pair pos;
  static Leaf Leaf(pair p ... int[] keys) {
    Leaf l = new Leaf;
    l.pos = p;
    l.size = keys.length;
    l.key = new int[M];
    for (int i=0; i< l.size; ++i) {
      l.key[i] = keys[i];
    }
    return l;
  }
  void draw() {
    draw(box(pos+(-0.5,0), pos+(0.5,-0.6*L)));
    for(int i=0; i<size; ++i) {
      label(string(key[i]), pos+(0,-0.3-0.6i));
    }
  }
};

from Leaf unravel Leaf;

picture edgePic = new picture;


real nsize = 1.5*M;

Node root = Node((0,0), 41, 66, 87);
Node n0 = Node((-1.5*nsize,-2), 8, 18, 26, 35);
Node n1 = Node((-0.5*nsize,-2), 48, 51, 54);
Node n2 = Node((0.5*nsize,-2), 72, 78, 83);
Node n3 = Node((1.5*nsize,-2), 92, 97);


root.draw();
n0.draw();
n1.draw();
n2.draw();
n3.draw();

draw(edgePic, root.keypos(0)--root.keypos(0)-(0,0.7)--n0.mid()+(0,0.8)--n0.mid(), Arrow);
draw(edgePic,root.keypos(1)--root.keypos(1)-(0,0.9)--n1.mid()+(0,0.6)--n1.mid(), Arrow);
draw(edgePic,root.keypos(2)--root.keypos(2)-(0,0.9)--n2.mid()+(0,0.6)--n2.mid(), Arrow);
draw(edgePic,root.keypos(3)--root.keypos(3)-(0,0.7)--n3.mid()+(0,0.8)--n3.mid(), Arrow);

Leaf l00 = Leaf(n0.keypos(0)+(0,-1.5), 2, 4, 6);
draw(edgePic, n0.keypos(0)--l00.pos, Arrow);
l00.draw();

Leaf l01 = Leaf(n0.keypos(1)+(0,-1.5), 8, 10, 12,14, 16);
draw(edgePic,n0.keypos(1)--l01.pos, Arrow);
l01.draw();

Leaf l02 = Leaf(n0.keypos(2)+(0,-1.5), 18, 20, 22, 24);
draw(edgePic,n0.keypos(2)--l02.pos, Arrow);
l02.draw();

Leaf l03 = Leaf(n0.keypos(3)+(0,-1.5), 26, 28, 30, 31, 32);
draw(edgePic,n0.keypos(3)--l03.pos, Arrow);
l03.draw();

Leaf l04 = Leaf(n0.keypos(4)+(0,-1.5), 35, 36, 37, 38, 39);
draw(edgePic,n0.keypos(4)--l04.pos, Arrow);
l04.draw();

Leaf l10 = Leaf(n1.keypos(0)+(0,-1.5), 41, 42, 44, 46);
draw(edgePic,n1.keypos(0)--l10.pos, Arrow);
l10.draw();

Leaf l11 = Leaf(n1.keypos(1)+(0,-1.5), 48, 49, 50);
draw(edgePic,n1.keypos(1)--l11.pos, Arrow);
l11.draw();

Leaf l12 = Leaf(n1.keypos(2)+(0,-1.5), 51, 52, 53);
draw(edgePic,n1.keypos(2)--l12.pos, Arrow);
l12.draw();

Leaf l13 = Leaf(n1.keypos(3)+(0,-1.5), 54, 56, 58, 59);
draw(edgePic,n1.keypos(3)--l13.pos, Arrow);
l13.draw();


Leaf l20 = Leaf(n2.keypos(0)+(0,-1.5), 66, 68, 69, 70);
draw(edgePic,n2.keypos(0)--l20.pos, Arrow);
l20.draw();

Leaf l21 = Leaf(n2.keypos(1)+(0,-1.5), 72, 73, 74, 76);
draw(edgePic,n2.keypos(1)--l21.pos, Arrow);
l21.draw();

Leaf l22 = Leaf(n2.keypos(2)+(0,-1.5), 78, 79, 81);
draw(edgePic,n2.keypos(2)--l22.pos, Arrow);
l22.draw();

Leaf l23 = Leaf(n2.keypos(3)+(0,-1.5), 83, 84, 85);
draw(edgePic,n2.keypos(3)--l23.pos, Arrow);
l23.draw();


Leaf l30 = Leaf(n3.keypos(0)+(0,-1.5), 87, 89, 90);
draw(edgePic,n3.keypos(0)--l30.pos, Arrow);
l30.draw();

Leaf l31 = Leaf(n3.keypos(1)+(0,-1.5), 92, 93, 95);
draw(edgePic,n3.keypos(1)--l31.pos, Arrow);
l31.draw();

Leaf l32 = Leaf(n3.keypos(2)+(0,-1.5), 97, 98, 99);
draw(edgePic,n3.keypos(2)--l32.pos, Arrow);
l32.draw();

draw(edgePic,box((-9.7,2),(20.3,-6.2)), white);

add(edgePic);

ship();

label("\texttt{insert(57)}", (-9.6,1.9), SE, deepred);

ship();

erase();

l13 = Leaf(l13.pos, 54, 56, 57, 58, 59);

root.draw();
n0.draw();
n1.draw();
n2.draw();
n3.draw();
l00.draw();
l01.draw();
l02.draw();
l03.draw();
l04.draw();
l10.draw();
l11.draw();
l12.draw();
l13.draw();
l20.draw();
l21.draw();
l22.draw();
l23.draw();
l30.draw();
l31.draw();
l32.draw();

add(edgePic);
ship();

label("\texttt{insert(55)}", (-9.6,1.9), SE, deepred);

ship();

erase();

n1 = Node(n1.pos, 48, 51, 54, 57);
l13 = Leaf(l13.pos, 54, 55, 56);
Leaf l14 = Leaf(n1.keypos(4)+(0,-1.5), 57, 58, 59);
draw(edgePic,n1.keypos(4)--l14.pos, Arrow);



root.draw();
n0.draw();
n1.draw();
n2.draw();
n3.draw();
l00.draw();
l01.draw();
l02.draw();
l03.draw();
l04.draw();
l10.draw();
l11.draw();
l12.draw();
l13.draw();
l14.draw();
l20.draw();
l21.draw();
l22.draw();
l23.draw();
l30.draw();
l31.draw();
l32.draw();


add(edgePic);
ship();
label("\texttt{insert(40)}", (-9.6,1.9), SE, deepred);

ship();

erase();

root = Node(root.pos, 26, 41, 66, 87);

n0 = Node(n0.pos, 8, 18);
Node nn = Node(n1.pos, 35, 38);
n1.pos = n2.pos;
n2.pos = n3.pos;
n3.pos = n2.pos + (nsize, 0);


root.draw();
n0.draw();
nn.draw();
n1.draw();
n2.draw();
n3.draw();
l00.draw();
l01.draw();
l02.draw();

l03.pos = nn.keypos(0) + (0,-1.5);
Leaf ln1 = Leaf(nn.keypos(1) + (0,-1.5), 35, 36, 37);
Leaf ln2 = Leaf(nn.keypos(2) + (0,-1.5), 38, 39, 40);
l03.draw();
ln1.draw();
ln2.draw();

l10.pos += (nsize, 0);
l11.pos += (nsize, 0);
l12.pos += (nsize, 0);
l13.pos += (nsize, 0);
l14.pos += (nsize, 0);
l20.pos += (nsize, 0);
l21.pos += (nsize, 0);
l22.pos += (nsize, 0);
l23.pos += (nsize, 0);
l30.pos += (nsize, 0);
l31.pos += (nsize, 0);
l32.pos += (nsize, 0);

l10.draw();
l11.draw();
l12.draw();
l13.draw();
l14.draw();
l20.draw();
l21.draw();
l22.draw();
l23.draw();
l30.draw();
l31.draw();
l32.draw();

erase(edgePic);
draw(edgePic, root.keypos(0)--root.keypos(0)-(0,0.7)--n0.mid()+(0,0.8)--n0.mid(), Arrow);
draw(edgePic,root.keypos(1)--root.keypos(1)-(0,0.9)--nn.mid()+(0,0.6)--nn.mid(), Arrow);
draw(edgePic,root.keypos(2)--root.keypos(2)-(0,0.9)--n1.mid()+(0,0.6)--n1.mid(), Arrow);
draw(edgePic,root.keypos(3)--root.keypos(3)-(0,0.7)--n2.mid()+(0,0.8)--n2.mid(), Arrow);
draw(edgePic,root.keypos(4)--n3.mid()+(0,1.5)--n3.mid(), Arrow);
draw(edgePic,box((-9.7,2),(20.3,-6.2)), white);

draw(edgePic, n0.keypos(0)--l00.pos, Arrow);
draw(edgePic, n0.keypos(1)--l01.pos, Arrow);
draw(edgePic, n0.keypos(2)--l02.pos, Arrow);
draw(edgePic, nn.keypos(0)--l03.pos, Arrow);
draw(edgePic, nn.keypos(1)--ln1.pos, Arrow);
draw(edgePic, nn.keypos(2)--ln2.pos, Arrow);
draw(edgePic, n1.keypos(0)--l10.pos, Arrow);
draw(edgePic, n1.keypos(1)--l11.pos, Arrow);
draw(edgePic, n1.keypos(2)--l12.pos, Arrow);
draw(edgePic, n1.keypos(3)--l13.pos, Arrow);
draw(edgePic, n1.keypos(4)--l14.pos, Arrow);
draw(edgePic, n2.keypos(0)--l20.pos, Arrow);
draw(edgePic, n2.keypos(1)--l21.pos, Arrow);
draw(edgePic, n2.keypos(2)--l22.pos, Arrow);
draw(edgePic, n2.keypos(3)--l23.pos, Arrow);
draw(edgePic, n3.keypos(0)--l30.pos, Arrow);
draw(edgePic, n3.keypos(1)--l31.pos, Arrow);
draw(edgePic, n3.keypos(2)--l32.pos, Arrow);



add(edgePic);
ship();
