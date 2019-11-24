import atexit
import os
import readline
import sys

histfile = os.path.join(os.getenv(
    'XDG_CACHE_HOME', os.path.expanduser('~/.config')
), '.python_history')

try:
    readline.read_history_file(histfile)
    readline.set_history_length(1000)
except FileNotFoundError:
    pass

atexit.register(readline.write_history_file, histfile)
