real width=15.6cm;
size(width,10cm);



import myutil;
string[] code;
code.push("dfs(graph, node) \{");
code.push("\ \ if (\"finished\") return");
code.push("\ \ state[node] $\leftarrow$ \"discovered\"");
code.push("\ \ time $\leftarrow$ time + 1");
code.push("\ \ processVertexEarly(node)");
code.push("\ \ foreach neighbour $\in$ Neighbourhood(node) \{");
code.push("\ \ \ \ if (state[neighbour] $\neq$ \"discovered\") \{");
code.push("\ \ \ \ \ \ parent[neighbour] $\leftarrow$ node");
code.push("\ \ \ \ \ \ processEdge(node, neighbour)");
code.push("\ \ \ \ \ \ dfs(graph, neighbour)");
code.push("\ \ \ \ \} else if (state[neighbour] $\neq$ \"processed\") \{");
code.push("\ \ \ \ \ \ processEdge(node, neighbour)");
code.push("\ \ \ \ \}");
code.push("\ \ \ \ if (\"finished\") return");
code.push("\ \ \}");
code.push("\ \ processVertexLate(currentNode)");
code.push("\ \ state[currentNode] $\leftarrow$ \"processed\"");
code.push("\ \ time $\leftarrow$ time + 1");
code.push("\}");


bool isMember(int[] a, int element) {
  for(int i=0; i<a.length; ++i) {
    if (a[i]==element)
      return true;
  }
  return false;
}

void writeCode(... int[] highlight) {
  for (int i=0; i<code.length; ++i) {
    pen col = (isMember(highlight, i))? blue:black;
    label("\texttt{" + code[i] + "}", (0,12pt*(code.length-i)), E, col+fontsize(12));
  }
}
draw(box((0,0),(width,10cm)),white);
label("\textbf{DFS for undirected graphs}",(7.5cm,10cm),S);
writeCode(-1);
ship();
erase();
code[10] = "\ \ \ \ \} else if (state[neighbour] $\neq$ \"processed\" $\vee$ graph is directed) \{";
draw(box((0,0),(width,10cm)),white);
label("\textbf{DFS for directed graphs}",(7.5cm,10cm),S);
writeCode(10);
ship();
