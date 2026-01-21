#include <iostream>
#include <fstream>
#include <vector>
#include <math.h>
#include <cstdlib>
using namespace std;


class Graph {
public:
  Graph(int n_, double p_): n(n_), p(p_), neighbours(n_) {
    long r = long(p*RAND_MAX);
    for(int i=1; i<n; ++i) {
      for(int j=0; j<i; ++j) {
	if (rand()<r) {
	  neighbours[i].push_back(j);
	}
      }
    }
  }

  pair<int, vector<int>> best_colouring(int num_colours) {
    vector<int> partial_cost(n,0);
    vector<int> colouring(n, -1);
    colouring[0] = 0;
    vector<int> best_so_far(n);
    int best_cost = n+1;
    int current = 1;
    while (current>0) {
      if (colouring[current]<num_colours-1) {
	++colouring[current];
	partial_cost[current] = partial_cost[current-1];
	for(int neigh: neighbours[current]) {
	  if (colouring[neigh] == colouring[current])
	    ++partial_cost[current];
	}
	if (current==n-1 && partial_cost[current]<best_cost) {
	  best_cost = partial_cost[current];
	  best_so_far = colouring;
	}
	if (current<n-1)
	  ++current;
      } else {
	colouring[current] = -1;
	--current;
      }
    }
    return pair<int, vector<int>>(best_cost, best_so_far);
  }

  void print(const vector<int>& colouring, int cost) {
    vector<pair<double, double> > location(n);
    for(int i=0; i<n; ++i) {
      location[i].first = cos(2*M_PI*i/n);
      location[i].second = sin(2*M_PI*i/n);
    }


    ofstream outFile("./colouring.py");
    outFile << "import matplotlib.pyplot as plt\n";
    outFile << "import matplotlib.patches as patches\n";
    outFile << "fig, ax = plt.subplots()\n";
    outFile << "plt.title(\"cost=" << cost << "\")\n";

    for(int i=1; i<n; ++i) {
      for(int neigh: neighbours[i]) {
	string col = (colouring[i]==colouring[neigh])? "red": "black";
	outFile << "plt.plot([" << location[i].first << ","
		<< location[neigh].first << "], ["
		<< location[i].second << ","
		<< location[neigh].second << "], \"" << col <<"\", lw=2)\n";
      }
    }
    vector<string> colours = {"red", "yellow", "blue", "green",
			      "cyan", "magenta", "orange", "brown"};
    for(int i=0; i<n; ++i) {
      outFile << "ax.add_patch( patches.Circle( (" << location[i].first
	      << "," << location[i].second << "), 0.08, edgecolor=\"black\", "
	      << "facecolor=\"" << colours[colouring[i]]
	      << "\", fill=True, zorder=5))\n";
    }
    outFile << "ax.axis('equal')\nplt.axis('off')\nplt.show()\n";
    outFile.close();
    int returnCode = system("python colouring.py");
    if (returnCode!=0) {
      cerr << "python colouring.py command failed\n";
      cerr << "Try running in terminal\n";
    }
  }
  
private:
  int n;
  double p;
  vector<vector<int> > neighbours;
};



using namespace std;

int main(int argc, char* argv[]) {
    if (argc != 3) {
        cout << "Usage: " << argv[0] << " <number_of_vertices> <number_of_colours>" << endl;
        return 1;
    }

    int vertices = atoi(argv[1]);
    int colours = atoi(argv[2]);
    
    // Validate input
    if (vertices < 2 || vertices > 30) {
        cout << "Invalid input! Number of vertices must be between 2 and 30." << endl;
        return 1;
    }
    
    if (colours < 2 || colours > 10) {
        cout << "Invalid input! Number of colours must be between 2 and 30." << endl;
        return 1;
    }
    
    Graph graph(vertices, 0.5);

    pair<int, vector<int> > colouring(graph.best_colouring(colours));

    graph.print(colouring.second, colouring.first);
    
    return 0;
}
