size(500,0);
import myutil;


void fib(int n, pair pos) {
  label("\texttt{fib("+string(n)+")}", pos);
}

void solve(int n, int level, pair pos) {
  if (n<1)
    return;
  fib(n, pos);
  ship();
  if (n<3)
    return;
  pair pos1 = pos+(0,-3);
  draw(0.8*pos+0.2*pos1--0.2*pos+0.8*pos1, Arrow);
  solve(n-1, level+1, pos1);
  pair pos2 = pos+(1.8^(5-level),-3);
  draw(0.8*pos+0.2*pos2--0.2*pos+0.8*pos2, Arrow);
  solve(n-2, level+1, pos2);
}

dot((1.8^6-3,-13), white);
solve(6, 0, (0,0));
