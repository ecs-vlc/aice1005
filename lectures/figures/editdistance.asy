size(400,0);
import myutil;


string[] s1 = {"A", "C", "A", "A", "T", "T", "C"};
string[] s2 = {"A", "G", "C", "A", "A", "T", "C"};

for(int i=0; i<s1.length; ++i) {
  label(s1[i], (i+0.5, 0.5));
}

for(int i=0; i<s2.length; ++i) {
  label(s2[i], (-0.5, -i-0.5));
}

void mylabel(string s, pair pos) {
  fill(circle(pos, 0.13), white);
  label(s,pos);
}

real d = 0.12;
for(int i=0; i<=s1.length; ++i) {
  for(int j=0; j<=s2.length; ++j) {
    dot((i,-j),linewidth(7)+gray);
    if (i<s1.length) {
      draw((i,-j)--(i+1-d,-j), gray, Arrow);
      mylabel("1", (i+0.5,-j));
    }
    if (j<s2.length) {
      draw((i,-j)--(i,-j-1+d), gray, Arrow);
      mylabel("1", (i,-j-0.5));
    }
    if (i<s1.length && j<s2.length) {
      if (s1[i]==s2[j]) {
	draw((i,-j)--(i+1-d,-j-1+d), gray, Arrow);
	mylabel("0", (i+0.5,-j-0.5));
      }
    }
  }
}

draw(box((-2,1),(s1.length+2, -s2.length-1.3)),white);

//draw((3,-s2.length-1)--(s1.length,-s2.length-1), gray+linewidth(1.5));
//label("Closest Common String:", (0,-s2.length-1), NE);

ship();


void showcost(int c, pair pos)
{
  label(string(c), pos+(0.2,0.2), red);
}

showcost(0, (0,0));
int[][] costs = new int[s1.length+1][s2.length+1];
costs[0][0] = 0;

for(int i=1; i<=s1.length; ++i) {
  showcost(i, (i, 0));
  costs[i][0] = i;
}

for(int j=1; j<=s2.length; ++j) {
  showcost(j, (0, -j));
  costs[0][j] = j;
}

for(int i=1; i<=s1.length; ++i) {
  for(int j=1; j<=s2.length; ++j) {
    int c = (s1[i-1]==s2[j-1])? 0:100;
    costs[i][j] = min(costs[i-1][j]+1, costs[i][j-1]+1, costs[i-1][j-1]+c);
    showcost(costs[i][j], (i,-j));
  }
}

ship();

int i = s1.length;
int j = s2.length;
while ((i,j)!=(0,0)) {
  if (i>0 && costs[i-1][j]+1==costs[i][j]) {
    draw((i-1,-j)--(i,-j), green+linewidth(3), Arrow);
    --i;
  } else if (j>0 && costs[i][j-1]+1==costs[i][j]) {
    draw((i,-(j-1))--(i,-j), green+linewidth(3), Arrow);
    --j;
  } else  {
    draw((i-1,-(j-1))--(i,-j), green+linewidth(3), Arrow);
    --i;
    --j;
  }
}

ship();
