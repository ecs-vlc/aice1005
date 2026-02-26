import myutil;

size(200,0);

void drawArray(int type, int[] a) {
  draw(box((0,1.2*type),(a.length, 1.2*type+1)));
  for(int i=0; i<a.length; ++i) {
    draw((i, 1.2*type)--(i, 1.2*type+1));
    if (a[i]>-2)
      label(string(a[i]), (i+0.5, 1.2*type+0.5));
    if (type==1) {
      label("\small{" + string(i) + "}", (i+0.5, 1.2*type+1), N, blue);
    }
  }
}

void command(string s) {
  label("\texttt{" + s + "}", (0,3), NE);
}

struct FastSet {
  int[] set;
  int[] index;
  int last;
  static FastSet FastSet(int n) {
    FastSet fs = new FastSet;
    fs.set = array(n, -2);
    fs.index = array(n, -1);
    fs.last = 0;
    return fs;
  }
  void draw() {
    draw(box((-0.1,-0.1),(set.length+0.1, 3.7)), white);
    drawArray(0, set);
    drawArray(1, index);
  }
  bool add(int i) {
    command("add(" + string(i) + ")");
    if (index[i]>-1)
      return false;
    index[i] = last;
    set[last] = i;
    ++last;
    return true;
  }
  bool remove(int i) {
    command("remove(" + string(i) + ")");
    if (index[i]==-1)
      return false;
    --last;
    set[index[i]] = set[last];
    index[set[last]] = index[i];
    set[last]  = -2;
    index[i] = -1;
    return true;
  }
  bool find(int i) {
    command("contains(" + string(i) + ")");
    if (index[i]==-1)
      return false;
    else
      return true;
  }
};

from FastSet unravel FastSet;

FastSet fs = FastSet(10);
fs.draw();
ship();
fs.add(4);
ship();
erase();
fs.draw();
command("true");
ship();
erase();
fs.draw();
fs.add(9);
ship();
erase();
fs.draw();
command("true");
ship();
erase();
fs.draw();
fs.add(7);
ship();
erase();
fs.draw();
command("true");
ship();
erase();
fs.draw();
fs.add(4);
ship();
erase();
fs.draw();
command("false");
ship();
erase();
fs.draw();
fs.add(1);
ship();
erase();
fs.draw();
command("true");
ship();
erase();
fs.draw();
fs.find(9);
ship();
erase();
fs.draw();
command("true");
ship();
erase();
fs.draw();
fs.find(5);
ship();
erase();
fs.draw();
command("false");
ship();
erase();
fs.draw();
fs.remove(9);
ship();
erase();
fs.draw();
command("true");
ship();
