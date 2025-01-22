size(500,0);

import myutil;

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
  void drawNode(int i, pen p, picture pic=currentpicture, pair s=(0,0)) {
    real d = min(range.x,range.y)/30.0;
    filldraw(pic, circle(s+node[i].pos, d), white, p);
    label(pic, string(i), s+node[i].pos, p);
  }
  void drawEdge(int i, int j, pen p, picture pic=currentpicture, pair s=(0,0)) {
    draw(pic, s+pos(i)--s+pos(j), p);
    drawNode(i, p, pic, s);
    drawNode(j, p, pic, s);
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
	  if (n>i) {
	    draw(pic, s+pos(i)--s+pos(n));
	    label(string(floor(length(pos(i)-pos(n)))),
		  0.5*(pos(i)+pos(n)), UnFill);
	  }
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

struct ED {
  int current;
  int next;
  real dist;
  static ED ED(int n1, int n2, real d) {
    ED ed = new ED;
    ed.current = n1;
    ed.next = n2;
    ed.dist = d;
    return ed;
  }
};
from ED unravel ED;

bool operator>(ED ed1, ED ed2) {return ed1.dist>ed2.dist;}
bool operator>=(ED ed1, ED ed2) {return ed1.dist>=ed2.dist;}
bool operator<(ED ed1, ED ed2) {return ed1.dist<ed2.dist;}
bool operator<=(ED ed1, ED ed2) {return ed1.dist<=ed2.dist;}

Graph graph = createGraph(12, 0.3, (100,50));

graph.addEdges((2,11));
graph.draw();

struct Heap
{
  ED[] list;

  int size() {return list.length;}

  bool empty() {return list.length==0;}

  void add(ED v) {
    list.push(v);
    int child = list.length-1;
    int parent;
    while(child>0) {
      parent = quotient(child-1,2);
      if (list[parent]<=list[child])
        break;
      ED tmp = list[child];
      list[child] = list[parent];
      list[parent] = tmp;
      child = parent;
    }
  }
  ED getMin() {return list[0];}

  ED removeMin() {
    ED minElem = list[0];
    list[0] = list[list.length-1];
    list.pop();
    int parent = 0;
    int child = 1;
    while (child<list.length) {
      if (child<list.length-1 && list[child+1]<list[child])
        child += 1;
      if (list[child]>=list[parent])
        break;
      ED tmp = list[child];
      list[child] = list[parent];
      list[parent] = tmp;
      parent = child;
      child = 2*parent+1;
    }
    return minElem;
  }
}

real big = 1.0e30;
real[] dist = new real[graph.size()];
bool[] visited = new bool[graph.size()];
for(int i=0; i<dist.length; ++i) {
  dist[i] = big;
  visited[i] = false;
}

void showCost(int i) {
  label("\small "+ string(floor(dist[i])), graph.pos(i)+(2.5,-2.5), red);
}
  

Heap pq = new Heap;

draw(box((-5,0),(105,55)), white);

ship();
int current = 0;
dist[current] = 0.0;
visited[current] == true;

graph.drawNode(current, red+linewidth(2));
showCost(current);

ship();

for(int i=0; i<dist.length-1; ++i) {
  for(int k=0; k<graph.node[current].neighbour.length; ++k) {
    int neigh = graph.node[current].neighbour[k];
    real d = length(graph.pos(current)-graph.pos(neigh));
    if (dist[current]+d < dist[neigh]) {
      dist[neigh] = dist[current]+d;
      pq.add(ED(current, neigh, dist[neigh]));
    }
  }
  ED ed = pq.removeMin();
  while(visited[ed.next]) {
    ed = pq.removeMin();
  }
  graph.drawEdge(ed.current, ed.next, red+linewidth(2));
  showCost(ed.next);
  ship();
  current = ed.next;
}

int current = 11;
while (current!=0) {
  int neigh;
  for(int k=0; k<graph.node[current].neighbour.length; ++k) {
    neigh = graph.node[current].neighbour[k];
    real d = length(graph.pos(current)-graph.pos(neigh));
    if (fabs(dist[neigh] + d - dist[current]) < 0.1)
      break;
  }
  graph.drawEdge(current, neigh, blue+linewidth(2));
  ship();
  current = neigh;
}
