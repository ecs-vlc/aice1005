import myutil;
size(200,0);
import myutil;
import heap;
size(250,0);
srand(3);


Heap heap = Heap();


int[] array = new int[12];

for(int i=0; i<array.length; ++i) {
  array[i] = rand()%100;
}


pair array_pos(int index) {
  real offset = -(array.length-1)/2;
  real y = 1.5;
  return (index+offset, y);
}

void draw_array(int[] array) {
  real u = 9;  

  draw(box(u*(array_pos(0)-(0.5,0.5)), u*(array_pos(array.length)+(-0.5,0.5))));
  for(int i=0; i<array.length; ++i) {
    draw(u*array_pos(i)+u*(0.5,-0.5)--u*array_pos(i)+u*(0.5,0.5));
    if(array[i]>0)
      label(string(array[i]), u*array_pos(i));
  }
}

heap = Heap(array.length);

real u = 9;
draw_array(array);
draw(box(u*(-9,-6.8), u*(9, 2.1)), white);
ship();

for(int i=0; i<array.length; ++i) {
  erase();
  draw(box(u*(-9,-6.8), u*(9, 2.1)), white);
  draw_array(array);
  label(string(array[i]), u*array_pos(i), red);
  heap.push(array[i]);
  heap.graph();
  ship();
}

for(int i=0; i<array.length; ++i) {
  array[i] = 0;
}

erase();
draw(box(u*(-9,-6.8), u*(9, 2.1)), white);
draw_array(array);
heap.graph();
ship();

for(int i=0; i<array.length; ++i) {
  erase();
  draw(box(u*(-9,-6.8), u*(9, 2.1)), white);
  draw_array(array);
  heap.graph();
  label(string(heap.top()), heap.pos(0), red);
  ship();
  array[i] = heap.top();
  heap.pop();
  erase();
  draw(box(u*(-9,-6.8), u*(9, 2.1)), white);
  draw_array(array);
  heap.graph();
  label(string(array[i]), u*array_pos(i), red);
  ship();
}
