import myutil;
size(90,120);

draw(box((-6,-0.1), (1.1, 9.1)), white);
draw((-1,9)--(-1,0)--(1,0)--(1,9));

for(int i=1; i<9; ++i) {
  draw((-1,i)--(1,i));
}

int top = 3;

int[] stack = new int[10];

for(int i=0; i<=top; ++i) {
  int r = floor(20.0*rand()/randMax);
  label(string(r), (0, i+0.5));
  stack[i] = r;
}

shipout("stack");
picture bg = new picture;

bg.add(currentpicture);

int r = floor(20.0*rand()/randMax);
++top;
stack[top] = r;

label("$\texttt{push(" + string(r) + ")}$", (-4,top+0.5), blue);
label(string(r), (0, top+0.5));

draw((-2,top+0.5)--(-0.5, top+0.5), red, Arrow);

shipout("stack_push");

erase();
add(bg);
label(string(r), (0, top+0.5));

draw((-0.5, top+0.5)--(-4,top+0.5), red, Arrow);
label(string(r), (-4,top+0.5), W);
label("$\texttt{top()}$", (-2.5,top+0.5), N, blue);

shipout("stack_top");

erase();
add(bg);
label(string(r), (0, top+0.5));
draw((-0.5, top+0.5)--(-4,top+0.5), red, Arrow);
label(string(r), (-4,top+0.5), W);
label("$\texttt{pop()}$", (-2.5,top+0.5), N, blue);

shipout("stack_pop");


erase();
add(bg);
draw((-0.5, top+0.5)--(-4,top+0.5), red, Arrow);
label(string(r), (-4,top+0.5), W);
label("$\texttt{pop()}$", (-2.5,top+0.5), N, blue);

shipout("stack_popped");
erase();
add(bg);
draw((-0.5, top+0.5)--(-4,top+0.5), red, Arrow);
label("void", (-4,top+0.5), W);
label("$\texttt{pop()}$", (-2.5,top+0.5), N, blue);

shipout("stack_popped_cpp");
erase();
add(bg);
