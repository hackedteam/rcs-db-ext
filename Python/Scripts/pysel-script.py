#!python2.7.exe
# EASY-INSTALL-ENTRY-SCRIPT: 'pythonselect==1.3','console_scripts','pysel'
__requires__ = 'pythonselect==1.3'
import sys
from pkg_resources import load_entry_point

if __name__ == '__main__':
    sys.exit(
        load_entry_point('pythonselect==1.3', 'console_scripts', 'pysel')()
    )
