LC_ALL=C
HOME=/home/apb/c++
LDLIBS   = -L$(HOME)/lib/libmyutil.a
CXXFLAGS = $(INCLUDES) -O3 -Wall 
CFLAGS=-I/home/adam/c++/include

all: unixSort unixSortDS cntWords stack reverse linkedList binaryTree priority_queue test_sos fastSet disjointedSet huffman

unixSort: unixSort.cc
	g++ unixSort.cc -o unixSort

unixSortDS: unixSortDS.cc
	g++ unixSortDS.cc -o unixSortDS

cntWords: cntWords.cc
	g++ cntWords.cc -o cntWords

stack: stack.h stack.cc
	g++ stack.cc -o stack

reverse: reverse.cc
	g++ reverse.cc -o reverse

linkedList: linkedList.cc mylist.h
	g++ linkedList.cc -o linkedList
	./linkedList

binaryTree: binary_tree_driver.cc binary_tree.h
	g++ binary_tree_driver.cc -o binaryTree
	./binaryTree

priority_queue: priority_queue.cc heapPQ.h
	g++ priority_queue.cc -o priority_queue;
	./priority_queue

heapSort: heapSort.cc
	g++ heapSort.cc -o heapSort -lm;
	./heapSort


test_sos: test_sos.cc sos.o sos.h
	g++ test_sos.cc  -o test_sos -lm -lmyutil;
	./test_sos 1000

fastSet: fastSet.cc
	g++ fastSet.cc  -o fastSet -lm -lmyutil;
	./fastSet

disjointSet: disjointSet.cc
	g++ disjointSet.cc  -o disjointSet -lm -lmyutil;
	./disjointSet

huffman: huffman.cc
	g++ huffman.cc  -o huffman -lm
