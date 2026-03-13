settings.outformat="png";

size(400,0);

string[] items = {"w", "x", "y"};

for(int i=0; i<=10; ++i) {
  draw(box((i-0.5,-0.5),(i+0.5,0.5)));
  if (i>=3 && i<6) {
    label("\Huge " + items[i-3], (i,0));
  }
}

label("\Huge \texttt{dequeue()}", (2,1), NW);
label("\Huge \texttt{enqueue(z)}", (7,1), NE);
draw((3,0.55)..(2.8, 1.2)..(2.01,1.4), Arrow);
draw((6.9, 1.4)..(6.2, 1.2)..(6, 0.55), Arrow);

label("\Huge \texttt{front}", (3,-1), S, red);
draw((3,-1)--(3,-0.5), red, Arrow);
