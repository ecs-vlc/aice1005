/*
 *  Class for collecting second order statistics
 */

#include <iostream>
#include <math.h>
#include "sos.h"
#include "error.h"
#include <iomanip>

void printFormattedDouble(double value, int precision) {
    std::cout << std::setprecision(precision);
    
    if (value >= 0.001 && value < 1000) {
        std::cout << std::fixed << value << std::endl;
    } else {
        std::cout << std::scientific << value << std::endl;
    }
}


Sos::operator Error() const
{
  return Error(av(), err());
}

void Sos::add(double x)
{
  double delta = (x - aver)/(count+1.0);
  nvar += count*delta*(x - aver);
  aver += delta;
  count++;
}

const Sos& Sos::operator+=(const Sos& rhs)
{
  double total = count + rhs.count;
  double diff = rhs.aver-aver;
  aver += rhs.count*diff/total;
  nvar += rhs.nvar + count*rhs.count*diff*diff/total;
  count = total;

  return rhs;
}


double Sos::var() const
{
  //  assert(count>1.0);
  return (count>1.0)? nvar/(count-1.0):0.0;
}

double Sos::sd() const
{
  return sqrt(var());
}

double Sos::err() const
{
  return sqrt(var()/count);
}

double Sos::sum() const
{
  return aver*count;
}

ostream& operator<<(ostream& out, const Sos& d)
{
  double err = d.err();
  int precision = max(1, int(ceil(0.5+log10(d.av()/err))));

  out << std::setprecision(precision) << std::showpoint << d.av() << " ";
  out << std::setprecision(1) << d.err();

  return(out);
}
