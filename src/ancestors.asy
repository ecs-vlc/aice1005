size(120,0);
import myutil;

string[] monarchs = {"Victoria", "Edward VII", "George V", "George VI", "Elizabeth II"};

real u = 15;
for(int i=0; i<monarchs.length; ++i) {
  label(monarchs[i], (0,-u*i));
  if (i!=monarchs.length-1)
    draw((0,-u*(i+0.2))--(0,-u*(i+0.8)), Arrow);
}


draw(box((-10,-4.2u),(29,0.2u)), white);

ship();

draw((12,-4u)--(24,-4u), dashed);
label("Y", (24,-4u), E);

picture bg = new picture;
bg.add(currentpicture);

draw((12,-3u)--(24,-3u), dashed);
label("X", (24,-3u), E);
draw((16,-3u)--(16,-4*u), Arrow);
label(rotate(90)*Label("Ancester"), (13,-3.5*u));
ship();

draw((22,-3u)--(22,-4u), Arrow);
label(rotate(90)*Label("Parent"), (19,-3.5u));

ship();
erase();

add(bg);

draw((12,0)--(24,0), dashed);
label("X", (24,0), E);


draw((16,0)--(16,-4*u), Arrow);
label(rotate(90)*Label("Ancester"), (13,-2*u));

ship();


draw((18,-3u)--(24,-3u), dashed);
label("Z", (24,-3u), E);


draw((12,0)--(24,0), dashed);
draw((12,-4u)--(24,-4u), dashed);


draw((22,-3u)--(22,-4u), Arrow);
label(rotate(90)*Label("Parent"), (19,-3.5u));

ship();
draw((22,0)--(22,-3u), Arrow);
label(rotate(90)*Label("Ancester"), (19,-1.5*u));

ship();
