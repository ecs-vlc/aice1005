import myutil;
import heap;
size(250,0);
srand(3);



Heap heap = Heap();

for(int i=0; i<12; ++i) {
  heap.push(rand()%100);
}

heap.graph();
heap.list();
ship();
heap.push(4, true);


while(!heap.empty())
  write(heap.pop());
