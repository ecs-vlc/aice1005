size(450,0);
import myutil;

srand(10);

int N = 9;
int M = 3;

real tableau[][] = new real[N-M+1][M];
string rows[] = new string[M];
string cols[] = new string[N-M];

real obj[] = new real[N-M];

int k = 0;
int l = 0;
for(int i=0; i<N; ++i) {
  if (rand()/randMax<(N-M-l)/(N-k-l)) {
    cols[l] = "x_" + string(i+1);
    ++l;
  } else {
    rows[k] = "x_" + string(i+1);
    ++k;
  }
}

int myRand() {
  int r =floor(8*rand()/randMax)+1;
  return (rand()/randMax<0.5)? r:-r;
}
    

for(int i=0; i<N-M+1; ++i) {
  obj[i] = myRand();
  for(int j=0; j<M; ++j) {
    if (i==0)
      tableau[i][j] = abs(myRand());
    else
      tableau[i][j] = myRand();
  }
}

//real[] obj = {0, 2, -4};
//real[][] tableau = {{2, 8}, {-6,3}, {1,-4}};


void drawTableau() {
  real u = 1.5;
  for(int j=0; j<N-M+1; ++j) {
    if (j>0) {
      label("$"+cols[j-1]+"$", (u*j, 2));
      draw((u*(j-0.5),2.5)--(u*(j-0.5),-M+0.5));
    } else {
      draw((u*(j-0.5),1.5)--(u*(j-0.5),-M+0.5));
    }
    label(string(obj[j],2), (u*j,1));
    for(int i=0; i<M; ++i) {
      label(string(tableau[j][i],2), (u*j,-i));
    }
  }
  for(int i=0; i<M+1; ++i) {
    if (i==0) {
      label("$f(\mathbf{x})$", (-u,1-i));
    } else {
      label("$"+rows[i-1]+"$", (-u,1-i));
    }
    draw((-1.5u,-i+0.5)--(u*(N-M+0.5),-i+0.5));
  }
  draw(box((-1.5u,-M+0.5), (u*(N-M+0.5), 1.5)));
  draw(box((0.5u, 1.5),(u*(N-M+0.5), 2.5)));
  draw((-1.5u,1.5)--(u*(N-M+0.5),1.5), linewidth(1.5));
  draw((-1.5u,0.5)--(u*(N-M+0.5),0.5), linewidth(1.5));
  draw((-0.5u,1.5)--(-0.5u,-M+0.5), linewidth(1.5));
}

string[] expressProblem() {
  string eqn[];
  string str = "$\displaystyle \max_{\mathbf{x}} \; f(\mathbf{x}) = ";
  bool start = false;
  if (obj[0] != 0) {
    str += string(obj[0],2);
    start = true;
  }
  for(int i=1; i<obj.length; ++i) {
    if (obj[i]==0)
      continue;
    if (start) {
      str += (obj[i]>0)? " + " : " - ";
    }
    if (abs(obj[i])!=1)
      str += string(abs(obj[i]),2);
    str +=  cols[i-1];
    start = true;
  }
  str += "$";
  eqn.push(str);
  for(int i=0; i<M; ++i) {
    string str = "$" + rows[i] + " = ";
    bool start = false;
    for(int j=0; j<N-M+1; ++j) {
      if (tableau[j][i]==0)
	continue;
      if (start) {
	str += (tableau[j][i]>0)? " + " : " - ";
      }
      if (abs(tableau[j][i])!=1)
	str += string(abs(tableau[j][i]),2);
      if (j>0)
	str +=  cols[j-1];
      start = true;
    }
    str += "$";
    eqn.push(str);
  }
  return eqn;
}


void writeProblem() {
  string str = "$\displaystyle \max_{\mathbf{x}} \; f(\mathbf{x}) = ";
  bool start = false;
  if (obj[0] != 0) {
    str += string(obj[0],2);
    start = true;
  }
  for(int i=1; i<obj.length; ++i) {
    if (obj[i]==0)
      continue;
    if (start) {
      str += (obj[i]>0)? " + " : " - ";
    }
    if (abs(obj[i])!=1)
      str += string(abs(obj[i]),2);
    str +=  cols[i-1];
    start = true;
  }
  str += "$";
  label(str, (-1, 5+M*0.7), E);
  label("where",  (-1, 5+(M-1)*0.7), E);
  for(int i=0; i<M; ++i) {
    string str = "$" + rows[i] + " = ";
    bool start = false;
    for(int j=0; j<N-M+1; ++j) {
      if (tableau[j][i]==0)
	continue;
      if (start) {
	str += (tableau[j][i]>0)? " + " : " - ";
      }
      if (j==0 || abs(tableau[j][i])!=1)
	str += string(abs(tableau[j][i]),2);
      if (j>0)
	str +=  cols[j-1];
      start = true;
    }
    str += "\geq 0$";
    label(str, (-1, 5+(M-2-i)*0.7), E);
  }
  str = "$";
  for(int i=0; i<N-M; ++i)
    str += cols[i] + " = ";
  str += "0$";
  label(str, (-1, 5+(M-2-M)*0.7), E);
  path bb = box((-2.25,-M+0.5), ((N-M+0.5)*1.5+6, 8));
  draw(bb, white+linewidth(10));
}
    
void showRow(int i) {
  real u = 1.5;
  fill(box((-1.5u, -i-0.5), ((N-M+0.5)*u, -i+0.5)), yellow);
}

void showCol(int i) {
  real u = 1.5;
  fill(box(((-0.5+i)*u, 2.5), ((0.5+i)*u, -M+0.5)), yellow);
}

void showRowCol(int i, int j) {
  showRow(i);
  showCol(j);
  real u = 1.5;
  fill(box(((-0.5+j)*u, -0.5-i), ((0.5+j)*u, 0.5-i)), orange);
  drawTableau();
}

struct RowCol {
  int row;
  int col;
  real value;
  real improvement;
};

RowCol findMax(bool show) {
  RowCol result = new RowCol;
  result.row = -1;
  result.improvement = obj[0];
  for(int i=0; i<cols.length; ++i) {
    if (show) {
      erase();
      writeProblem();
      showRowCol(-1,i+1);
      ship();
    }
    if (obj[i+1]>0) {
      real minValue = 10000;
      int minRow = -1;
      for(int j=0; j<rows.length; ++j) {
	if (tableau[i+1][j]<0) {
	  real r = -tableau[0][j]/tableau[i+1][j];
	  if (r<minValue) {
	    minValue =r;
	    minRow = j;
	  }
	}
      }
      real improvement = obj[0]+minValue*obj[i+1];
      if (improvement > result.improvement) {
	result.improvement = improvement;
	result.col = i;
	result.row = minRow;
	result.value = minValue;
      }
      if (show) {
	erase();
	writeProblem();
	showRowCol(minRow,i+1);
	string str = "$" + cols[i] + " = " + string(minValue,2) + ",\quad ";
	str += rows[minRow]  + " = 0"  + ",\quad ";
	str += "f(\mathbf{x}) = " + string(improvement,2) + "$";
	label(str, (0,3), E, red);
	ship();
      }
    }
  }
  return result;
}

bool upDate(RowCol rc) {
  if (rc.row == -1)
    return false;
  erase();
  writeProblem();
  int i = rc.col;
  int j = rc.row;
  showRowCol(j,i+1);
  string str = "Best pivot: $" + cols[i] + " = " + string(rc.value, 2) + ",\quad ";
  str += rows[j]  + " = 0"  + ",\quad ";
  str += "f(\mathbf{x}) = " + string(rc.improvement,2) + "$";
  str += " swap $" + rows[j] + "$ with $" + cols[i] + "$";
  label(str, (0,3), E, red);
  ship();
  string oldEqn[] = expressProblem();
  string tmp = rows[j];
  rows[j] = cols[i];
  cols[i] = tmp;

  real v = -1.0/tableau[rc.col+1][rc.row];
  for (int i=0; i< cols.length+1; ++i) {
    if (i!=rc.col+1) {
      tableau[i][rc.row] *= v;
      obj[i] += obj[rc.col+1]*tableau[i][rc.row];
      for(int j=0; j<rows.length; ++j) {
	if (j == rc.row)
	  continue;
	tableau[i][j] += tableau[rc.col+1][j]*tableau[i][rc.row];
      }
    }
  }
  tableau[rc.col+1][rc.row] = -v;
  obj[rc.col+1] *= -v;
  for(int j=0; j<rows.length; ++j) {
    if (j == rc.row)
      continue;
    tableau[rc.col+1][j] *= -v;
  }
  string newEqn[] = expressProblem();
  erase();
  path bb = box((-2.25,-M+0.5), ((N-M+0.5)*1.5+6, 8));
  draw(bb, white+linewidth(10));
  real y = 7;
  str = "Swap $" + cols[i] + "$ with $" + rows[j] + "$";
  label(str, (1,y), E, red);
  y -= 0.7;
  label(oldEqn[rc.row+1], (1,y), E);
  y -= 0.7;
  label("$\Rightarrow$", (1, y), W, red);
  label(newEqn[rc.row+1], (1,y), E, blue);
  ship();
  y -= 1;
  label(oldEqn[0], (1,y), E);
  y -= 0.7;
  label("$\Rightarrow$", (1, y), W, red);
  label(newEqn[0], (1,y), E);
  ship();
  for (int r=1; r<oldEqn.length; ++r) {
    if (r == rc.row+1)
      continue;
    y -= 1;
    label(oldEqn[r], (1,y), E);
    y -= 0.7;
    label("$\Rightarrow$", (1, y), W, red);
    label(newEqn[r], (1,y), E);
  }
  ship();
  erase();
  writeProblem();
  drawTableau();
  ship();
  return true;
}

writeProblem();

ship();

drawTableau();

ship();

upDate(findMax(true));

while(upDate(findMax(false)))
  ;
label("Optimum", (1,3), red);
ship();
