#!/usr/bin/env python3

import os
import re
import subprocess
import sys

y_or_m = re.compile(r'^< CONFIG_(\w+)=[ym]$', re.MULTILINE)
is_not_set = re.compile(r'^> # CONFIG_(\w+) is not set$', re.MULTILINE)

def cwdFile(name):
    return os.path.join(os.getcwd(), name)

def intersection(x, y):
    return [e for e in x if e in y]

if __name__ == "__main__":
    cc = cwdFile(".cfg")
    oc = cwdFile('.cur')
    diff = subprocess.run(["diff", oc, cc], capture_output=True)

    with open(sys.argv[1], 'w') as f:
        stdout = diff.stdout.decode('utf-8')

        items = intersection(y_or_m.findall(stdout), is_not_set.findall(stdout))

        f.write('{ default, force, y, n, u, m, ff, ... }: \n\n{ } // {\n')
        for i in items:
            f.write(i)
            f.write(' = default n;\n')
        f.write('} // { }')
