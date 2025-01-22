#!/usr/bin/env python3

import yaml
import re

def extract(str):
    _, endpart = str.split("{")
    mid, _ = endpart.split("}")
    return mid

with open("lectures.tex", "r") as f:
    lectures = [extract(line) for line in f if re.search("^\\\\lecture{", line)]

with open("subsidary.yml", "r") as f:
    subsidary = yaml.safe_load(f)

    
html = open("index.php", "w")

html.write('''<HTML>
<HEAD>
<TITLE>Lecture Notes
</TITLE>
</HEAD>

<?PHP include('../header.htx'); ?>

<H1 align="center">Lecture Notes</H1>

<h2>Lesson on Using Data Structures and Algorithms</h2>

<ol>
''')

def getKeywords(file) :
    with open(file, "r") as file:
        lesson = ""
        cnt = 0
        for line in file:
            cnt = cnt + 1
            m = re.search("\\\\lesson\\{(.+?)\\}", line)
            if m:
                lesson = m.group(1)
            m = re.search("\\\\keywords\\{(.+?)\\}", line)
            if m: 
                return lesson, m.group(1)
            if cnt>10:
                break
        return lesson, ""
        

for lecture in lectures:
    tex = f"{lecture}.tex"
    lesson, keywords = getKeywords(tex)
    html.write(f"<li><b>{lesson}</b>: {keywords}\n")
    html.write(f"<ul> <li> <a href=\"apb-lectures/{lecture}.pdf\">Lecture PDF</a>,\n")
    html.write(f"  <a href=\"apb-lectures/{lecture}_prn.pdf\">Printable PDF</a>,\n")
    html.write(f"  <a href=\"apb-lectures/{lecture}_prn_4.pdf\">(4 per page)</a>,\n")
    html.write(f"  <a href=\"apb-lectures/{lecture}_prn_8.pdf\">(8 per page)</a>,\n</li>\n</ul>\n")
    if lecture in subsidary:
        html.write("<ul>\n")
        for k, v in subsidary[lecture].items():
            html.write(f" <li> <a href=\"apb-lectures/code/{lecture}/{v}\">{k}</a> ({v}) </li>\n")
        html.write("</ul>\n")
    html.write("</li>\n")

html.write('''
</ol>

<ul>
<li> <a href="apb-lectures/lectures_8.pdf">Complete set of Notes</a></li>
</ul>

<?PHP include('../footer.htx'); ?>

</HTML>
''')

html.flush()
html.close()

import os

os.system("scp index.php login:/notes/biom2005/lectures/index.php")
