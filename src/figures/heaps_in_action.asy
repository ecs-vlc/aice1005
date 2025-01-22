import myutil;
import heap;
size(250,0);
srand(3);


Heap heap = Heap();

heap.graph();
heap.list();
ship();

for(int i=0; i<7; ++i) {
  heap.push(rand()%100, true);
}

while(!heap.empty()) {
  heap.pop(true);
}
