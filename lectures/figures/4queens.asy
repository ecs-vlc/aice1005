size(500,0);
import myutil;
usepackage('skak');

void board(pair pos) {
  pos -= (2,0);
  for(int i=0; i<5; ++i) {
    draw(pos+(i,0)--pos+(i,-4));
    draw(pos+(0,-i)--pos+(4,-i));
  }
}

void row(pair pos, int i) {
  fill(shift(pos-(2,0))*((0,-i)--(4,-i)--(4,-i-1)--(0,-i-1)--cycle), pink);
  board(pos);
}

void queens(pair pos ... pair[] q) {
  pos += (-1.5, -0.5);
  for (int i=0; i<q.length; ++i) {
    label("\symqueen", pos+(q[i].x, -q[i].y));
  }
}

pair bottom(pair pos, int i) {
  return pos + (-1.5+i,-4);
}

void next(pair p0, int i, pair p1) {
  draw(bottom(p0, i)--p1, Arrow);
}

void bt(pair pos, int i, int dx) {
  next(pos, i, pos+(dx,-6));
  pair p1 = pos+(dx,-6)+0.4*unit((dx,-6));
  label(string(i+1), p1);
  label("$\times$", p1-(0,0.1), S);
}

draw(box((-17,0.1),(16,-28.1)), white);
pair pos0 = (0,0);
board(pos0);
ship();
row(pos0, 0);
ship();
pair pos1 = (-6,-6);
next(pos0, 0, pos1);
board(pos1);
queens(pos1, (0,0));
ship();
row(pos1,1);
ship();
bt(pos1, 0, -9);
ship();
bt(pos1, 1, -7);
ship();
pair pos2 = pos1 - (4, 6);
row(pos2, 2);
next(pos1, 2, pos2);
queens(pos2, (0,0), (2,1));
ship();
bt(pos2, 0, -2);
bt(pos2, 1, -1);
bt(pos2, 2, 1);
bt(pos2, 3, 2);
ship();
pair pos3 = pos1 + (3, -6);
row(pos3, 2);
next(pos1, 3, pos3);
queens(pos3, (0,0), (3,1));
ship();
bt(pos3, 0, -3);
ship();
pair pos4 = pos3 + (0, -6);
row(pos4, 3);
next(pos3, 1, pos4);
queens(pos4, (0,0), (3,1), (1,2));
ship();
bt(pos4, 0, -2);
bt(pos4, 1, -1);
bt(pos4, 2, 1);
bt(pos4, 3, 2);
ship();
bt(pos3, 2, 3);
bt(pos3, 3, 5);
ship();
pair pos5 = pos0 + (6, -6);
row(pos5, 1);
next(pos0, 1, pos5);
queens(pos5, (1,0));
ship();
bt(pos5, 0, -2);
bt(pos5, 1, -1);
bt(pos5, 2, 1);
ship();
pair pos6 = pos5 + (6, -6);
row(pos6, 2);
next(pos5, 3, pos6);
queens(pos6, (1,0), (3,1));
ship();
pair pos7 = pos6 + (-4, -6);
row(pos7, 3);
next(pos6, 0, pos7);
queens(pos7, (1,0), (3,1), (0,2));
ship();
bt(pos7, 0, -2);
bt(pos7, 1, -1);
ship();
pair pos8 = pos7 + (4, -6);
board(pos8);
next(pos7, 2, pos8);
queens(pos8, (1,0), (3,1), (0,2), (2,3));
label("Solution", pos8-(2,2), W, blue);
ship();
