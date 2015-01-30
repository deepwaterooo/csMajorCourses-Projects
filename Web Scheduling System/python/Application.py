from Tkinter import *

import sys
sys.path.append('C:/502/')

from Login import Login
from UserClass import UserClass
from CheckBox import CheckBox

class Application(Frame):
    def login(self):
        login = Login(self.master)
        self.master.wait_window(login.top)
        self.String_emailAddress = login.getUsername()

        userClass = UserClass(self.String_emailAddress)

        if userClass.isEmail():
            if userClass.isValidEmail():
                self.canvas.delete(ALL)
                self.canvas.create_text(20, 30, anchor = W, text = "Welcome, " + self.String_emailAddress+"!")

                if userClass.isStudent():
                    checkbox_student = CheckBox(self.master)
                elif userClass.isInstructor():
                    pass
                    #pop instructor interface
            else:
               pass 

    def createWidgets(self):
        self.Login = Button(self)
        self.Login["text"] = "Login",
        self.Login["command"] = self.login
        self.Login.pack({"side": "top"})

        self.QUIT = Button(self)
        self.QUIT["text"] = "Quit"
        self.QUIT["fg"]   = "red"
        self.QUIT["command"] =  self.quit
        self.QUIT.pack({"side": "top"})

    def __init__(self, master=None):
        Frame.__init__(self, master)
        self.master = master
        self.pack()
        self.createWidgets()
        self.String_emailAddress = ""

        self.canvas = Canvas(self, width = 600, height = 100)
        self.canvas.pack(fill= BOTH, expand = 1)

