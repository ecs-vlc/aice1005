import myutil;
import graph;
size(400,0);


real square(real x) {return 0.2*x*x;}
real loglinear(real x) {return 0.1*x*log(3+0.5x);}
real expon(real x) {return exp(0.5*x)-1;}

draw(box((-0.01,-0.11),(2.2,1.1)), white);
draw((0,1)--(0,0)--(2,0), linewidth(1), Arrows);
label("$n$", (2,0), E);

draw(graph(square, 0, 2), blue);
draw((0,0)--(1.5,1), blue);
draw(graph(expon, 0, 2*log(2)), blue);
draw(graph(loglinear, 0, 2), blue);

ship();


label("$\Theta(n^2)$", (2, square(2)), E);
label("$\Theta(n)$", (1.5,1), NE);
label("$\Theta(\mathrm{e}^{c\,n})$", (2*log(2), 1), NW);
label("$\Theta(n\,\log(n))$", (2, loglinear(2)), N);

ship();
