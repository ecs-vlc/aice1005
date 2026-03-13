import myutil;
size(500,0);

path bb = box((0,-2.4), ((34,2.5)));

draw(bb, white);

string[] sub = {"i-1", "i", "i+1", "i+2"};
for(int i=0; i<4; ++i) {
  draw(box((8i+2,-1), (8i+8,1)), gray+linewidth(1));
  draw(box((8i+2.3,-0.7), (8i+3.7, 0.7)));
  draw(box((8i+4.3,-0.7), (8i+5.7, 0.7)));
  draw(box((8i+6.3,-0.7), (8i+7.7, 0.7)));
  dot((8i+3,0), linewidth(5));
  dot((8i+7,0), linewidth(5));
  draw((8i+3,0)..(8i+1.5,-0.2)..(8i,0), Arrow);
  draw((8i+7,0)..(8i+8.5,0.2)..(8i+10,0), Arrow);
  label("$\ell_{"+sub[i]+"}$", (8i+5));
}

draw((0,0.14)..(0.5,0.2)..(2,0), Arrow);
draw((34,-0.14)..(33.5,-0.2)..(32,0), Arrow);

picture ll = new picture;
ll.add(currentpicture);
ship();

draw(yscale(0.5)*circle((13,0), 4.25), red+linewidth(1.5));
label("\texttt{List::iterator it}", (13-3.2,1.3), NW, red);

ship();

label("\texttt{*it}=$\ell_i$", (13+3.2,1.3), NE, red);
ship();

erase();
add(ll);
ship();
draw(yscale(0.5)*circle((13,0), 4.25), red+linewidth(1.5));
label("\texttt{List::iterator it}", (13-3.2,1.3), NW, red);

ship();
label("\texttt{it++}", (13+3.2,1.3), NE, red);
ship();

ship();

erase();
add(ll);
draw(yscale(0.5)*circle((21,0), 4.25), red+linewidth(1.5));
label("\texttt{List::iterator it}", (21-3.2,1.3), NW, red);
ship();

erase();
add(ll);
ship();
draw(yscale(0.5)*circle((13,0), 4.25), red+linewidth(1.5));
label("\texttt{List::iterator it1}", (13-3.2,1.3), NW, red);


draw(yscale(0.5)*circle((21,0), 4.25), blue+linewidth(1.5));
label("\texttt{List::iterator it2}", (21+3.2,1.3), NE, blue);
ship();

label("\texttt{it1 != it2}", (17,2.5), S, UnFill);
ship();

label("$\small\rightarrow$\texttt{true}",(17,1.3), UnFill);
ship();
