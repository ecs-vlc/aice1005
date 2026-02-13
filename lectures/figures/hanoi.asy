size(300,0);
import myutil;

picture pegs;
guide g=(-0.5,-0.1)--(-0.5,0);
for(int i=0; i<3; ++i) {
  g=g--(i-0.05,0)--(i-0.05,0.6)--(i+0.05,0.6)--(i+0.05,0);
}
g = g--(2.5,0)--(2.5,-0.1)--cycle;
filldraw(pegs, g, brown);

int n =4;

int[][] disks = new int[3][];
for(int i=0; i<n; ++i) {
  disks[0].push(n-i-1);
}

pen[] col = {red, green, blue, yellow, cyan, magenta};
real h = 0.1;
real w = 0.07;

void drawHanoi() {
  erase();
  add(pegs);
  for(int peg=0; peg<3; ++peg) {
    for(int d=0; d<disks[peg].length; ++d) {
      int dn = disks[peg][d];
      filldraw(box((peg-w*dn-2*w,h*d),(peg+w*dn+2*w,h*d+h)), col[dn]);
    }
  }
  ship();
}

drawHanoi();
void hanoi(int n, int a, int b, int c) {
  if (n==0)
    return;
  hanoi(n-1, a, c, b);
  disks[c].push(disks[a].pop());
  drawHanoi();
  hanoi(n-1, b, a, c);
}

hanoi(n, 0, 1, 2);
