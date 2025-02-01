/*
 *  Class for collecting second order statistics
 */

#ifndef __SOS__
#define __SOS__

#include <error_estimate.h>
using namespace std;

class Sos {
public:
  Sos() { zero(); }
  void zero() { aver = nvar = count = 0.0; }
  void add(double x);
  double operator+=(double x) { add(x); return(x); }
  const Sos& operator+=(const Sos& e);
  double av() const { return(aver); }
  double var() const;
  double sd() const;
  double err() const;
  double sum() const;
  operator Error() const;
  int number() const { return(int(count)); }
private:
  double aver;
  double nvar;
  double count;
};

ostream& operator<<(ostream& out, const Sos& d);

#endif
