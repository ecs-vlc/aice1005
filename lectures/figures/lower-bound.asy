import myutil;
size(400,0);

import graph;

real f(real x) {
  return log(0.01)-log(abs(x)+0.01);
}

filldraw(graph(f,-10.0,10.0,operator--)--cycle,lightgray,black);

draw((-10,-8)--(10,-8), Arrows);
label("$n!$ outcomes", (0,-8), UnFill);

draw((11,0)--(11,f(10)), Arrows);

label("depth $\geq \log_2(n!) = \Theta(n\log(n))$", (11,0.5f(10)), UnFill);

label("Decision Tree", (-3,f(-3)), NW);

srand(121311);
real drand() {
  return rand()/randMax - 0.4;
}

real dy = 0.0499*f(10);
real dx = 0.005;
pair x= (0,0);
guide g = x;
for(int i; i<20; ++i, dx*=1.45) {
  x = x + (dx*drand(), dy);
  g = g--(x);
}

draw(g, blue);
