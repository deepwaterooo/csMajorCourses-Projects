from Tkinter import *

import sys
sys.path.append('C:/502/')

class Dialog():
    def __init__(self, parent):
        top = self.top = Toplevel(parent)

        self.String_firstname = ""
        self.String_lastname = ""
        self.String_schedReason = ""

        self.Label_firstname = Label(top, text = "Firstname:")
        self.Label_firstname.pack()
        self.Entry_firstname = Entry(top, width = 30)
        self.Entry_firstname.pack()

        self.Label_lastname = Label(top, text = "Lastname:")
        self.Label_lastname.pack()
        self.Entry_lastname = Entry(top, width = 30)
        self.Entry_lastname.pack()

        self.Label_schedReason = Label(top, text = "Appointment Reason:")
        self.Label_schedReason.pack()
        self.Entry_schedReason = Entry(top, width = 100)
        self.Entry_schedReason.pack()

        self.button = Button(top, text="Submit", width = 10, command=self.on_button)
        self.button.pack()

    def getFirstname(self):
        return self.Entry_firstname

    def getLastname(self):
        return self.Entry_lastname

    def getSchedReason(self):
        return self.Entry_schedReason

    def on_button(self):
        self.Entry_firstname = self.Entry_firstname.get()
        self.Entry_lastname = self.Entry_lastname.get()
        self.Entry_schedReason = self.Entry_schedReason.get()
        self.top.destroy()

