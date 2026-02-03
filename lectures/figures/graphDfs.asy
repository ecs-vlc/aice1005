size(550,0);

import generateGraph;
import myutil;

srand(15);

Graph graph = createGraph(6,0.5,(150,150));


string[] code;
code.push("dfs(graph, node) \{");
code.push("\ \ state $\leftarrow$ Array[n, \"undiscovered\"]");
code.push("\ \ finished $\leftarrow$  false");
code.push("\ \ dfs\_recur(graph, node)");
code.push("\}");
code.push("");
code.push("dfs\_recur(graph, node) \{");
code.push("\ \ if (finished) return");
code.push("\ \ state[node] $\leftarrow$ \"discovered\"");
code.push("\ \ time $\leftarrow$ time + 1");
code.push("\ \ processVertexEarly(node)");
code.push("\ \ foreach neighbour $\in$ Neighbourhood(node) \{");
code.push("\ \ \ \ if (state[neighbour] $=$ \"undiscovered\") \{");
code.push("\ \ \ \ \ \ parent[neighbour] $\leftarrow$ node");
code.push("\ \ \ \ \ \ processEdge(node, neighbour)");
code.push("\ \ \ \ \ \ dfs\_recur(graph, neighbour)");
code.push("\ \ \ \ \} else if (state[neighbour] $\neq$ \"processed\") \{");
code.push("\ \ \ \ \ \ processEdge(node, neighbour)");
code.push("\ \ \ \ \}");
code.push("\ \ \ \ if (finished) return");
code.push("\ \ \}");
code.push("\ \ processVertexLate(currentNode)");
code.push("\ \ state[currentNode] $\leftarrow$ \"processed\"");
code.push("\ \ time $\leftarrow$ time + 1");
code.push("\}");


pair s = (0,0);

picture graphPic;
//draw(graphPic, box((-116,5),(95,150)), white);
graph.draw(graphPic);

void highlightNode(Graph graph, int i, pen col, pair s=(0,0)) {
  real d = min(graph.range.x, graph.range.y)/30.0;
  filldraw(graphPic, circle(s+graph.pos(i), d), white, col+linewidth(1.5));
  label(graphPic, string(i), s+graph.pos(i), col);
}

void highlightEdge(Graph graph, int v1, int v2, pen col, pair s=(0,0)) {
  pair a = s+graph.pos(v1);
  pair b = s+graph.pos(v2);
  pair diff = unit(b-a);
  real d = min(graph.range.x, graph.range.y)/30.0;
  draw(graphPic, a+d*diff--b-d*diff, col+linewidth(2));
}



bool isMember(int[] a, int element) {
  for(int i=0; i<a.length; ++i) {
    if (a[i]==element)
      return true;
  }
  return false;
}

void writeCode(... int[] highlight) {
  for (int i=0; i<code.length; ++i) {
    pen col = (isMember(highlight, i-6))? blue:black;
    label("\texttt{" + code[i] + "}", (-110,30+5*(code.length-i)), E, col);
  }
}


void processVertexEarly(int v) {
}

void processVertexLate(int v) {
}


void processEdge(int v1, int v2) {
}


void next(int node, int neigh, int time) {
  label("\texttt{node}="+string(node), (-100,25),E);
  string neighStr = (neigh>0)? string(neigh): "\texttt{nil}";
  label("\texttt{neighbour}="+neighStr, (-75,25),E);
  label("\texttt{time}="+string(time), (-40,25),E);
  add(graphPic);
  ship();
  erase();
}

int time = 0;

void dfs1(Graph graph, int node, bool[] discovered, bool[] processed,
	  int[] parent, int[] entryTime, int[] exitTime,
	  bool finished) {
  if (finished)
    return;
  discovered[node] = true;
  entryTime[node] = time;
  ++time;
  highlightNode(graph, node, green);
  processVertexEarly(node);
  writeCode(1,2,3,4);
  next(node,-1,time);
  for(int i=0; i<graph.node[node].neighbour.length; ++i) {
    int neighbour = graph.node[node].neighbour[i];
    if (parent[node]==neighbour)
      continue;
    highlightEdge(graph, node, neighbour, green);
    writeCode(5);
    next(node,neighbour,time);
    writeCode(6);
    next(node,neighbour,time);
    if (discovered[neighbour]) {
      writeCode(10);
      next(node,neighbour,time);
    }
    if (!discovered[neighbour]) {
      highlightEdge(graph, node, neighbour, blue);
      writeCode(7,8);
      next(node,neighbour,time);
      parent[neighbour] = node;
      processEdge(node, neighbour);
      writeCode(9);
      next(node,neighbour,time);
      dfs1(graph, neighbour, discovered, processed, parent,
	   entryTime, exitTime, finished);
    } else if ((!processed[neighbour]) || graph.directed) {
      writeCode(11);
      next(node,neighbour,time);
      processEdge(node, neighbour);
    }
    writeCode(13);
    next(node,neighbour,time);    
    if (finished)
      return;
  }
  writeCode(15,16,17);
  highlightNode(graph, node, blue);
  ++time;
  next(node,-1,time);
  processVertexLate(node);
  exitTime[node] = time;
  processed[node] = true;
}
      

void dfs(Graph graph, int node) {
  writeCode(0);
  time = 0;
  next(node, -1, time);
  bool[] discovered = new bool[graph.size()];
  bool[] processed = new bool[graph.size()];
  int[] entryTime = new int[graph.size()];
  int[] exitTime = new int[graph.size()];
  int[] parent = new int[graph.size()];
  bool finished = false;
  
  for(int i=0; i<discovered.length; ++i) {
    discovered[i] = false;
    processed[i] = false;
    parent[i] = -1;
  }

  dfs1(graph, node, discovered, processed, parent, entryTime, exitTime, finished);
}

dfs(graph,0);

erase();
add(graphPic);
label("\Huge tree edge",0.5*(graph.pos(5)+graph.pos(1)), N, blue);
label("\Huge back edge",0.5*(graph.pos(5)+graph.pos(2)), W, green);
shipout("graphDfsEdges");
