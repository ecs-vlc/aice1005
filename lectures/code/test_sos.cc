#include <math.h>
#include <iostream>
#include "sos.h"
#include <random>
#include <iomanip>
#include <cstdlib>

int main(int argc, char* argv[]) {
    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <number_of_iterations>" << std::endl;
        return 1;
    }
    
    int num_iterations = std::atoi(argv[1]);
    if (num_iterations <= 0) {
        std::cerr << "Please provide a positive integer for the number of iterations." << std::endl;
        return 1;
    }

    std::random_device rd;  // Seed generator
    std::mt19937 gen(rd()); // Mersenne Twister engine
    std::normal_distribution<double> dist(5.6, 2.0);

    Sos sos;
    for (int i = 0; i < num_iterations; ++i) { // Generate 10 numbers
        sos += dist(gen);
    }

    std::cout << sos << endl;

    return 0;
}

