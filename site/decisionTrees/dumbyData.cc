#include <iostream>
#include <fstream>
#include <random>
#include <vector>
#include "sos.h"
using namespace std;

double uniform() {
  std::random_device                  rand_dev;
  std::mt19937                        generator(rand_dev());
  std::uniform_real_distribution<double>    distr(0.0, 1.0);
  return distr(generator);
}

class classStats {
 private:
  vector<double> prob;
  int id;
  
 public:
  classStats(unsigned id_, unsigned num_features): prob(num_features), id(id_) {
    for(unsigned i=0; i<prob.size(); ++i) {
      prob[i] = 0.6*uniform()+0.2;
    }
  }

  double operator[](unsigned i) const {return prob[i];}
  
  vector<int> rand_sample() {
    vector<int> sample(prob.size()+1);
    for(unsigned i=0; i<prob.size(); ++i) {
      sample[i] = (uniform() < prob[i])? 1:0;
    }
    sample[prob.size()] = id;
    return sample;
  }
};

class Model {
private:
  vector<classStats> classes;
  std::mt19937 gen;
  std::uniform_int_distribution<int> rand_class;

public:
  Model(unsigned num_classes, unsigned num_features) {
    std::random_device rd;
    gen.seed(rd());
    rand_class = std::uniform_int_distribution<int>(0, num_classes-1);
    for(unsigned id=0; id<num_classes; ++id) {
      classes.push_back(classStats(id, num_features));
    }
  }

  vector<int> sample() {
    return classes[rand_class(gen)].rand_sample();
  }

  const classStats& operator[](unsigned i) {return classes[i];}
};

int main() {
  int num_classes = 3;
  int num_features = 10;
  int num_samples = 1000;
  
  Model model(num_classes, num_features);

  vector<string> data_filename {"training.dat", "testing.dat"};

  for (string fn: data_filename) {
  
    std::ofstream outFile(fn);
    
    vector<vector<Sos>> means(num_classes);
    for(unsigned i=0; i<means.size(); ++i) {
      means[i] = vector<Sos>(num_features);
    }
    for(unsigned i=0; i<num_samples; ++i) {
      vector<int> sample = model.sample();
      int class_id = sample[num_features];
      for(int j=0; j<num_features; ++j) {
	outFile << sample[j] << " ";
	means[class_id][j] += sample[j];
      }
      outFile << class_id << endl;
    }
    outFile.close();

    for(unsigned i=0; i<means.size(); ++i) {
      cout << "class " << i << endl;
      const classStats& cs = model[i]; 
      for(unsigned j=0; j<num_features; ++j) {
	cout << cs[j] << " ";
      }
      cout << endl;
      for(unsigned j=0; j<num_features; ++j) {
	cout << means[i][j].av() << " ";
      }
      cout << endl;
    }

  }

  
  return 0;
}
