#include "Queue.h"

/* Constructor; should create an empty queue with capacity 8 */

template <typename T>
Queue<T>::Queue() {}

/* Copy Constructor: note that this is generated by default, but the default copy constructor does the wrong thing */

template <typename T>
Queue<T>::Queue(const Queue<T>& rhs) {}

/* Destructor needs to free up memory */

template <typename T>
Queue<T>::~Queue() {}

/* enqueue: add item to the list.  This may need to resize the list (if you want you can create another function resize in the head file Queue.h). In the standard library this would be called push. */

template <typename T>
void Queue<T>::enqueue(const T& item) {}

/* dequeue: remove the first element in the queue and returns it (in the standard library top() would return the first element in the queuue but not remove it.  pop() would remove the first element in the queue, but not return anything).  This should throw std::out_of_range when the queue is empty */

template <typename T>
T Queue<T>::dequeue() {}

/* size: returns the number of elements in the queue.  As this can't be negative we make this an unsigned integer.  The const in the definition tells us that this command does not change the Queue data structure */

template <typename T>
unsigned Queue<T>::size() const {return 0;}

/* is_empty: returns true if queue is empty */

template <typename T>
bool Queue<T>::is_empty() const {return true;}


/* capacity: tells up how much memory we have reserved */

template <typename T>
unsigned Queue<T>::capacity() const {return 0;}

/* resize_capacity: if the capacity request is at least as large as the number of elements the capacity should be modified and return true other leave the capacity unchanged and return false */

template <typename T>
bool Queue<T>::resize_capacity(unsigned capacity_request) {return false;}
