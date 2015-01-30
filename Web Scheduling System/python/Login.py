from Tkinter import *

import sys
sys.path.append('C:/502/')

class Login():
    def __init__(self, parent):
        top = self.top = Toplevel(parent)
        self.username = ""
        self.myLabel = Label(top, text = "Enter your UI Vandal Mail address below:")
        self.myLabel.pack()
        self.entry = Entry(top, width = 30)
        self.entry.pack()
        self.button = Button(top, text="Submit", width = 10, command=self.on_button)
        self.button.pack()

    def getUsername(self):
        return self.username

    def on_button(self):
        self.username = self.entry.get()
        self.top.destroy()

