import labelledGraph;
import myutil;

Graph graph = Graph(true);

graph.addNode("zig.cc", (0,0));
graph.addNode("boz.h", (50,0));
graph.addNode("zag.cc", (100,0));
graph.addNode("yow.h", (150,0));
graph.addNode("daz.h", (200,0));
graph.addNode("bar.cc", (250,0));
graph.addNode("zow.h", (300,0));
graph.addNode("foo.cc", (350,0));

graph.addNode("zig.o", (25,-50));
graph.addNode("zag.o", (100,-50));
graph.addNode("bar.o", (250,-50));
graph.addNode("foo.o", (325,-50));

graph.addNode("libfoo.a", (200,-80));
graph.addNode("libzigzag.a", (100,-110));

graph.addEdges((0,8), (1,9), (1,9), (2,9), (3,9), (4,9), (1,10), (3,10),
	       (4,10), (5,10), (6,10), (4,11), (6,11), (7,11), (10,12),
	       (11,12), (8,13), (9,13), (12,13));

picture pic = new picture;
graph.draw(pic);

string[] stack;

void drawStack(string[] stack, pair pos) {
  draw(shift(pos)*((0,0)--(0,140)));
  draw(shift(pos)*((80,0)--(80,140)));
  for(int i=0; i<14; ++i) {
    draw(pos+(0,10*i)--pos+(80,10*i));
  }
  for (int i=0; i<stack.length; ++i)
    label(stack[i], pos+(40,5+10*i));
}

struct DfsData {
  bool[] discovered;
  bool[] processed;
  int[] entryTime;
  int[] exitTime;
  int[] parent;
  static DfsData DfsData(int n) {
    DfsData d = new DfsData;
    d.discovered = new bool[n];
    d.processed = new bool[n];
    d.entryTime = new int[n];
    d.exitTime = new int[n];
    d.parent = new int[n];
    return d;
  }
};

from DfsData unravel DfsData;

void next() {
  erase();
  draw(box((-25,20),(480,-140)),white);
  drawStack(stack, (380,-130));
  add(pic);
  ship();
}

next();

void processVertexEarly(int v, DfsData data) {
  graph.drawNode(pic, v, green);
  next();
}

void processVertexLate(int v, DfsData data) {
  graph.drawNode(pic, v, blue);
  stack.push(graph.node[v].name);
  next();
}

void processEdge(int v1, int v2, DfsData data) {
}

int time = 0;
bool finished = false;

void dfs1(Graph graph, int node, DfsData data) {
  if (finished)
    return;
  data.discovered[node] = true;
  data.entryTime[node] = time;
  ++time;
  processVertexEarly(node, data);
  for(int i=0; i<graph.node[node].neighbour.length; ++i) {
    int neighbour = graph.node[node].neighbour[i];
    if (!data.discovered[neighbour]) {
      data.parent[neighbour] = node;
      processEdge(node, neighbour, data);
      dfs1(graph, neighbour, data);
    } else if ((!data.processed[neighbour]) || graph.directed) {
      processEdge(node, neighbour, data);
    }
    if (finished)
      return;
  }
  processVertexLate(node, data);
  ++time;
  data.exitTime[node] = time;
  data.processed[node] = true;
}
      
time = 0;
finished = false;
DfsData data = DfsData(graph.size());
  
for(int i=0; i<graph.size(); ++i) {
  data.discovered[i] = false;
  data.processed[i] = false;
  data.parent[i] = -1;
}


for (int i=0; i<graph.size(); ++i) {
  if (!data.discovered[i])
    dfs1(graph, i, data);
}



