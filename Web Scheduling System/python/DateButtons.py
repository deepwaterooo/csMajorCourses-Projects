from Tkinter import *
import Tkinter

class DateButtons(Frame):
    List_String_buttonText = ['8:00-8:30','8:30-9:00','9:00-9:30','9:30-10:00','10:00-10:30','10:30-11:00','11:00-11:30','11:30-12:00','12:00-12:30','12:30-1:00','1:00-1:30','1:30-2:00','2:00-2:30','2:30-3:00','3:00-3:30','3:30-4:00','4:00-4:30','4:30-5:00']

    def __init__(self, String_date, master):
#        Frame.__init__(self, master)
        self.master = master
        self.String_date = String_date

    def setDayCheckbutton(self):
        myLabel = Label(self.master, text = self.String_date)
        myLabel.grid(row = 0, column = 0, rowspan = 1, columnspan = 1, sticky = W+E+N+S)
        myLabelWeekday = Label(self.master, text = 'Monday')
        myLabelWeekday.grid(row = 1, column = 0, rowspan = 1, columnspan = 1, sticky = W+E+N+S)

        vsb = Scrollbar(self.master, orient="vertical")
        text = Text(self.master, width=12, height=29, yscrollcommand=vsb.set)
        vsb.config(command=text.yview)

        Int_listLength = len(DateButtons.List_String_buttonText)
        Int_rowNum = 2
        for i in range(0, Int_listLength):
            String_buttonText = DateButtons.List_String_buttonText[i]
            cb = Checkbutton(self.master, text=String_buttonText)
            cb.grid(row = Int_rowNum, column = 0, rowspan = 1, columnspan = 1, sticky = W+E+N+S)
            Int_rowNum += 1
