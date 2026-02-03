import psutil

PROCNAME = "python.exesss"

for proc in psutil.process_iter():
    
    if proc.name() == "evince":
        print(proc, proc.name())
    # check whether the process name matches
    if proc.name() == PROCNAME:
        proc.kill()
