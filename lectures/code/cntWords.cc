#include <iostream>
#include <fstream>
#include <map>
#include <vector>
#include <string>
#include <algorithm> 
using namespace std;

int main(int argc, char** argv) {
  ifstream in(argv[1]);
  map<string, int> words;

  string s;
  while(in >> s) {
    ++words[s];
  }
  vector<pair<string,int> > pairs;

  copy(words.begin(), words.end(), back_inserter(pairs));
 
  sort(pairs.begin(), pairs.end(), [](auto& a, auto&b){return a.second>b.second;});
  for(auto w=pairs.begin(); w!=pairs.end(); ++w) {
    cout << w->first << " occurs " << w->second << " times\n";
  }
  
}
