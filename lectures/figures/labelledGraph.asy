struct Node {
  pair pos;
  string name;
  int[] neighbour;
  path p;
}

struct Edge {
  int node1;
  int node2;
  static Edge Edge(int i, int j) {
    Edge e = new Edge;
    e.node1 = i;
    e.node2 = j;
    return e;
  }
}

from Edge unravel Edge;

struct Graph {
  Node[] node;
  Edge[] edges;
  bool directed;
  int size() {return node.length;}
  int noEdges() {return edges.length;}
  Edge edge(int i) {return edges[i];}
  pair pos(int i) {return node[i].pos;}
  void drawNode(picture pic=currentpicture, int i, pen col = black, real width=0.5) {
    label(pic, node[i].name, node[i].pos, col);
    //     label(pic, string(i), node[i].pos, N, red);
    draw(pic, node[i].p, col+linewidth(width));
  }
  void drawNodes(picture pic=currentpicture) {
    for(int i=0; i<size(); ++i) {
      drawNode(pic, i);
    }
  }
  void drawEdge(picture pic=currentpicture, int i, int n, pen col = black, real width=0.5) {
    path p = pos(i)--pos(n);
    pair p1 = point(p,intersect(p,node[i].p)[0]); 
    pair p2 = point(p,intersect(p,node[n].p)[0]); 
    if (directed) {
      draw(pic, p1--p2, col+linewidth(width), Arrow);
    } else {
      if (n>i)
	draw(pic, p1--p2, col+linewidth(width));
    }
  }  
  void drawEdges(picture pic=currentpicture) {
    for(int i=0; i<size(); ++i) {
      for(int j=0; j<node[i].neighbour.length; ++j) {
	int n = node[i].neighbour[j];
	drawEdge(pic, i, n);
      }
    }
  }
  void draw(picture pic=currentpicture) {
    drawEdges(pic);
    drawNodes(pic);
  }
  static Graph Graph(bool directed=false) {
    Graph g = new Graph;
    g.directed = directed;
    return g;
  }
  void addNode(string l, pair pos) {
    Node n;
    n.pos = pos;
    n.name = l;
    frame f = newframe;
    Label l = Label(n.name, n.pos);
    label(l);
    n.p = ellipse(f, l);
    node.push(n);
  }
  void addEdges(... pair[] edge) {
    for (int i=0; i<edge.length; ++i) {
      int v1 = floor(edge[i].x);
      int v2 = floor(edge[i].y);
      edges.push(Edge(v1,v2));
      node[v1].neighbour.push(v2);
      if (!directed)
	node[v2].neighbour.push(v1);
    }
  }
}

from Graph unravel Graph;

