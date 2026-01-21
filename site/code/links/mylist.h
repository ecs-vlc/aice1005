#ifndef MYLIST_H
#define MYLIST_H

template <typename T>
class MyList {
private:
  struct Node{
    Node(T value, Node *node): value(value), next(node) {}
    T value;
    Node *next;
  };

  struct list_iterator {
    list_iterator(Node *pt): entry(pt) {}
    T& operator*() {return entry->value;}
    const T& operator*() const {return entry->value;}
    list_iterator operator++() {
      entry = entry->next;
      return entry;
    }
    bool operator!=(const list_iterator& other) const {
      return entry != other.entry;
    }

    Node *entry;
  };
  
  Node *head;
  unsigned n;
public:
  
  MyList(): n(0), head(0) {}
  
  unsigned size() const {return n;}
  
  void push(T value) {
    Node *start = new Node(value, head);
    head = start;
    ++n;
  }

  T top() const {return head->value;}
  
  void pop() {
    Node *dead = head;
    head = dead->next;
    delete dead;
    --n;
  }
  
  bool empty() const {
    return head == 0;
  }

  ~MyList() {
    while (!empty()) {
      pop();
    }
  }

  list_iterator begin() {return list_iterator(head);}
  list_iterator end() {return list_iterator(0);}
  
};

#endif
