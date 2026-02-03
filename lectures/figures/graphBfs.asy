size(550,0);

import generateGraph;
import myutil;

srand(15);

Graph graph = createGraph(6,0.5,(150,150));


struct Queue {
  int[] data;
  int head;
  int noEntries;
  void enqueue(int i) {
    ++noEntries;
    data.push(i);
  }
  int dequeue() {
    --noEntries;
    ++head;
    return data[head];
  }
  static Queue Queue() {
    Queue q = new Queue;
    q.head = -1;
    q.noEntries = 0;
    return q;
  }
  int peek() {
    return data[head+1];
  }
  void draw() {
    label("q=",(-92,15),W);
    draw(box((-90,10),(-30,20)));
    for(int i=-80; i<-30; i+=10)
      draw((i,10)--(i,20));
    int h = head+1;
    for(int i=0; i<noEntries; ++i) {
      label(string(data[h]),(-85+10*i,15));
      ++h;
    }
  }
};


from Queue unravel Queue;


string[] code;
code.push("bfs(graph, node) \{");
code.push("\ \ List state(graph.noNodes, \"undiscovered\")");
code.push("\ \ List parent(graph.noNodes)");
code.push("\ \ state[node] $\leftarrow$ \"discovered\"");
code.push("\ \ parent[node] $\leftarrow$ nil");
code.push("\ \ Queue q");
code.push("\ \ q.enqueue(node)");
code.push("\ \ while (!q.isEmpty()) \{");
code.push("\ \ \ \ currentNode $\leftarrow$ q.dequeue()");
code.push("\ \ \ \ processVertexEarly(currentNode)");
code.push("\ \ \ \ state[currentNode] $\leftarrow$ \"processed\"");
code.push("\ \ \ \ foreach neighbour $\in$ Neighbourhood(currentNode) \{");
code.push("\ \ \ \ \ \ if (state[neighbour] $\neq$ \"processed\")");
code.push("\ \ \ \ \ \ \ \ processEdge(currentNode, neighbour)");
code.push("\ \ \ \ \ \ if (state[neighbour] = \"undiscovered\") \{");
code.push("\ \ \ \ \ \ \ \ state[neighbour] $\leftarrow$ \"discovered\"");
code.push("\ \ \ \ \ \ \ \ parent[neighbour] $\leftarrow$ currentNode");
code.push("\ \ \ \ \ \ \ \ q.enqueue(neighbour)");
code.push("\ \ \ \ \ \ \}");
code.push("\ \ \ \ \}");
code.push("\ \ \ \ processVertexLate(currentNode)");
code.push("\ \ \}");
code.push("\}");


pair s = (0,0);

picture graphPic;
draw(graphPic, box((-116,5),(95,150)), white);
graph.draw(graphPic);
add(graphPic);

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


void writeCode(string[] code, int highlight=-1) {
  for (int i=0; i<code.length; ++i) {
    pen col = (i==highlight)? blue:black;
    label("\texttt{" + code[i] + "}", (-110,20+5*(code.length-i)), E, col);
  }
}

void writeRegisters(int currentNode, int neighbour) {
  if (currentNode>=0)
    label("currentNode="+string(currentNode), (-92,25), E);
  if (neighbour>=0)
    label("neighbour="+string(neighbour), (-55,25), E);
}

bool isMember(int[] a, int element) {
  for(int i=0; i<a.length; ++i) {
    if (a[i]==element)
      return true;
  }
  return false;
}

void writeCodeH(string[] code, int[] highlight) {
  for (int i=0; i<code.length; ++i) {
    pen col = (isMember(highlight, i))? blue:black;
    label("\texttt{" + code[i] + "}", (-110,20+5*(code.length-i)), E, col);
  }
}


void processVertexEarly(int v, Queue q) {
  //  q.enqueue(v);
  write(v);
  erase();
  add(currentpicture, graphPic);
  //  writeRegisters(v, -1);

  q.draw();
  highlightNode(graph, v, red, s);
  writeCode(code,7);
  ship();
  q.dequeue();
  erase();
  add(currentpicture, graphPic);
  writeRegisters(v, -1);
  int[] lines = {8,9,10};
  writeCodeH(code,lines);
  q.draw();
  ship();
}

void processVertexLate(int v, int parent, Queue q) {
  write(v);
  erase();
  highlightNode(graph,v, blue);
  add(currentpicture, graphPic);
  writeRegisters(v, -1);
  writeCode(code,20);
  q.draw();
  ship();
}


void processEdge(int v1, int v2, bool[] discovered, bool[] processed, Queue q) {
  erase();
  writeRegisters(v1, v2);

  highlightEdge(graph, v1, v2, green, (0,0));
  add(currentpicture, graphPic);
  writeCode(code,11);
  q.draw();
  ship();
  erase();
  writeRegisters(v1, v2);
  if (!processed[v2]) {
    add(currentpicture, graphPic);
    int[] lines = {12,13};
    writeCodeH(code,lines);
    q.draw();
    ship();
  } else {
    add(currentpicture, graphPic);
    writeCode(code,12);
    q.draw();
    ship();
  }    
  erase();
  writeRegisters(v1, v2);
  add(currentpicture, graphPic);
  writeCode(code,14);
  q.draw();
  ship();
  if (!discovered[v2]) {
    q.enqueue(v2);
    erase();
    writeRegisters(v1, v2);
    highlightNode(graph,v2,green,(0,0));
    highlightEdge(graph, v1, v2, blue, (0,0));
    add(currentpicture, graphPic);
    int[] h = {15,16,17};
    writeCodeH(code,h);
    q.draw();
    ship();
  }
}

void bfs(Graph graph, int startNode) {
  Queue queue = Queue();
  bool[] discovered = new bool[graph.size()];
  bool[] processed = new bool[graph.size()];
  int[] parent = new int[graph.size()];
  
  for(int i=0; i<discovered.length; ++i) {
    discovered[i] = false;
    processed[i] = false;
    parent[i] = -1;
  }
  discovered[startNode] = true;
  erase();
  add(currentpicture, graphPic);
  queue.draw();
  writeCode(code,5);
  ship();
  queue.enqueue(startNode);
  erase();
  add(currentpicture, graphPic);
  queue.draw();
  writeCode(code,6);
  ship();
  while (queue.noEntries>0) {
    int currentNode = queue.peek();
    processVertexEarly(currentNode, queue);
    processed[currentNode] = true;
    for(int i=0; i<graph.node[currentNode].neighbour.length; ++i) {
      int successorNode = graph.node[currentNode].neighbour[i];
      if (!processed[successorNode] || graph.directed)
	processEdge(currentNode, successorNode, discovered, processed, queue);
      if (!discovered[successorNode]) {
	//	queue.enqueue(successorNode);
	discovered[successorNode] = true;
	parent[successorNode] = currentNode;
      }
    }
    processVertexLate(currentNode,parent[currentNode],queue);
  }
}



erase();
add(currentpicture, graphPic);
writeCode(code,0);
ship();
erase();
add(currentpicture, graphPic);
int[] lines={1,2};
writeCodeH(code,lines);
ship();
erase();
highlightNode(graph,0,green);
add(currentpicture, graphPic);
int[] lines={3,4};
writeCodeH(code,lines);
ship();
erase();

bfs(graph, 0);

erase();
add(currentpicture, graphPic);
writeCode(code,7);
Queue q;
q.draw();
ship();
