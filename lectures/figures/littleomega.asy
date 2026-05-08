size(340,0);

int piccnt = 0;
void out()
{
  draw((-0.6,-0.5)--(3.6,-0.5)--(3.6,0.5)--(-0.6,0.5)--cycle, white);
  string fn = "littleomega-" + string(piccnt);
  piccnt += 1;
  shipout(fn);
  erase();
}

draw((-0.5,0)--(3.5,0), linewidth(1), Arrow);
draw((0,0)--(0,-0.1));
draw((1,0)--(1,-0.1));
draw((2,0)--(2,-0.1));
draw((3,0)--(3,-0.1));
label("$\Theta(1)$", (0,-0.1),S);
label("$\Theta(n)$", (1,-0.1),S);
label("$\Theta(n^2)$", (2,-0.1),S);
label("$\Theta(n^3)$", (3,-0.1),S);
draw((0.2,0)--(0.2,-0.3));
label("$\Theta(\log(n))$", (0.2,-0.3),S);
draw((0.5,0)--(0.5,-0.1));
label("$\Theta(\sqrt{n})$", (0.5,-0.1),S);
draw((1.2,0)--(1.2,-0.3));
label("$\Theta(n\log(n))$", (1.2,-0.3),S);
out();

draw((3.2,0)--(1.23,0), magenta+linewidth(1.2));
draw(circle((1.2,0),0.03), magenta+linewidth(1.2));
label("$\omega(n\,\log(n))$", (1.2,0), N, magenta);
out();

label("$n^2+3n+2$", (2,0.05), NE, red);
draw((2,0.1)--(1.2,0), red, Arrow);
out();

label("$5n\sqrt{n}+4n+2$", (1.2,0.3), NE, red);
draw((1.5,0.3)--(1.3,0.2), red, Arrow);
out();
