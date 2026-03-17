size(200,0);
import myutil;

pair[] pos;

int k = 7;

for(int i=0; i<k; ++i) {
  pos.push((rand(),rand())/randMax);
  dot(pos[i], linewidth(5));
  label(string(i), pos[i], W);
}

ship();



picture citiesPic;
add(citiesPic, currentpicture);

real greedyTour(int ignoreCity, int currentCity, int cnt, int[] visited, real tourLength) {
  visited[currentCity] = cnt;
  real nextDistance = 1000;
  int next;
  for(int i=0; i<k; ++i) {
    if (i==ignoreCity)
      continue;
    if (visited[i] == -1) {
      real d = length(pos[currentCity]-pos[i]);
      if (d<nextDistance) {
	nextDistance =d;
	next = i;
      }
    }
  }
  tourLength += nextDistance;
  ++cnt;
  visited[next] = cnt;
  if (cnt==k-2) {
    return tourLength;
  }
  else
    return greedyTour(ignoreCity, next, cnt, visited, tourLength);
}


for (int addNode =0; addNode<k; ++addNode) {
  erase();
  add(citiesPic);
  dot(pos[addNode], red+linewidth(5));
  ship();

       
  real bestTourLength = 100000;
  int bestTour = 0;
  for(int i=0; i<k; ++i) {
    if (i==addNode)
      continue;
    int[] visited = array(k, -1);
    real dist = greedyTour(addNode, i, 0, visited, 0.0);
    if (dist < bestTourLength) {
      bestTourLength = dist;
      bestTour = i;
    }
  }

  int[] visited = array(10, -1);
  greedyTour(addNode, bestTour, 0, visited, 0.0);
  int[] tour = new int[k-1];
  for(int i=0; i<k; ++i) {
    if (i==addNode)
      continue;
    tour[visited[i]] = i;
  }
  for(int i=1; i<k-1; ++i) {
    draw(pos[tour[i-1]]--pos[tour[i]]);
  }
  ship();
  if (length(pos[addNode]-pos[tour[0]])<length(pos[addNode]-pos[tour[k-2]]))
    draw(pos[addNode]--pos[tour[0]]);
  else
    draw(pos[addNode]--pos[tour[k-2]]);
  
  ship();
}
