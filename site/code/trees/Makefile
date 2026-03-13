CXX = g++
CXXFLAGS = -Wall -std=c++17

# Target executable
TARGET = binary_tree_driver

# Source files
SRCS = binary_tree_driver.cc

# Object files
OBJS = $(SRCS:.cc=.o)

# Default target
all: $(TARGET) run

# Build the executable
$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(OBJS)

# Compile source files into object files
%.o: %.cc binary_tree.h
	$(CXX) $(CXXFLAGS) -c $< -o $@

run: binary_tree_driver
	./binary_tree_driver

# Clean up build files
clean:
	rm -f $(OBJS) $(TARGET)
