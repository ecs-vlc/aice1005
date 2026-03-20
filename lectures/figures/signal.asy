size(300,0);
settings.outformat="pdf";

include stats;

int n = 64;


real signal(int i) {
  return 5*sin(0.3*i)*exp(-0.02*(i-10)^2)+4*sin(0.5*i)*exp(-0.005*(i-50)^2);
}

void drawsignal(real[] x, pair s=(0,0), pen col=black, real w = 1
		, bool tick=true) {
  draw(s+(0,0)--s+(x.length-1,0));
  for(int i=0; i<x.length; ++i) {
    if (tick)
      draw(s+(i,0)--s+(i,-1));
    dot(s+(i, x[i]), col+linewidth(w));
  }
}

real[] x = new real[n];
for(int i=0; i<n; ++i) {
  x[i] = signal(i);
}

drawsignal(x, (0,0), black, 2);

shipout("signal_example");

real norm = 1.0/sqrt(2.0);

real[] haar(real[] x, int n) {
  int m = floor(n/2);
  real[] y = copy(x);
  for(int i=0; i<m; ++i) {
    y[i] = norm*(x[2*i] + x[2*i+1]);
    y[i+m] = norm*(x[2*i] - x[2*i+1]);
  }
  return y;
}

real[] h1 = haar(x,n);

drawsignal(h1, (0,-10), red, 2);
drawsignal(h1[0:32], (0,-10), heavygreen, 2);

label("$\bf{a}$", (16,-14), heavygreen);
label("$\bf{d}$", (48,-14), red);
shipout("haar");

real[] h2 = haar(h1,floor(n/2));
drawsignal(h2, (0,-25), red, 2);
drawsignal(h2[0:32], (0,-25), heavygreen, 2);
drawsignal(h2[0:16], (0,-25), blue, 2);
label("$\bf{a}^2$", (8,-29), blue);
label("$\bf{d}^2$", (24,-29), heavygreen);
label("$\bf{d}^1$", (48,-29), red);
shipout("haar2");

real c0 = (1+sqrt(3))/(4*sqrt(2));
real c1 = (3+sqrt(3))/(4*sqrt(2));
real c2 = (3-sqrt(3))/(4*sqrt(2));
real c3 = (1-sqrt(3))/(4*sqrt(2));

real[] daub4(real[] x, int n) {
  int m = floor(n/2);
  real[] y = copy(x);
  for(int i=0; i<m-1; ++i) {
    y[i] = c0*x[2*i] + c1*x[2*i+1] + c2*x[2*i+2] + c3*x[2i+3];
    y[i+m] = c3*x[2*i] - c2*x[2*i+1] + c1*x[2*i+2] - c0*x[2i+3];
  }
  y[m-1] = c0*x[2*m-2] + c1*x[2*m-1] + c2*x[0] + c3*x[1];
  y[2*m-1] = c3*x[2*m-2] - c2*x[2*m-1] + c1*x[0] - c0*x[1];
  return y;
}

erase();

n = 640;
real signal(int i) {
  if (i<551)
    return 50*sin(0.03*i)*exp(-0.0002*(i-100)^2)+40*sin(0.05*i)*exp(-0.00005*(i-500)^2);
  else
    return 50*sin(0.03*i)*exp(-0.0002*(i-100)^2)+40*sin(0.05*i+1)*exp(-0.00005*(i-500)^2);
}
x = new real[n];
for(int i=0; i<n; ++i) {
  x[i] = signal(i);
}

drawsignal(x, (0,0), black, 0.8, false);

real[] d1 = daub4(x,n);

pair s = (0,-150);

drawsignal(d1, s, red, 0.8, false);
drawsignal(d1[0:320], s, heavygreen, 0.8, false);

label("$\bf{a}^1$", s+(160,-40), heavygreen);
label("$\bf{d}^1$", s+(480,-40), red);

s=(0,-300);
real[] d2 = daub4(d1,floor(n/2));
drawsignal(d2, s, red, 0.8, false);
drawsignal(d2[0:320], s, heavygreen, 0.8, false);
drawsignal(d2[0:160], s, blue, 0.8, false);
label("$\bf{a}^2$", s+(80,-40), blue);
label("$\bf{d}^2$", s+(240,-40), heavygreen);
label("$\bf{d}^1$", s+(480,-40), red);

shipout("daub4");

real n1 = 1.0/(16.0*sqrt(2.0));
real r10 = sqrt(10);
real rc = sqrt(5+2*r10);
real[] c = {n1*(1+r10+rc), n1*(5+r10+3*rc), n1*(10-2*r10+2*rc),
	    n1*(10-2*r10-2*rc),  n1*(5+r10-3*rc), n1*(1+r10-rc)};

real[] daub6(real[] x, int n) {
  int m = floor(n/2);
  real[] y = copy(x);
  for(int i=0; i<m; ++i) {
    y[i] = y[i+m] = 0.0;
    real sn = 1.0;
    for(int j=0;j<6;++j) {
      y[i] += c[j]*x[(2*i+j) % n];
      y[i+m] += sn*c[5-j]*x[(2*i+j) % n];
      sn *= -1.0;
    }
  }
  return y;
}

real[] idaub6(real[] x, int n) {
  int m = floor(n/2);
  real[] y = copy(x);
  for(int i=0; i<n; ++i) {
    y[i] = 0.0;
  }
  for(int i=0; i<m; ++i) {
    real sn = 1.0;
    int offset = 0;
    for(int j=0;j<6;++j) {
      y[(2i+j) % n] += c[j]*x[i + offset];
      y[(2i+j) % n] += sn*c[5-j]*x[i+offset+m];
      sn *= -1.0;
    }
  }
  return y;
}

erase();

int picno=0;
void ship() {
  string fn = "daub6-" + string(picno);
  ++picno;
  shipout(fn);
}

real signal(int i) {
  return 50*sin(0.03*i)*exp(-0.0001*(i-100)^2)+40*sin(16*pi*i/1023)*exp(-0.00002*(i-700)^2);
}
n=1024;
x = new real[n];
for(int i=0; i<n; ++i) {
  x[i] = signal(i);
}

drawsignal(x, (0,0), black, 0.8, false);
draw(box((0,60),(1024,-490)), white);
ship();

int nT = 4;
int m = n;
for(int i=0; i<nT; ++i) {
  x = daub6(x,m);
  m = floor(m/2);
}

drawsignal(x, (0,-220), black, 0.9, false);
ship();
int cnt = 0;
real thresh = 10;
for(int i=0; i<x.length; ++i) {
  if (fabs(x[i])<thresh) {
    x[i] = 0;
  } else
    ++cnt;
}
write(cnt);
draw((0,thresh-220)--(n,thresh-220), blue);
draw((0,-thresh-220)--(n,-thresh-220), blue);
label("Keep $<6\%$ of signal values", (400,-180));
ship();

for(int i=0; i<nT; ++i) {
  m = 2*m;
  x = idaub6(x,m);
}

drawsignal(x, (0,-440), black, 0.8, false);

ship();

erase();


picno=0;
void ship() {
  string fn = "noiseReduction-" + string(picno);
  ++picno;
  shipout(fn);
}


for(int i=0; i<n; ++i) {
  x[i] = signal(i);
}

drawsignal(x, (0,0), black, 0.8, false);
draw(box((0,60),(1024,-490)), white);

ship();

erase();


for(int i=0; i<n; ++i) {
  x[i] = signal(i) + 3*Gaussrand();
}

drawsignal(x, (0,0), black, 0.8, false);
draw(box((0,60),(1024,-490)), white);
ship();

int nT = 4;
int m = n;
for(int i=0; i<nT; ++i) {
  x = daub6(x,m);
  m = floor(m/2);
}

drawsignal(x, (0,-220), black, 0.9, false);
ship();
int cnt = 0;
real thresh = 10;
for(int i=0; i<x.length; ++i) {
  if (fabs(x[i])<thresh) {
    x[i] = 0;
  } else
    ++cnt;
}
write(cnt);
draw((0,thresh-220)--(n,thresh-220), blue);
draw((0,-thresh-220)--(n,-thresh-220), blue);
label("Keep $<6\%$ of signal values", (400,-180));
ship();

for(int i=0; i<nT; ++i) {
  m = 2*m;
  x = idaub6(x,m);
}

drawsignal(x, (0,-440), black, 0.8, false);

ship();
