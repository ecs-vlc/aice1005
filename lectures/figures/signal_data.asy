import myutil;
size(500,0);

real f(int i) {
  return 3.0*exp(0.01*i)*sin(0.2*i+0.01*i*i);
}

int n=30;
draw((0,0)--(n,0));
for(int i=0; i<=n; ++i) {
  draw((i,0)--(i,-0.3));
  label("$x_{" + string(i) + "}$", (i,-0.3), S);
  dot((i,f(i)));
}
