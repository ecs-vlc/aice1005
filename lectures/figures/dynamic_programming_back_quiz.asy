import myutil;
size(300,0);

srand(161211);

int randCost() {
  return 1+floor(9.0*rand()/randMax);
}

struct DP {
  int n;
  int[][] upcost;
  int[][] downcost;
  int[][] cost;

  int index(int i, int j) {
    if (2*i>n)
      return floor((j+n-i)/2);
    else
      return floor((j+i)/2);
  }
  
  int Cost(int i ,int j) {
    int k = index(i,j);
    if (k<0 || k>=cost[i].length)
      return 1000000;
    return cost[i][k];
  }
  
  int upCost(int i, int j){
    int k = index(i,j);
    if (k<0 || k>=upcost[i].length)
      return -1;
    return upcost[i][k];
  }
  
  int downCost(int i, int j) {
    int k = index(i,j);
    if (2*i>=n)
      --k;
    if (k<0 || k>=downcost[i].length)
      return -1;
    return downcost[i][k];
  }
  
  static DP DP(int n) {
    DP dp = new DP;
    dp.n = n;
    for(int i=0; i<n; ++i) {
      int k = (2*i<n)? i+1: n-i;
      int[] uc = new int[k];
      int[] dc = new int[k];
      for(int j=0; j<k; ++j) {
	uc[j] = randCost();
	dc[j] = randCost();
      }
      dp.upcost.push(uc);
      dp.downcost.push(dc);
      k = (2*i<=n)? i+1: n-i+1;
      dp.cost.push(new int[k]);
    }
    dp.cost.push(new int[1]);
    dp.cost[0][0] = 0;
    for(int i=1; i<n+1; ++i) {
      int k = min(i,n-i);
      for(int j=-k; j<=k; j+=2) {
	//	write(i,j,i-1,j-1,j+1,abs(j-1));
	dp.cost[i][dp.index(i,j)] = min(dp.upCost(i-1, j-1)+dp.Cost(i-1, j-1),
			       	dp.downCost(i-1, j+1)+dp.Cost(i-1, j+1));
      }
    }
    return dp;
  }
}

from DP unravel DP;

void drawCost(int cost, pair p1, pair p2) {
  if (cost<0)
    return;
  label(string(cost), 0.5*(p1+p2), UnFill);
}

int n = 8;
DP dp = DP(n);

label("start", (-1,0), W);
label("end", (n+1), E);

for(int i=0; i<=n/2; ++i) {
  for(int k=-i; k<=i; k+=2) {
    dot((i,k));
    dot((n-i,k));
    if (2*i<n) {
      draw((i,k)--(i+1,k+1));
      draw((i,k)--(i+1,k-1));
      draw((n-i,k)--(n-1-i,k+1));
      draw((n-i,k)--(n-1-i,k-1));
    }
  }
}


for(int i=0; i<n; ++i) {
  for(int k=-min(i,n-i); k<=min(i,n-i); k+=2) {
    drawCost(dp.upCost(i,k), (i,k), (i+1,k+1));
    drawCost(dp.downCost(i,k), (i,k), (i+1,k-1));
  }
}




for(int i=0; i<=n; ++i) {
  int k = min(i,n-i);
  for(int j=-k; j<=k; j+=2) {
    label("\footnotesize " + string(dp.Cost(i,j)), (i,j), E, red);
  }
}


int j=0;
for(int i=n; i>5; --i) {
  if (dp.Cost(i-1,j-1)+dp.upCost(i-1,j-1)==dp.Cost(i,j)) {
    draw((i-1,j-1)--(i,j), red+linewidth(4));
    drawCost(dp.upCost(i-1,j-1),(i-1,j-1),(i,j));
    j = j-1;
  } else {
    draw((i-1,j+1)--(i,j), red+linewidth(4));
    drawCost(dp.downCost(i-1,j+1),(i-1,j+1),(i,j));
    j = j+1;
  }  
}

ship();

for(int i=5; i>4; --i) {
  if (dp.Cost(i-1,j-1)+dp.upCost(i-1,j-1)==dp.Cost(i,j)) {
    draw((i-1,j-1)--(i,j), red+linewidth(4));
    drawCost(dp.upCost(i-1,j-1),(i-1,j-1),(i,j));
    j = j-1;
  } else {
    draw((i-1,j+1)--(i,j), red+linewidth(4));
    drawCost(dp.downCost(i-1,j+1),(i-1,j+1),(i,j));
    j = j+1;
  }
  
}


ship();
