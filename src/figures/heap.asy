import myutil;

struct Heap {
  int[] array;
  int count;
  
  static Heap Heap(int capacity=11) {
    Heap heap = new Heap;
    heap.array = new int[capacity];
    heap.count = 0;
    return heap;
  }

  pair pos(int index) {
    int full = 1;
    real space = 8.0;
    int level = 0;
    for(; true; ++level) {
      if (index>full-1) {
	index -= full;
	full *= 2;
	space *= 0.5;
      } else
	break;
    }
    real offset = (level==0)? 0.0: 0.5*full - 0.5;
    return 20*(space*(index-offset), -0.8*level);
  }

  pair list_pos(int i) {
    real u = 9;
    return u*(i-7, 2.5);
  }
  
  void list(bool indexes=false) {
    real u = 9;
    draw(box((-80,-40),(80,40)), white);


    draw(u*(-7.5, 2)--u*(6.5, 2));
    draw(u*(-7.5, 3)--u*(6.5, 3));
    for(int i=0; i<=14; ++i) {
      draw(u*(i-7.5, 2)--u*(i-7.5, 3));
    }
    for(int i=0; i<count; ++i) {
      label(string(array[i]), list_pos(i));
      if (indexes) {
	label("\footnotesize" +string(i), list_pos(i)-(0,0.5*u), S, blue);
      }
    }
  }
  
  void graph(bool indexes=false) {
    for(int i=1; i<count; ++i) {
      draw(pos(floor((i-1)/2))--pos(i));
    }
    for(int i=0; i<count; ++i) {
      label(string(array[i]), pos(i), UnFill);
      if (indexes) {
	label("\footnotesize " + string(i), pos(i), 2*NE, blue);
      }
    }
  }

  void highlight(int node) {
    label("\bf " +string(array[node]), pos(node), red+linewidth(1), UnFill);
    label("\bf " +string(array[node]), list_pos(node), red+linewidth(1));    
  }

  void highlight_edge(int node1, int node2, arrowbar arrow=None) {
    draw(0.9*pos(node1)+0.1*pos(node2)--0.1*pos(node1)+0.9*pos(node2), red, arrow);
  }

  void list_edge(int node1, int node2, arrowbar arrow=None) {
    pair p1 = list_pos(node1);
    pair p2 = list_pos(node2);
    draw(shift((0,4.5))*(p1..0.5*(p1+p2)+(0,8.5)..p2), red, arrow);
  }
  
  void tl_edge(int node) {
    pair p1 = pos(node)+(0,4);
    pair p2 = list_pos(node)-(0,4.5);
    draw(p1--p2, red, Arrow);
  }
  
  void push(int priority, bool show=false) {
    array[count] = priority;
    int child = count;
    ++count;
    if (show) {
      erase();
      label("push("+string(priority)+")", (-5, 0), 5W, red);
      graph();
      list();
      highlight(child);
      ship();
    }
    while (child!=0) {
      int parent = floor((child-1)/2);
      if (show) {
	erase();
	label("push("+string(priority)+")", (-5, 0), 5W, pink);
	graph();
	list();
	if (child==count-1) {
	  highlight_edge(child, parent);
	  highlight(child);
	  ship();
	}
	arrowbar arrow = (array[child]<array[parent])? Arrows: None;
	highlight_edge(child, parent, arrow);
	list_edge(child, parent, arrow);
	highlight(child);
	highlight(parent);

	ship();
      }
      if (array[parent] < array[child])
	return;
      array[child] = array[parent];
      array[parent] = priority;
      child = parent;
    }
    return;
  }


  int top() {return array[0];}

  int pop(bool show = false) {
    int value = array[0];
    if (show) {
      erase();
      label("pop()", (-5, 0), 5W, red);
      list();
      graph();
      ship();
      draw(pos(0)--pos(0)+0.8*(18,10), gray, Arrow);
      highlight_edge(count-1, 0, Arrow);
      highlight(0);
      highlight(count-1);
      label(string(value), pos(0)+(18,10), gray);
	
      ship();
    }
    
    int tmp = array[--count];
    array[0] = tmp;
    int parent = 0;
    

    int child = 2*parent + 1;
    while(child<count) {
      if (show) {
	erase();
	label("pop()", (-5, -1), 5W, pink);
	list();
	graph();
	highlight(parent);
	ship();
	highlight(child);
	highlight_edge(child, parent);
	if (child+1<count) {
	  highlight_edge(child+1, parent);
	  highlight(child+1);
	}


	ship();
      }
 
      if (child+1<count && array[child+1] < array[child])
	++child;
      if (array[child]>array[parent])
	break;
      if (show) {
	highlight_edge(child, parent, Arrows);
	ship();
      }
      array[parent] = array[child];
      array[child] = tmp;
      parent = child;
      child = 2*parent + 1;
    }
    return value;
  }

  bool empty() {return count==0;}

};

from Heap unravel Heap;
