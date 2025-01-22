import myutil;
size(300,0);

draw(box((-7,-3), (8,1)), white);

void emptyArray(int n, pair pos) {
  draw(pos+(-0.5,-0.5)--pos+(n-0.5, -0.5));
  draw(pos+(-0.5,0.5)--pos+(n-0.5, 0.5));
  for(int i=0; i<=n; ++i) {
    draw(pos+(i-0.5, -0.5)--pos+(i-0.5, 0.5));
  }
}

int capacity = 4;
emptyArray(capacity, (0,0));
ship();
picture bg = new picture;
bg.add(currentpicture);

int nrand() {return 10+floor(89.0*rand()/randMax);}

int[] array = new int[8];
int i;
for(i=0; i<capacity; ++i) {
  int r = nrand();
  array[i] = r;
  erase();
  label("list.push\_back(" + string(r) + ")", (-2,0), W, blue);
  draw((-2,0)--(-0.5, 0), red, Arrow);
  label(bg, string(r), (i,0));
  add(bg);
  ship();
}
int r = nrand();
array[i] = r;
++i;
erase();
add(bg);
capacity *= 2;
bg.add(currentpicture);
label("list.push\_back(" + string(r) + ")", (-2,0), W, blue);
draw((-2,0)--(-0.5, 0), red, Arrow);
ship();
erase();
emptyArray(capacity, (0,-2));
bg.add(currentpicture);
erase();
add(bg);
label("list.push\_back(" + string(r) + ")", (-2,0), W, blue);
draw((-2,0)--(-0.5, 0), red, Arrow);
ship();
for(int j=0; j<i-1; ++j) {
  label(string(array[j]), (j, -2));
  ship();
}
erase();
draw(box((-7,-3), (8,1)), white);

label("list.push\_back(" + string(r) + ")", (-2,0), W, blue);
draw((-2,0)--(-0.5, 0), red, Arrow);

emptyArray(capacity, (0,-2));
for(int j=0; j<i-1; ++j) {
  label(string(array[j]), (j, -2));
}

ship();
label(string(array[4]), (4, -2));
ship();
