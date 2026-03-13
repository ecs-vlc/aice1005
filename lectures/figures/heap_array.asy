import myutil;
size(200,0);
import myutil;
import heap;
size(250,0);
srand(3);



Heap heap = Heap();

for(int i=0; i<12; ++i) {
  heap.push(rand()%100);
}

heap.graph(true);
heap.list(true);
ship();

for(int i=0; i<7; ++i) {
  erase();
  heap.graph(true);
  heap.list(true);
  heap.highlight(i);
  heap.tl_edge(i);
  ship();
}

erase();
heap.graph(true);
heap.list(true);
heap.highlight(9);
ship();
heap.highlight(4);
heap.highlight_edge(9,4, Arrow);
heap.list_edge(9, 4, Arrow);
label("\small $k$", heap.list_pos(9)+(0,4.5), NE, blue);
label("\small $\lfloor (k-1)/2 \rfloor$", heap.list_pos(4)+(0,4.5), NW, blue);
ship();

erase();
heap.graph(true);
heap.list(true);
heap.highlight(2);
ship();
heap.highlight(5);
heap.highlight(6);
heap.highlight_edge(2,5, Arrow);
heap.highlight_edge(2,6, Arrow);
heap.list_edge(2, 5, Arrow);
heap.list_edge(2, 6, Arrow);
label("\small $k$", heap.list_pos(2)+(0,4.5), NW, blue);
label("\small $\{2k+1, 2k+2\}$", heap.list_pos(6)+(0,4.5), NE, blue);
ship();
