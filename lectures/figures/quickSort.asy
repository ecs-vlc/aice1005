size(400,0);
srand(47);

pen colour(bool x) {return x? heavyred:black;}
string slow = "l";
string shigh = "h";
string spivot = "p";
string sindex = "i";
int pc = -1;

void drawAlgorithm() {
  string command[];
  command.push("\texttt{quickSort(\textbf{a}, " + slow + ", " +  shigh
	       + ") \{}");
  command.push("\quad\texttt{if(" + shigh + "-" +  slow +">3) \{}");
  command.push("\quad\quad\texttt{p = choosePivot(\textbf{a}, " + slow + ", "

	       +  shigh +")}");
  command.push("\quad\quad\texttt{i = partition(\textbf{a}, " + spivot
	       + ", " +  slow + ", " + shigh + ")}");
  command.push("\quad\quad\texttt{quickSort(\textbf{a}, " + slow + ", "
	       +  sindex + "-1)}");
  command.push("\quad\quad\texttt{quickSort(\textbf{a}, " + sindex + "+1, "
	       +  shigh + ")}");
  command.push("\quad\texttt{\} else }");
  command.push("\quad\quad\texttt{insertionSort(\textbf{a}, " + slow + ", "
	       + shigh + ")}");
  command.push("\quad\texttt{return}");
  command.push("\texttt{\}}");
  for (int i=0; i<=9; ++i) {
    label("\footnotesize " + string(i), (-5,-10*i), gray);
    label(command[i], (0,-10*i), E, colour(pc==i));
  }
}

pair arrayPos(int i) {return (10*i+5,-105);}

void drawArray(int[] a) {
  draw((0,-100)--(10*a.length,-100)--(10*a.length,-110)--(0,-110)--cycle);
  for (int i=0; i<a.length; ++i) {
    label(string(a[i]), arrayPos(i));
    label("\footnotesize " + string(i), arrayPos(i)+(0,5), N, gray);
    draw((10*i,-100)--(10*i,-110));
  }
}

draw(box((-10, -130), (210,10)),white);

int piccnt = 0;
void show() {
  string fn = "quickSort-" + string(piccnt);
  shipout(fn);
  ++piccnt;
  erase();
  draw(box((-10, -130), (210,10)),white);
}

struct Var {
  int[] var;
  static Var Var(int pc, int low, int high, int pivot=-1, int index=-1) {
    Var v = new Var;
    v.var.push(pc);
    v.var.push(low);
    v.var.push(high);
    v.var.push(pivot);
    v.var.push(index);
    return v;
  }
}
from Var unravel Var;

Var[] stack = new Var[];

string[] varName = {"pc", "l", "h", "p", "i"};

void drawStack() {
  draw((140,-80)--(190,-80));
  for(int i=0; i<=5; ++i) {
    draw((140+10*i,-80)--(140+10*i,-30));
  }
  for(int i=0; i<5; ++i)
    label(varName[i], (145+10*i,-90), N);
  for(int j=0; j<stack.length; ++j) {
    for(int i=0; i<5; ++i) {
      string s = (stack[j].var[i]>=0)? string(stack[j].var[i]):"\#";
      label(s, (145+10*i,-78+10*j), N);
    }
  }
}

void drawPC() {
  picture varpic = new picture;
  label(varpic, "\texttt{PC = " + string(pc) + "}", (0,0), E);
  label(varpic, "\texttt{l = " + slow + "}", (0,-10), E);
  label(varpic, "\texttt{h = " + shigh + "}", (0,-20), E);
  string sp = (spivot=="p")? "\#": spivot;
  label(varpic, "\texttt{p = " + sp + "}", (0,-30), E);
  string si = (sindex=="i")? "\#": sindex;
  label(varpic, "\texttt{i = " + si + "}", (0,-40), E);
  draw(varpic, box((-1,-47), (45,7)));
  add(varpic,(155,4));
}


void drawAll(int[] a, int low, int high) {
  drawAlgorithm();
  drawArray(a);
  drawStack();
  drawPC();
  label(rotate(90)*"low", arrayPos(low)-(0,7), S);
  label(rotate(90)*"high", arrayPos(high)-(0,7), S);
  show();
}

drawAlgorithm();
drawStack();

show();

void hl(int i, int j) {
  fill(box((10*i,-110),(10*j+10,-100)), pink);
}

void highlight(int[] a, int i) {
  hl(i,i);
  label(string(a[i]), arrayPos(i), blue);
}

void highlight1(int[] a, int i) {
  filldraw(box((10*i,-110),(10*i+10,-100)), red, black);
  label("\bf " + string(a[i]), arrayPos(i), blue);
}



int findPivot(int[] a, int low, int high) {
  int mid = floor((low+high)/2);
  highlight(a, low);
  highlight(a, mid);
  highlight(a, high);
  int idx;
  if (a[low]<a[mid]) {
    if (a[high]<a[low]) {
      idx = low;
    } else {
      if (a[high]<a[mid])
	idx = high;
      else
	idx = mid;
    }
  } else {
    if (a[high]>a[low]) {
      idx = low;
    } else {
      if (a[high]>a[mid])
	idx = high;
      else
	idx = mid;
    }
  }
  highlight1(a, idx);
  drawAll(a, low, high);
  return a[idx];
}

int partition(int[] a, int low, int high, int pivot) {
  //  write("Partition start");
  int i = low;
  int j = high;
  //  write(pivot);
  while (true) {
    //    write(i,j);
    //    write(a[i], a[j]);
    while (a[i]<pivot && i<j)
      ++i;
    while (a[j]>=pivot && i<j)
      --j;
    if (i>=j)
      break;
    int swap = a[i];
    a[i] = a[j];
    a[j] = swap;
  }
  hl(low,high);
  //  write(i);
  int i;
  for(i=j; i<=high; ++i) {
    if (a[i]==pivot)
      break;
  }
  if (i>j) {
    a[i] = a[j];
    a[j] = pivot;
  }
  highlight1(a, j);
  drawAll(a, low, high);
  //  write("Partition end");
  return j;
}

void insertionSort(int[] a, int low, int high) {
  for (int i=low+1; i<=high; ++i) {
    int v = a[i];
    int j = i-1;
    while(j>=low && a[j]>v) {
      a[j+1] = a[j];
      --j;
    }
    a[j+1] = v;
  }
  hl(low,high);
  drawAll(a, low,high);
}

void qsort(int[] a, int low, int high) {
  slow = string(low);
  shigh = string(high);
  spivot = "p";
  sindex = "i";
  pc = 0;
  drawAll(a, low,high);
  pc = 1;
  drawAll(a, low,high);
  if (high-low>3) {
    pc = 2;
    drawAll(a, low, high);
    stack.push(Var(pc, low, high));
    int pivot = findPivot(a, low, high);
    spivot = string(pivot);
    stack.pop();
    pc = 3;
    drawAll(a, low, high);
    stack.push(Var(pc, low, high, pivot));
    int index = partition(a, low, high, pivot);
    sindex = string(index);
    stack.pop();
    pc = 4;
    drawAll(a, low, high);
    stack.push(Var(pc, low, high, pivot, index));
    qsort(a, low, index-1);
    slow = string(low);
    shigh = string(high);
    spivot = string(pivot);
    sindex = string(index);
    stack.pop();
    pc = 5;
    drawAll(a, low, high);
    stack.push(Var(pc, low, high, pivot, index));
    qsort(a, index+1, high);
    slow = string(low);
    shigh = string(high);
    spivot = string(pivot);
    sindex = string(index);
    stack.pop();
    pc = 8;
    drawAll(a, low, high);
  } else {
    pc = 7;
    drawAll(a, low, high);
    stack.push(Var(pc, low, high));
    insertionSort(a, low, high);
    stack.pop();
    pc = 8;
    drawAll(a, low, high);
  }
}

int a[] = new int[20];
for (int i=0; i<a.length; ++i) {
  a[i] = floor(100*(rand()/randMax));
}

qsort(a, 0,19);
