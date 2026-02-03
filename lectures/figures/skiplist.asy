import myutil;
size(400,0);

int nrand()
{
  return floor(100.0*rand()/randMax);
}

int[] list;

for(int i=0; i<10; ++i) {
  list.push(nrand());
}

list = sort(list);

for(int i=0; i<list.length; ++i) {
  label(string(list[i]), (2*i, 0));
  draw(box((2*i-0.5,-0.5),(2*i+0.5,0.5)));
  if (i>0) {
    draw((2*i-1.5,0)--(2*i-0.5,0), Arrow);
  }
}

for(real x=0; x<10; x+=9/4) {
  int i = floor(x);
  label(string(list[i]), (2*i, 2));
  draw(box((2*i-0.5,1.5),(2*i+0.5,2.5)));
  draw((2*i,1.5)--(2*i,0.5),Arrow);
  if (i>0) {
    int j = floor(x-9/4);
    draw((2*j+0.5,2)--(2*i-0.5,2), Arrow);
  }
}

for(real x=0; x<10; x+=9/2) {
  int i = floor(x);
  label(string(list[i]), (2*i, 4));
  draw(box((2*i-0.5,3.5),(2*i+0.5,4.5)));
  draw((2*i,3.5)--(2*i,2.5),Arrow);
  if (i>0) {
    int j = floor(x-9/2);
    draw((2*j+0.5,4)--(2*i-0.5,4), Arrow);
  }
}

label("level 0", (-1,0), W);
label("level 1", (-1,2), W);
label("level 2", (-1,4), W);

draw(box((-3.1,-0.6),(18.6,5.9)),white);

shipout("skiplist0");

label("contains(79)",(0,5), N, red);

shipout("skiplist1");

draw((0.6,3.8)..(3,3.4)..(7.3,3.8), red+linewidth(2), Arrow(HookHead,8));
draw((8.2,3.4)..(8.4,3)..(8.2,2.6), red+linewidth(2), Arrow(HookHead,5));
draw((8.6,1.8)..(10,1.4)..(11.3,1.8), red+linewidth(2), Arrow(HookHead,8));
draw((12.2,1.4)..(12.4,1)..(12.2,0.6), red+linewidth(2), Arrow(HookHead,5));
draw((12.6,-0.2)..(13,-0.3)..(13.3,-0.2), red+linewidth(2), Arrow(HookHead,5));
shipout("skiplist2");
