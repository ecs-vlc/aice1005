size(540,0);

int N=1000;

pair randpos()
{
  return (150.0*rand()/(1.0+randMax),150.0*rand()/(1.0+randMax));
}

pair[] city = new pair[N];

for (int i=0; i<N; i+=1) {
  city[i] = randpos();
}

real[][] distance = new real[N][N];
for(int i=0; i<N; i+=1) {
  distance[i][i] = 0;
  for(int j=0; j<i; j+=1) {
    distance[i][j]=distance[j][i] = length(city[i]-city[j]);
  }
}

int picno=0;

real bound=10000.0;

struct route
{
  int[] cities;
  int size() {return cities.length;}
  int city(int i) {return cities[i];}
  static route route(route rr)
    {
      route r = new route; 
      r.cities = copy(rr.cities); 
      return r;
    }
  static route route(int[] x)
    {
      route r = new route;
      r.cities=copy(x);
      return r;
    }
};

route operator init() {return new route;}


struct edge {
  real dist;
  int city1;
  int city2;
  static edge edge(real d, int c1, int c2) {
    edge e = new edge;
    e.dist = d;
    e.city1 = c1;
    e.city2 = c2;
    return e;
  }
};

edge operator init() {return new edge;}

struct PriorityQueue {
  edge[] queue = new edge[quotient(N*(N-1),2)];
  int next = 0;
  void add(edge e) {
    queue[next] = e;
    int current = next;
    next+=1;
    int up = quotient(current-1,2);
    while(current>0 && e.dist<queue[up].dist) {
      queue[current] = queue[up];
      queue[up] = e;
      current = up;
      up = quotient(current-1,2);
    }
  }
  bool empty() {return (next>0);}
  edge pop() {
    edge top = queue[0];
    next-=1;
    queue[0] = queue[next];
    int parent = 0;
    int child = 2*parent+1;
    while (child<next) {
      if (child<next-1 && queue[child+1].dist<queue[child].dist) {
	child+=1;
      }
      if (queue[child].dist<queue[parent].dist) {
	queue[parent] = queue[child];
	queue[child] = queue[next];
      } else {
	break;
      }
      parent = child;
      child = 2*parent+1;
    }
    return top;
  }
};

PriorityQueue operator init() {return new PriorityQueue;}

real mst(route tour) {
  real total_dist = 0.0;
  real[] dist = new real[tour.size()];
  for(int i=0; i<dist.length; i+=1) {
    dist[i] = 1.0e30;
  }
  int current = tour.size()-1;
  PriorityQueue pq;
  for (int n=0; n<tour.size()-1; n+=1) {
    int current_city = tour.city(current);
    dist[current] = 0;
    for(int j; j<tour.size(); j+=1) {
      if (distance[current][j]<dist[j]) {
	dist[j] = distance[current][j];
	pq.add(edge.edge(dist[j], current, j));
      }
    }
    edge next;
    do {
      next = pq.pop();
    } while (dist[next.city2]==0);
    draw(city[next.city1]--city[next.city2]);
    total_dist += next.dist;
    current = next.city2;
  }
  return total_dist;
}


for(int i=0; i<N; i+=1) {
  draw(city[i], red+linewidth(4));
}

write(mst(route.route(sequence(0,N-1))));
