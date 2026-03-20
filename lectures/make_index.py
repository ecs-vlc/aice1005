from timetable import timetable

def tag(name, content, attribute=None, space=False):
    if space:
        content = f"\n{content}\n"
    if attribute:
        return f"<{name} {attribute}> {content} </{name}>\n"
    else:
        return f"<{name}> {content} </{name}>\n"

def link(content, ref):
    return tag("a", content, f"href=\"{ref}\"")
  
def homepage():
    coursename =  "AICE1005: Algorithms and Analysis"
    header = "<meta charset=\"UTF-8\">\n"
    header += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
    header += "<link rel='stylesheet' href='style.css'>\n"
    header += tag('title', coursename)
    inhtml = tag("head", header, space=True)
    
    inbody = tag("header", coursename)
    
    inbody += tag("h1", coursename)
    mail_link = link("Adam Pr&uuml;gel-Bennett", "href=\"mailto: apb1@soton.ac.uk\"")
    inbody += tag("p", f"Welcome to Algorithms and Analysis, an introduction to data structures and algorithms and their analysis taught by {mail_link}.  The primary programming language will be C++")

    
    year, timeTable = timetable("courses.yaml")
    intable = tag("h2", f"Timetable for {year}")
    intable += timeTable
    inbody += tag("div", intable, "id=\"includedTimetable\"", space=True)

    inbody += "\n"
    inbody += tag("h2", "Problem Sheets")
    problem_sheet = link("Problem Sheet", "recurrence-questions.pdf")
    solutions = link("Solutions", "problem-answers.pdf")
    rathke = link("Extended Solutions", "problem-sol.pdf")
    inbody += tag("p", f"Here is a {problem_sheet} on computing run times for recursive functions through writing down a recurrence relation.  ({solutions} and {rathke} due to Julian Rathke)")
    

    info = tag("h2", "Course Information")
    info_table = tag("li", link("Lecture Notes", "lectures.html"))
    info_table += tag("li", link("Past Papers", "exams.html"))
    info += tag("ul", info_table)
    inbody += tag("div", info)
    inbody += tag("footer", f"ECS {year}: {coursename}")
    inhtml += tag("body", inbody)
    index_file = "<!DOCTYPE html>\n"
    index_file += tag("html", inhtml, "lang=\"en\"")
    return index_file

def main():
    html = homepage()
    with open("../site/index.html", "w") as f:
        f.write(html)

if __name__ == "__main__":
    main()
