struct Node {
  pair pos;
  int[] neighbour;
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
  pair range;
  Node[] node;
  Edge[] edges;
  bool directed;
  int size() {return node.length;}
  int noEdges() {return edges.length;}
  Edge edge(int i) {return edges[i];}
  pair pos(int i) {return node[i].pos;}
  void drawNodes(picture pic=currentpicture, pair s=(0,0)) {
    real d = min(range.x,range.y)/30.0;
    for(int i=0; i<size(); ++i) {
      filldraw(pic, circle(s+node[i].pos, d), white, black);
      label(pic, string(i), s+node[i].pos);
    }
  }
  void drawEdges(picture pic=currentpicture, pair s=(0,0)) {
    real d = min(range.x,range.y)/30.0;
    for(int i=0; i<size(); ++i) {
      for(int j=0; j<node[i].neighbour.length; ++j) {
	int n = node[i].neighbour[j];
	if (directed) {
	  pair diff = unit(pos(i) - pos(n));
	  draw(pic, s+pos(i)--s+pos(n)+d*diff, Arrow);
	} else {
	  if (n>i)
	    draw(pic, s+pos(i)--s+pos(n));
	}
      }
    }
  }
  void draw(picture pic=currentpicture, pair s=(0,0)) {
    drawEdges(pic, s);
    drawNodes(pic, s);
  }
  static Graph Graph(pair range, bool directed=false) {
    Graph g = new Graph;
    g.range = range;
    g.directed = directed;
    return g;
  }
  void addNodes(... pair[] pos) {
    for (int i=0; i<pos.length; ++i) {
      Node n;
      n.pos = pos[i];
      node.push(n);
    }
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


real udev() {
  return rand()/(randMax+1.0);
}

pair randPair() {
  return (udev(),udev());
}


real crossDistance(pair a, pair b, pair c) {
  pair ca = c-a;
  pair ba = b-a;
  real t = dot(ca,ba)/dot(ba,ba);
  if (t<=0.0 || t>=1.0)
    return 1.0e30;
  pair d = ca - t*ba;
  return length(d);
}

real minDistance(Graph graph, int node) {
  real md = 1.0e30;
  for (int i=0; i<graph.noEdges(); ++i) {
    int node1 = graph.edge(i).node1;
    int node2 = graph.edge(i).node2;
    if (node1==node || node2==node)
      continue;
    real d = crossDistance(graph.pos(node1), graph.pos(node2), graph.pos(node));
    if (d<md)
      md = d;
  }
  return md;
}  

real nearestNode(Graph graph, int node) {
  real md = 1.0e20;
  for(int n=0; n<graph.size(); ++n) {
    if (n==node)
      continue;
    real d = length(graph.pos(node)-graph.pos(n));
    if (d<md)
      md = d;
  }
  return md;
}

real inrange(real x, real x0, real x1) {
  if (x<x0) {
    x = x0 + 0.2*(x0-x);
  }
  if (x>x1) {
    x = x1 - 0.2*(x-x1);
  }
  return x;
}


bool repositionNodes(Graph graph) {
  real minDistance = 0.15*min(graph.range.x,graph.range.y);
  for(int i=0; i<graph.size(); ++i) {
    while(nearestNode(graph, i)<minDistance) {
      graph.node[i].pos = scale(graph.range.x,graph.range.y)*randPair();
    }
  }

  real[] dist = new real[graph.size()];
  real worst = 1.0e30;
  for(int i=0; i<graph.size(); ++i) {
    dist[i] = minDistance(graph, i);
    if (dist[i]<worst)
      worst=dist[i];
  }

  real accept = 0.1*min(graph.range.x,graph.range.y);
  while(worst<accept) {
    worst = 1.0e30;
    for(int i=0; i<graph.size(); ++i) {
      if (dist[i]<1.2*accept) {
	pair pos = graph.node[i].pos;
	real newDist = dist[i] -1;
	real s = 0.5;
	int cnt = 0;
	while (newDist<dist[i]) {
	  ++cnt;
	  if (cnt>100)
	    return false;
	  pair p = pos + scale(s*graph.range.x,s*graph.range.y)*randPair();
	  graph.node[i].pos=(inrange(p.x,0,graph.range.x), inrange(p.y,0,graph.range.y));
	  s *= 0.9;
	  if (nearestNode(graph, i)<minDistance)
	    continue;
	  newDist = 1.0e30;
	  for(int k=0; k<graph.noEdges(); ++k) {
	    Edge e = graph.edge(k);
	    if (e.node1==i || e.node2==i) {
	      int n = (e.node1==i)? e.node2:e.node1;
	      bool ok = true;
	      for(int j=0; j<graph.size(); ++j) {
		if (j==e.node1 || j==e.node2)
		  continue;
		real d = crossDistance(graph.pos(e.node1),graph.pos(e.node2),graph.pos(j));
		if (d>dist[j])
		  continue;
		if (d<dist[j] && d>1.2*accept) {
		  dist[j] = d;
		  continue;
		}
		ok = false;
		break;
	      }
	      if (!ok) {
		newDist = dist[i]-1;
		break;
	      }
	    } else {
	      real d = crossDistance(graph.pos(e.node1), graph.pos(e.node2), graph.pos(i));
	      if (d<newDist)
		newDist = d;
	    }
	  }
	}
	dist[i] = newDist;
      }
      if (dist[i]<worst)
	worst = dist[i];
    }
  }
  return true;
}
		 


Graph createGraph(int n, real p, pair range, bool directed=false) {
  Graph graph;
  graph.directed = directed;
  graph.range = range;
  for(int i=0; i<n; ++i) {
    Node node;
    node.pos = scale(range.x,range.y)*randPair();
    graph.node.push(node);
  }
  for(int i=0; i<n; ++i) {
    int begin = (directed)? 0:i+1;
    for(int j=begin; j<n; ++j) {
      if (j==i)
	continue;
      if (udev()<p) {
	graph.node[i].neighbour.push(j);
	graph.edges.push(Edge(i,j));
	if (!directed)
	  graph.node[j].neighbour.push(i);
      }
    }
  }
  while (!repositionNodes(graph)) {
    for(int i=0; i<n; ++i) {
      graph.node[i].pos = scale(range.x,range.y)*randPair();
    }
  }
  return graph;
}



