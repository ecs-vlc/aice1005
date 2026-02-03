import myutil;
size(300,0);

string[] words = {"you", "can", "cage", "a", "swallow", "can't", "you"};

int picno=0;
void out() {
  draw(box((0,-0.1), (60,16)), white);
  string fn = "stack-rev" + string(picno);
  ++picno;
  shipout(fn);
  erase();
}

for(int j=0; j<=words.length; ++j) {
  string sentence;
  for(int i=j; i<words.length; ++i) {
    sentence = sentence + words[i] + " ";
  }

  label(sentence, (40,12), NW);
  for(int i=0; i<j; ++i) {
    label(words[i], (53, 2*i),N);
  }
  draw((48,15)--(48,0)--(58,0)--(58,15));
  out();
}

for(int j=words.length-1; j>=0; --j) {
  string sentence;
  for(int i=words.length-1; i>=j; --i) {
    sentence = sentence + words[i] + " ";
  }

  label(sentence, (4,12), NE);
  for(int i=0; i<j; ++i) {
    label(words[i], (53, 2*i),N);
  }
  draw((48,15)--(48,0)--(58,0)--(58,15));
  out();
}
