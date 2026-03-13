size(200,0);

pair pos(real r, real theta) { return r*(Cos(theta),Sin(theta)); }
pair[] nodes = {pos(4,90), pos(4,210), pos(4,330), pos(1,30), pos(1,150), pos(1,270)};

for(int i=0; i<nodes.length; ++i) {
  dot(nodes[i], linewidth(3));
}

pair[] edges = {(0,1),(1,2),(2,0),(3,4),(4,5),(5,3),(3,0),(3,2),(4,0),(4,1),(5,1),(5,2)};

for(int i=0; i<edges.length; ++i) {
  int v1 = floor(edges[i].x);
  int v2 = floor(edges[i].y);
  draw(nodes[v1]--nodes[v2]);
}

int[] euler = {3,5,4,0,1,2,0,3,2,5,1,4,3};

draw(box((-3.6,-2.3),(3.6,4.2)),white);
import myutil;
ship();

for(int i=1; i<euler.length; ++i) {
  draw(nodes[euler[i-1]]--nodes[euler[i]], blue, MidArrow);
  ship();
}
