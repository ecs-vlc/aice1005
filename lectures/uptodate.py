from pathlib import Path
import datetime

class UpToDate:
    def __init__(self, filename):
        self.filename = filename
        file = Path(filename)
        if (file.is_file()):
            with open(filename, "r") as f:
                self.timestamp = float(f.readline())
        else:
            self.timestamp = 0

    def __call__(self, filename):
        file = Path(filename)
        if (file.is_file()):
            modified = file.stat().st_mtime
            return modified > self.timestamp
        else:
            return False

    def done(self):
        now = datetime.datetime.now().timestamp()
        with open(self.filename, "w") as f:
            f.write(f"{now}\n")
