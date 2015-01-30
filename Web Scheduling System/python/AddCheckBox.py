import random
import string
from Tkinter import *

root = Tk()

def addCheckBox():
    checkBoxName = "".join(random.choice(string.letters) for _ in range(10))
    c = Checkbutton(root, text=checkBoxName)
    c.pack()

b = Button(root, text="Add a checkbox", command=addCheckBox)
b.pack()

root.mainloop()