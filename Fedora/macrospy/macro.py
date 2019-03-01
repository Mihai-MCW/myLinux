import sys, time
from pynput.keyboard import Key, Controller

def cmd2(c1,c2):
    Controller().press(c1)
    Controller().press(c2)
    time.sleep(0.03)
    Controller().release(c2)
    Controller().release(c1)

arg = sys.argv[1]
#print(arg)
if arg == 'zoom_in':
    cmd2(Key.ctrl_l,'+')
elif arg == 'zoom_out':
    cmd2(Key.ctrl_l,'-')
elif arg == 'back':
    cmd2(Key.alt_l,Key.left)
elif arg == 'forward':
    cmd2(Key.alt_l,Key.right)
elif arg == 'wp_down':
    cmd2(Key.cmd,Key.page_down)
elif arg == 'wp_up':
    cmd2(Key.cmd,Key.page_up)
#else: print("Undefined behaviour")