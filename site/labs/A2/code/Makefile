CXX = g++
CXXFLAGS = -Wall -g

# Output executable
TARGET = test_ring

# Source files
SRCS = test_ring.cc

# Object files
OBJS = $(SRCS:.cc=.o)

# Default target
all: $(TARGET)

# Link the executable
$(TARGET): $(OBJS) my_ring.h
	$(CXX) $(CXXFLAGS) -o $@ $(OBJS)

# Compile source files into object files
%.o: %.cc %.h my_ring.h
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Clean up build files
clean:
	rm -f $(OBJS) $(TARGET)


run: test_ring
	./test_ring
