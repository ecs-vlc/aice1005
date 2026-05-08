import myutil;
size(245,0);

srand(12115);

int nrand()
{
  return floor(30.0*rand()/randMax);
}


struct ED
{
  int d;
  static ED ED(int v) {
    ED ed = new ED;
    ed.d=v;
    return ed;
  }
}
from ED unravel ED;

ED operator init() {return new ED;}

bool operator <=(ED lhs, ED rhs)
{
  return lhs.d <= rhs.d;
}

bool operator <(ED lhs, ED rhs)
{
  return lhs.d < rhs.d;
}

bool operator >=(ED lhs, ED rhs)
{
  return lhs.d >= rhs.d;
}

bool operator ==(ED lhs, ED rhs)
{
  return lhs.d == rhs.d;
}

struct Heap
{
  ED[] list;

  int size() {return list.length;}

  bool empty() {return list.length==0;}

  void add(ED v) {
    list.push(v);
    int child = list.length-1;
    int parent;
    while(child>0) {
      parent = quotient(child-1,2);
      if (list[parent]<=list[child])
	break;
      ED tmp = list[child];
      list[child] = list[parent];
      list[parent] = tmp;
      child = parent;
    }
  }

  ED getMin() {return list[0];}

  ED removeMin() {
    ED minElem = list[0];
    list[0] = list[list.length-1];
    list.pop();
    int parent = 0;
    int child = 1;
    while (child<list.length) {
      if (child<list.length-1 && list[child+1]<list[child])
	child += 1;
      if (list[child]>=list[parent])
	break;
      ED tmp = list[child];
      list[child] = list[parent];
      list[parent] = tmp;
      parent = child;
      child = 2*parent+1;
    }
    return minElem;
  }

  real xlen = 30;
  real ylen = 30;

  picture drawarray() {
    picture pic;
    size(pic,150,0);
    for(int i=0; i<list.length; ++i) {
      label(pic, string(list[i].d), (i+0.5,0.5));
      draw(pic, box((i,0),(i+1,1)));
    }
    return pic;
  }
  picture draw() {
    picture pic;
    if (list.length==0)
      return pic;
    int maxlayer = floor(log(list.length)/log(2));
    int k = 0;
    real spacing = 2^max(3,maxlayer)*xlen;
    draw(pic, box((-spacing/2-2,6),(spacing/2+2,-3*ylen-6)),white);
    real offset = 0;
    int width = 1;
    for (int layer=0; layer<=maxlayer; layer+=1, width*=2) {
      pair pos = (offset, -layer*ylen);
      for (int i=0; i<width; i+=1) {
	if (2*k+1<list.length) {
	  draw(pic, pos--(pos+(-spacing/4,-ylen)));
	}
	if (2*k+2<list.length) {
	  draw(pic, pos--(pos+(spacing/4,-ylen)));
	}
	picture l;
	label(l,string(list[k].d), pos);
	add(pic,bbox(l,white,FillDraw));
	add(pic,l);
	k += 1;
	if (k==list.length)
	  return pic;
	pos += (spacing,0);
      }
      spacing /= 2;
      offset -= spacing/2;
    }
    return pic;
  }
  void write() {
    string s = "";
    for(int i=0; i<list.length-1; ++i)
      s = s + string(list[i].d) + ", ";
    s = s + string(list[list.length-1].d);
    write(s);
  }
}

Heap operator init() {return new Heap;}


Heap heap;


for(int i=0; i<10; ++i) {
  heap.add(ED(nrand()));
}

shipout("heap0", heap.drawarray());

shipout("heap1", heap.draw());

heap.write();

Heap heap2;


for(int i=0; i<11; ++i) {
  heap2.add(ED(nrand()));
}

erase();
picture q2 = new picture;
add(q2, heap2.draw());

shipout("heap_add_quiz-0", q2);

heap2.add(ED(5));

erase(q2);

add(q2, heap2.draw(), (240,0));
shipout("heap_add_quiz-1", q2);

Heap heap3;

for(int i=0; i<13; ++i) {
  heap3.add(ED(nrand()));
}
picture q3 = new picture;
add(q3, heap3.draw());

shipout("heap_remove_quiz-0", q3);

heap3.removeMin();
erase(q3);
add(q3, heap3.draw(), (240,0));
shipout("heap_remove_quiz-1", q3);

