set print pretty on
set print object on
set print static-members on
set print vtbl on
set print demangle on
set demangle-style gnu-v3

set auto-load safe-path /
#add-auto-load-safe-path /usr/lib64/libstdc++.so.6.0.19-gdb.py

# KDE
#python
#import sys
#sys.path.insert(0, '${DATA_INSTALL_DIR}/kdevgdb/printers')
#sys.path.insert(0, '/home/saschpe/Projects/kde/src/kdevelop/debuggers/gdb/printers')
#
#from qt4 import register_qt4_printers
#register_qt4_printers (None)
#from kde4 import register_kde4_printers
#register_kde4_printers (None)
#end
# END KDE
