# Lectures for AICE1005: Algorithms and Analysis

## Set up for new year

To update index.html and lecture_timetable.html in ../site

- Update course.yaml
  - year
  - term_start
  - holidays
  - slots (day, time and location of lectures)
  - lectures (if necessary --- note list_lecture.py helps)
- Run
  - python make_index.py
  - python make_timetable.py
- run git
  - git add .
  - git commit -m "update index"
  - git push