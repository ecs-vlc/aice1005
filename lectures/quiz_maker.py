import yaml
from typing import TextIO
from random import shuffle

def begin_slide(tex_file: TextIO, q_no: int):
    tex_file.write("""%%%%%%%%%%%%%%%%%%%%%%% Next Slide %%%%%%%%%%%%%%%%%%%%%%%""")
    tex_file.write("\n\\begin{slide}\n")
    tex_file.write(f"\\section[-1]{{Question {q_no}}}\n\n")

def end_slide(tex_file: TextIO):
    tex_file.write("\\end{slide}\n\n")

def begin_item(tex_file: TextIO):
    tex_file.write("\\begin{PauseHighLight}\n")
    tex_file.write("  \\begin{itemize}\n")
    
def end_item(tex_file: TextIO):
    tex_file.write("  \\end{itemize}\n")
    tex_file.write("\\end{PauseHighLight}\n")

    
def standard_question(tex_file: TextIO, question: dict):
    if question['question'][-1] == "?":
        tex_file.write(f"  \\item {question['question']}\n")
    else:
        tex_file.write(f"  \\item {question['question']}?\n")
    tex_file.write("    \\begin{enumerate}\n")
    question["distractors"].append(question["answer"])
    shuffle(question["distractors"])
    true_no = 0
    for a_no, answer in enumerate(question["distractors"], 1):
        if answer == question["answer"]:
            true_no = a_no
        tex_file.write(f"    \\item {answer}")
        if a_no == len(question["distractors"]):
            tex_file.write("\\pause\n")
        else:
            tex_file.write("\n")
    tex_file.write("    \\end{enumerate}\n")
    if 'false_answer' in question:
        tex_file.write(f"  \\item Answer: {true_no}. {question['answer']} is \\emph{{false}}\\pauseb\n")
    else:
        tex_file.write(f"  \\item Answer: {true_no}. {question['answer']}\\pauseb\n")
        
def figure_question(tex_file: TextIO, question: dict):
    tex_file.write("\\pb\n")
    if question['question'][-1] == "?":
        tex_file.write(f"  {question['question']}\\pauseh\n")
    else:
        tex_file.write(f"  {question['question']}?\\pauseh\n")
    tex_file.write("\\pauseh\\pauselevel{=1}")
    tex_file.write("  \\begin{center}\n")
    tex_file.write(f"  \\multipdf[height=12cm]{{{question['figure']}}}\\pause\n")
    tex_file.write("  \\end{center}\n")


def make_question(tex_file: TextIO, q_no: int, question: dict):
    begin_slide(tex_file, q_no)
    if "figure" in question:
        figure_question(tex_file, question)
    else:
        begin_item(tex_file)
        standard_question(tex_file, question)
        end_item(tex_file)
    end_slide(tex_file)


def start_file(tex_file: TextIO):
    tex_file.write("""%Master File:lectures.tex

\\lesson{Quiz}
\\begin{center}
 \\includegraphics[width=0.5\\textwidth]{quiz}
\\end{center}
\\keywords{Course Quiz}

""")

    
def main():
    with open("quiz.yml", 'r') as yaml_file:
        data = yaml.safe_load(yaml_file)

    with open("quiz.tex", 'w') as tex_file:
        start_file(tex_file)
        for i, question in enumerate(data["questions"], 1):
            if not question["question"]:
                continue
            make_question(tex_file, i, question)

if __name__ == "__main__":
    main()
