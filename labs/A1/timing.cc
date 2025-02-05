#include <iostream>
#include <vector>
#include <functional>
#include <random>
#include <chrono>
#include <cmath>
#include <numeric>
#include <utility> // For std::pair
#include <fstream>


std::pair<double, double> calculateMeanAndError(const std::vector<double>& vec) {
    if (vec.empty()) {
        throw std::invalid_argument("Vector is empty, cannot calculate mean and error.");
    }

    // Calculate the mean
    double sum = std::accumulate(vec.begin(), vec.end(), 0.0);
    double mean = sum / vec.size();

    // Calculate the standard deviation
    double variance = 0.0;
    for (const auto& val : vec) {
        variance += (val - mean) * (val - mean);
    }
    variance /= vec.size();
    double standardDeviation = std::sqrt(variance);

    // Calculate the error in the mean (standard error)
    double errorInMean = standardDeviation / std::sqrt(vec.size());

    return {mean, errorInMean};
}


double timeFunctionExecution(std::function<void(std::vector<double>&)> func, size_t n) {
    // Create a vector of n random elements
    std::vector<double> randomVector;
    randomVector.reserve(n);

    // Use a random number generator
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<> dis(0.0, 1.0);

    for (size_t i = 0; i < n; ++i) {
        randomVector.push_back(dis(gen));
    }

    // Time the function execution
    auto start = std::chrono::high_resolution_clock::now();
    func(randomVector);
    auto end = std::chrono::high_resolution_clock::now();

    // Calculate the duration in seconds
    std::chrono::duration<double> duration = end - start;
    return duration.count();
}

void insertionSort(std::vector<double>& vec) {
    for (size_t i = 1; i < vec.size(); ++i) {
        double key = vec[i];
        size_t j = i;
        while (j > 0 && vec[j - 1] > key) {
            vec[j] = vec[j - 1];
            --j;
        }
        vec[j] = key;
    }
}



int main() {
    // File name
    std::string filename = "insertionSort.dat";

    // Create an ofstream object
    std::ofstream outFile(filename);
    outFile << "n,t,dt\n";

    for(size_t n = 10; n<50001; n*=2) {
      std::vector<double> runtime;
      unsigned repeats = (n<2000)? 100:50;
      for(unsigned i=0; i<repeats; ++i) {
	runtime.push_back(timeFunctionExecution(insertionSort, n));
      }
      auto [mean, error] = calculateMeanAndError(runtime);
      std::cout << "------------------------\n";
      std::cout << "n: " << n << std::endl;
      std::cout << "Mean: " << mean << std::endl;
      std::cout << "Error in Mean: " << error << std::endl;
      outFile << n << "," << mean << "," << error << "\n";
    }

    return 0;
}
