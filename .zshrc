#!/bin/python
from sys import argv
from math import floor, ceil

length = int(argv[1])
text = " ".join(argv[2:])

left_padding = floor((length - len(text)) / 2)
right_padding = ceil((length - len(text)) / 2)

if len(text) > length:
    print(f" {text[:length-2]} ")
else:
    print(left_padding * " " + text + right_padding * " ")
