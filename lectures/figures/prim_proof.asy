import myutil;
size(400,0);

int n = 10;

pair[] node;
node[0] = (92.9153,41.3038);
node[1] = (30.4621,36.2943);
node[2] = (116.138,3.29602);
node[3] = (19.2513,12.9906);
node[4] = (77.7001,65.751);
node[5] = (77.7906,22.0895);
node[6] = (100.003,74.981);
node[7] = (61.6787,46.6768);
node[8] = (36.5051,76.865);
node[9] = (6.20082,67.1385);


    

struct Edge {
  int v1;
  int v2;
  static Edge Edge(int i, int j) {
    Edge e = new Edge;
    e.v1 = i;
    e.v2 = j;
    return e;
  }
  void draw(pen p) {
    draw(node[v1]--node[v2], p);
  }
  pair midpoint() {
    return 0.5*(node[v1]+node[v2]);
  }
}

Edge[] edge = new Edge[16];
int weight[] = new int[16];


// Edges
edge[0] = Edge.Edge(0,2);
weight[0] = 45;
edge[1] = Edge.Edge(0,4);
weight[1] = 29;
edge[2] = Edge.Edge(0,5);
weight[2] = 24;
edge[3] = Edge.Edge(0,7);
weight[3] = 32;
edge[4] = Edge.Edge(1,3);
weight[4] = 26;
edge[5] = Edge.Edge(1,7);
weight[5] = 33;
edge[6] = Edge.Edge(1,8);
weight[6] = 41;
edge[7] = Edge.Edge(1,9);
weight[7] = 39;
edge[8] = Edge.Edge(2,5);
weight[8] = 43;
edge[9] = Edge.Edge(3,5);
weight[9] = 59;
edge[10] = Edge.Edge(4,6);
weight[10] = 24;
edge[11] = Edge.Edge(4,7);
weight[11] = 25;
edge[12] = Edge.Edge(4,8);
weight[12] = 43;
edge[13] = Edge.Edge(5,7);
weight[13] = 29;
edge[14] = Edge.Edge(7,8);
weight[14] = 39;
edge[15] = Edge.Edge(8,9);
weight[15] = 32;




int nopic = 0;

void show() {
  string fn = "prim_proof" + string(nopic);
  for(int i=0; i<edge.length; ++i) {
    edge[i].draw(black);
    label(string(weight[i]), edge[i].midpoint(), Fill(white));
  }
  for(int i=0; i<node.length; ++i) {
    dot(node[i], linewidth(5));
  }
  shipout(fn);
  ++nopic;
}

edge[1].draw(red+linewidth(3));
edge[2].draw(red+linewidth(3));
edge[11].draw(red+linewidth(3));
edge[10].draw(red+linewidth(3));

label("\large $T_4$", (node[0]+node[4]+node[6])/3.0, red);

show();

edge[5].draw(green+linewidth(3));

label("\large $T_5$", edge[5].midpoint()-(0,7), heavygreen);

show();

edge[4].draw(blue+linewidth(3));
edge[7].draw(blue+linewidth(3));
edge[8].draw(blue+linewidth(3));
edge[14].draw(blue+linewidth(3));
edge[15].draw(blue+linewidth(3));

show();

erase();


edge[1].draw(red+linewidth(3));
edge[2].draw(red+linewidth(3));
edge[11].draw(red+linewidth(3));
edge[10].draw(red+linewidth(3));

edge[4].draw(blue+linewidth(3));
edge[7].draw(blue+linewidth(3));
edge[8].draw(blue+linewidth(3));
edge[5].draw(blue+linewidth(3));
edge[15].draw(blue+linewidth(3));

show();
