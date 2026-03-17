import myutil;
size(200,0);

int N=5;

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

picture partial_tour;

picno = 0;

void drawedge(int c1, int c2, real len)
{
  draw(partial_tour,city[c1]--city[c2], blue);
  label("length = "+string(len,5), (40,130), E);
  string fn = "greedy_" + string(picno);
  picno += 1;
  add(partial_tour);
  shipout(fn);
  erase();
}

real greedy(route unvisited)
{
  int cn = 0;
  int current = unvisited.city(cn);
  int init = current;
  unvisited.cities.delete(cn);
  real len = 0;
  while(unvisited.size()>0) {
    real mindist = 1.0e30;
    int min_n = 0;
    for(int i=0; i<unvisited.size(); i+=1) {
      real d = distance[current][unvisited.city(i)];
      if (d<mindist) {
	mindist = d;
	min_n = i;
      }
    }
    len += mindist;
    drawedge(current,unvisited.city(min_n),len);
    current = unvisited.city(min_n);
    unvisited.cities.delete(min_n);
  }
  len += distance[current][init];
  drawedge(current,init,len);
  return len;
}



draw(partial_tour, box((20,20),(145,140)),white);


for(int i=0; i<N; i+=1) {
  draw(partial_tour,city[i], red+linewidth(8));
  label(partial_tour, "\small "+string(i), city[i]+(1,0), E, red);
}

string fn = "greedy_" + string(picno) + ".eps";
picno += 1;
add(partial_tour);
shipout(fn);
erase();

bound = greedy(route.route(sequence(0,N-1)));
