size(500, 0);
import myutil;

pair bmin = (-0.2, -0.2);
pair bmax = (2,1);
pair bmid = 0.5*(bmin+bmax);

draw(box(bmin,bmax), linewidth(10)+white);
string equalityString(int equ) {
  if (equ<0)
    return "\geq ";
  if (equ==0)
    return "=";
  return "\leq ";
}

string toString(real a) {
  if (a==1)
    return "";
  if (a==-1)
    return "-";
  else
    return string(a,1);
}

picture topLayer = new picture;

void constraint(real a1, real a2, real b, int equ) {
  string equalityStr[] = {"\leq", "=", "\geq"};
  if (a1==0.0) {
    path p = (bmin.x,b/a2)--(bmax.x,b/a2);
    draw(p);
    align al = S;
    if (equ<0) {
      fill(p--(bmax.x,bmin.y)--(bmin.x,bmin.y)--cycle, lightgray);
      al = N;
    }
    if (equ>0) {
      fill(p--(bmax.x,bmax.y)--(bmin.y,bmax.y)--cycle, lightgray);
    }
    draw(topLayer, p);
    string str = "$" + toString(a2) + "x_2";
    str += equalityString(equ) + string(b,1) + "$";
    label(topLayer, str, (bmid.x, b/a2), al);
    return;
  }
  if (a2==0.0) {
    path p = (b/a1,bmin.y)--(b/a1,bmax.y);
    align al = E;
    if (equ<0) {
      fill(p--(bmin.x,bmax.y)--(bmin.x,bmin.y)--cycle, lightgray);
    }
    if (equ>0) {
      fill(p--(bmax.x,bmax.y)--(bmax.x,bmin.y)--cycle, lightgray);
      al = W;
    }
    draw(topLayer, p);
    string str = "$" + toString(a1) + "x_1";
    str += equalityString(equ) + string(b,1) + "$";
    label(topLayer, rotate(90)*Label(str), (b/a1, bmid.y), al);
    return;
  }
  pair[] pos = new pair[2];
  int i = 0;
  real x = (b-a2*bmin.y)/a1;
  if (x>bmin.x && x<bmax.x) {
    pos[i] = (x,bmin.y);
    ++i;
  }
  real y = (b-a1*bmax.x)/a2;
  if (y>bmin.y && y<bmax.y) {
    pos[i] = (bmax.x,y);
    ++i;
  }
   real y = (b-a1*bmin.x)/a2;
  if (y>bmin.y && y<bmax.y) {
    pos[i] = (bmin.x,y);
    ++i;
  }
  real x = (b-a2*bmax.y)/a1;
  if (x>bmin.x && x<bmax.x) {
    pos[i] = (x,bmax.y);
    ++i;
  }
 if (i!=2) {
    write('Constraint outside bounding box');
    write(i);
    return;
  }
  write(pos[0],pos[1]);
  guide g = pos[1]--pos[0];
  draw(topLayer, g);
  real angle = aTan((pos[1].y-pos[0].y)/(pos[1].x-pos[0].x));
  string str = "$" + toString(a1) + "x_1 +" + toString(a2) + "x_2";
  str += equalityString(equ) + string(b,1) + "$";
  pair mid = 0.5*(pos[0]+pos[1]);
  pair d = -0.05*unit(pos[0]-pos[1]);
  d = (d.y,-d.x);
  mid += d;
  if (equ>0) {
    if (a1*bmax.x+a2*bmin.y>b)
      g= g--(bmax.x, bmin.y);
    if (a1*bmax.x+a2*bmax.y>b)
      g= g--(bmax.x, bmax.y);
    if (a1*bmin.x+a2*bmax.y>b)
      g= g--(bmin.x, bmax.y);
    if (a1*bmin.x+a2*bmin.y>b)
      g= g--(bmin.x, bmin.y);
    fill(g--cycle, lightgray);
    if (a1*mid.x+a2*mid.y>b)
      mid -= 2*d;
  }
  if (equ<0) {
    if (a1*bmin.x+a2*bmin.y<b)
      g= g--(bmin.x, bmin.y);
    if (a1*bmin.x+a2*bmax.y<b)
      g= g--(bmin.x, bmax.y);
    if (a1*bmax.x+a2*bmax.y<b)
      g= g--(bmax.x, bmax.y);
    if (a1*bmax.x+a2*bmin.y<b)
      g= g--(bmax.x, bmin.y);
    fill(g--cycle, lightgray);
    if (a1*mid.x+a2*mid.y<b)
      mid -= 2*d;
  }
  label(rotate(angle)*Label(str), mid);
}

constraint(0, 1, 0, -1);
constraint(1, 0, 0, -1);
constraint(2, 3, 4, 1);
constraint(-1, 5, 4, 1);
constraint(1,1,0.2,-1);
add(topLayer);

ship();
draw((0,0)--(0.2,0.6), Arrow);
label("$c = x_1 + 3 x_2$", 1.1*(0.2,0.6));

ship();
import contour;

real obj(real x1, real x2) {return x1 + 3*x2;}

int n=10;
real[] c=new real[n];
for(int i=0; i < n; ++i)
  c[i]=0.5*(i-1);
pen[] p=sequence(new pen(int i) {
    return dashed+fontsize(10pt)+brown;
  },c.length);
Label[] Labels=sequence(new Label(int i) {
return Label(c[i] != 0 ? (string) c[i] : "",Relative(unitrand()),(0,0),
UnFill(1bp));
},c.length);
draw(Labels,contour(obj,bmin,bmax,c),p);
ship();

fill(circle((8,12)/13, 0.01), blue);

label("$\max c$", (8,12)/13, N, blue);
ship();
fill(circle((0.2,0), 0.01), red);
label("$\min c$", (0.2,0), S, red);
ship();

erase();
erase(topLayer);
draw(box(bmin,bmax), linewidth(10)+white);
constraint(0, 1, 0, -1);
constraint(1, 0, 0, -1);
constraint(1, -6, -0.3, 1);
constraint(-1, 3, 2, 1);
//constraint(1,1,0.2,-1);
add(topLayer);

shipout("unboundedSolution-0");
draw((0,0)--0.3*(2,1), Arrow);
label("$c = 2*x_1 + x_2$", 1.1*(0.6,0.3));
real obj(real x1, real x2) {return 2*x1 + x2;}

int n=12;
real[] c=new real[n];
for(int i=0; i < n; ++i)
  c[i]=0.5*(i-1);
pen[] p=sequence(new pen(int i) {
    return dashed+fontsize(10pt)+brown;
  },c.length);
Label[] Labels=sequence(new Label(int i) {
return Label(c[i] != 0 ? (string) c[i] : "",Relative(unitrand()),(0,0),
UnFill(1bp));
},c.length);
draw(Labels,contour(obj,bmin,bmax,c),p);
shipout("unboundedSolution-1");


erase();
erase(topLayer);
draw(box(bmin,bmax), linewidth(15)+white);
constraint(0, 1, 0, -1);
constraint(1, 0, 0, -1);
constraint(1, -6, -0.3, 1);
constraint(-1, 3, 2, 1);
constraint(2, 1, 3, 1);
//constraint(1,1,0.2,-1);
add(topLayer);

shipout("multipleSolutions-0");
draw((0,0)--0.3*(2,1), Arrow);
label("$c = 2*x_1 + x_2$", 1.1*(0.6,0.3));
real obj(real x1, real x2) {return 2*x1 + x2;}

int n=12;
real[] c=new real[n];
for(int i=0; i < n; ++i)
  c[i]=0.5*(i-1);
pen[] p=sequence(new pen(int i) {
    return dashed+fontsize(10pt)+brown;
  },c.length);
Label[] Labels=sequence(new Label(int i) {
return Label(c[i] != 0 ? (string) c[i] : "",Relative(unitrand()),(0,0),
UnFill(1bp));
},c.length);
draw(Labels,contour(obj,bmin,bmax,c),p);
real x2 = 3.6/13;
draw((1,1)--(1.5-0.5*x2,x2), red+linewidth(2));
shipout("multipleSolutions-1");

erase();
erase(topLayer);


constraint(0, 1, 0, -1);
constraint(1, 0, 0, -1);
constraint(2, 3, 4, 1);
constraint(-1, 5, 4, 1);
add(topLayer);

shipout("lpImprove-0");
draw((0,0)--(0.2,0.6), Arrow);
label("$c = x_1 + 3 x_2$", 1.1*(0.2,0.6));


shipout("lpImprove-1");
import contour;

real obj(real x1, real x2) {return x1 + 3*x2;}

int n=10;
real[] c=new real[n];
for(int i=0; i < n; ++i)
  c[i]=0.5*(i-1);
pen[] p=sequence(new pen(int i) {
    return dashed+fontsize(10pt)+brown;
  },c.length);
Label[] Labels=sequence(new Label(int i) {
return Label(c[i] != 0 ? (string) c[i] : "",Relative(unitrand()),(0,0),
UnFill(1bp));
},c.length);
draw(Labels,contour(obj,bmin,bmax,c),p);
shipout("lpImprove-2");

pair x = (1,0.5);
dot(x, blue+linewidth(5));
shipout("lpImprove-3");

pair x1 = x + (1,3)/22;
dot(x1, blue+linewidth(5));
draw(x--x1, blue);
shipout("lpImprove-4");

fill(circle((8,12)/13, 0.01), blue);
draw(x1--(8,12)/13, blue);
shipout("lpImprove-5");
