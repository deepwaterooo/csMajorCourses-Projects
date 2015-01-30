from Tkinter import *

import sys
sys.path.append('C:/tmp/')

from Application import Application


root = Tk()
app = Application(master=root)
app.mainloop()
