from Tkinter import *
import Tkinter

import sys
sys.path.append('C:/502/')

from DateButtons import DateButtons

class CheckBox(Frame):

    List_String_buttonText = ['8:00-8:30','8:30-9:00','9:00-9:30','9:30-10:00','10:00-10:30','10:30-11:00','11:00-11:30','11:30-12:00','12:00-12:30','12:30-1:00','1:00-1:30','1:30-2:00','2:00-2:30','2:30-3:00','3:00-3:30','3:30-4:00','4:00-4:30','4:30-5:00']

    def __init__(self, master=None):
        Frame.__init__(self, master)
        self.master = master
        self.master.title("Meeting Scheduler:")

        self.master.rowconfigure(0, weight=1)
        self.master.columnconfigure(0, weight=1)

        for r in range(22):
            self.master.rowconfigure(r, weight=1)    
        for c in range(5):
            self.master.columnconfigure(c, weight=1)
            self.master.button = Button(master, text = "Button {0}".format(c))
            self.master.button.grid(row=20, column=c, sticky=W+E)

        self.Frame1 = Frame(self.master, bg="red")
        self.Frame1.grid(row = 0, column = 0, rowspan = 20, columnspan = 1, sticky = W+E+N+S) 
        self.Frame2 = Frame(self.master, bg="blue")
        self.Frame2.grid(row = 0, column = 1, rowspan = 20, columnspan = 1, sticky = W+E+N+S)
        self.Frame3 = Frame(self.master, bg="green")
        self.Frame3.grid(row = 0, column = 2, rowspan = 20, columnspan = 1, sticky = W+E+N+S)
        self.Frame4 = Frame(self.master, bg="blue")
        self.Frame4.grid(row = 0, column = 3, rowspan = 20, columnspan = 1, sticky = W+E+N+S)
        self.Frame5 = Frame(self.master, bg="green")
        self.Frame5.grid(row = 0, column = 4, rowspan = 20, columnspan = 1, sticky = W+E+N+S)

        DateButtons('2013-09-23 Mon',self.Frame1).setDayCheckbutton()
        DateButtons('2013-09-24 Tues',self.Frame2).setDayCheckbutton()
        DateButtons('2013-09-25 Wed',self.Frame3).setDayCheckbutton()
        DateButtons('2013-09-26 Thur',self.Frame4).setDayCheckbutton()
        DateButtons('2013-09-27 Fri',self.Frame5).setDayCheckbutton()

if __name__ == "__main__":
    root = Tkinter.Tk()
    CheckBox(root).pack(side="top", fill="both", expand=True)
    root.mainloop()