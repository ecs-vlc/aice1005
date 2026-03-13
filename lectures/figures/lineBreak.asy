size(17cm,0);
import myutil;

file fin = input("paragraph.dat");
string[] text = fin;

draw(box((-10,18),(245,-65)), white);

string[] wordList;
for(int i=0; i<text.length/4; ++i) {
  wordList.append(split(text[i]));
}

int[] wordPosition = new int[text.length];
wordPosition[0] = length(wordList[0])+1;
for(int i=1; i< wordList.length; ++i) {
  wordPosition[i] = wordPosition[i-1] + length(wordList[i]) + 1;
}

int l = wordPosition[wordPosition.length-1];
fill((0,1)--(l,1)--(l,-1)--(0,-1)--cycle, blue);
for(int i=0; i<wordList.length; ++i)
  draw((wordPosition[i],-2)--(wordPosition[i],2));

ship();

picture wordlinePic = new picture;
wordlinePic.add(currentpicture);

void highlightWord(int i) {
  int w0 = (i==0)? 0:wordPosition[i-1];
  int w1 = wordPosition[i];
  fill((w0, 0)--(w1,0)--(w1,1)--(w0,1)--cycle, red);
}

void showWords(int hl) {
  for(int i=0; i<15; ++i) {
    pen col = (hl==i)? red : black;
    label(wordList[i], (2.9*wordPosition[i], -6), W, col);
  }
}

showWords(-1);
label("paragraph", (20,2), N);
ship();

for(int i=0; i<7; ++i) {
  erase();
  add(wordlinePic);
  highlightWord(i);
  showWords(i);
  ship();
}

erase();
add(wordlinePic);


void bar(int f, int m, int l, bool showCost=true) {
  fill((f,7)--(m,7)--(m,9)--(f,9)--cycle, green);
  fill((m,7)--(l,7)--(l,9)--(m,9)--cycle, red);
  if (showCost)
    label("$C_{"+string(f)+"}^{"+string(m)+"}="+string(l-m)+"$", (l,8), E);
}

int lineLength = 20;
bar(0, lineLength+1, lineLength+1, false);
draw((0,6)--(0,10));
draw((lineLength+1,6)--(lineLength+1,10));
label("line length = 20", (0, 10), NE);
ship();
erase();
add(wordlinePic);
int maxCost = 49;
int offset = -10 - maxCost;
draw((0,offset+maxCost+2)--(0,offset)--(wordPosition[wordPosition.length-1]+8, offset), Arrows);
for(int i=0; i<wordList.length; ++i)
  draw((wordPosition[i],-62)--(wordPosition[i],-58));

label(rotate(90)*Label("cost, $C_i$"), (0,offset+(maxCost+2)/2), W);
erase(wordlinePic);
wordlinePic.add(currentpicture);

ship();

pair posA = (wordPosition[8],-60);
pair posB = posA + (6,10);
draw(posB--posA, blue, Arrow);
label("$i$ is position of line break after a word", posB, E, blue);

ship();
erase();
add(wordlinePic);
posA = (0,offset+(maxCost+2)/2);
posB = posA + (20,0);
draw(posB--posA, blue, Arrow);
label("minimum partial cost up to line break at position $i$", posB, E, blue);
ship();
erase();
add(wordlinePic);

label("First line is easy", (50,-30), blue);
label("$C_i = C_0^i$", (50,-45), blue);
ship();
erase();
add(wordlinePic);


guide g;
int last = 0;
int cost[] = new int[wordList.length];
int i = 0;
for(; wordPosition[i]<=lineLength+1; ++i) {
  cost[i] = lineLength + 1 - wordPosition[i];
  bar(0, wordPosition[i], lineLength);
  int p = wordPosition[i]+2;
  g = g--(last,cost[i]+offset)--(p, cost[i]+offset);
  draw(g, red);
  last = p;
  if (i==0) {
    label("cost if word break after first word", (60,-40), blue);
    label("red area shows penalty due to line break too early", (50,8), E, blue);
  }
  ship();
  erase();
  add(wordlinePic);
}

draw(g, red);
label("For the second and subsequent lines we have a choice", (50,-30), E, blue);
label("$C_i = \min\limits_{j<i} C_j^i + C_j$", (50,-40), E, blue);
ship();
erase();
add(wordlinePic);
draw(g, red);

int secondLine = i;

for(; i<wordPosition.length; ++i) {
  cost[i] = 10000000;
  int j = i-1;
  for(; j>=0; --j) {
    int spacesLeft = lineLength + 1 - wordPosition[i] + wordPosition[j];
    if (spacesLeft<0)
      break;
    if (i<8) {
      bar(wordPosition[j], wordPosition[i], wordPosition[j]+lineLength+1);
      draw(g, red);
      if(i==secondLine & j==i-1) {
	label("$C_i = \min\limits_{j<i} C_j^i + C_j$", (50,-30), E, blue);
	int posC = wordPosition[i]+lineLength+1;
	label("$C_j^i =$ cost starting at postion $j$ ending at position $i$", (posC+30,8), E, blue);
      }
      if(i==secondLine & j==0) {
	label("$C_i = \min\limits_{j<i} C_j^i + C_j$", (50,-30), E, blue);
      }
      ship();
      erase();
      add(wordlinePic);
    }
    cost[i] = min(cost[i], cost[j] + spacesLeft);
  }
  g = g--(last,cost[i]+offset)--(wordPosition[i], cost[i]+offset);
  last = wordPosition[i];
  if (i<8) {
    draw(g, red);
    ship();
    erase();
    add(wordlinePic);
    draw(g, red);
  }
}
draw(g, red);
erase(wordlinePic);
wordlinePic.add(currentpicture);
ship();
label("Find line breaks with backward algorithm", (50,-40), E, blue, UnFill);
ship();
erase();
add(wordlinePic);

int[] lineBreak;

int current = wordPosition.length - 1;
int pos = wordPosition[current];
bar(pos-lineLength-1, pos, pos);
label("Start from lowest cost point that fits on a line", (50,-40), E, blue, UnFill);
ship();
erase();
add(wordlinePic);


int j=current-1;
int best = current;
for(;j>=0; --j) {
  int spacesLeft = lineLength + 1 - wordPosition[current] + wordPosition[j];
  if (spacesLeft<0)
    break;
  if (cost[j] < cost[best]) {
    best = j;
  }
}
current = best;



lineBreak.push(current);

for(;j>=0; --j) {
  int spacesLeft = lineLength + 1 - wordPosition[current] + wordPosition[j];
  if (cost[current]==cost[j]+spacesLeft) {
    lineBreak.push(j);
    current = j;
  }
}

picture lbPic = new picture;

for(int i= 0; i<lineBreak.length; ++i) {
  int x = wordPosition[lineBreak[i]];
  draw(lbPic,(x,15)--(x,5), Arrow);
  if (i<4) {
    if (i>0)
      bar(wordPosition[lineBreak[i-1]],
	  wordPosition[lineBreak[i]],
	  wordPosition[lineBreak[i-1]]-lineLength-1, false);
    add(lbPic);
    if(i==0) {
      label("Use standard backwards algorithm to find line break", (50,-40), E, blue, UnFill);
    }
    ship();
    erase();
    add(wordlinePic);
  }
}

add(lbPic);
ship();
