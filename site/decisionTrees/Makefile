LC_ALL=C
HOME=/home/apb/c++
LDLIBS   = -L$(HOME)/lib/libmyutil.a
CXXFLAGS = $(INCLUDES) -O3 -Wall 
CFLAGS=-I/home/adam/c++/include

dumbyData: dumbyData.cc
	g++ -o dumbyData dumbyData.cc   -lm -lmyutil
