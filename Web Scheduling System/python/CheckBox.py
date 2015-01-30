from Tkinter import *
import Tkinter

import sys
sys.path.append('C:/502/')

from Dialog import Dialog

class CheckBox(Frame):

    List_String_buttonText = ['8:00-8:30','8:30-9:00','9:00-9:30','9:30-10:00','10:00-10:30','10:30-11:00','11:00-11:30','11:30-12:00','12:00-12:30','12:30-1:00','1:00-1:30','1:30-2:00','2:00-2:30','2:30-3:00','3:00-3:30','3:30-4:00','4:00-4:30','4:30-5:00']

    def __init__(self, parent):
        top = self.top = Toplevel(parent)
        self.setDayCheckbutton('2013-09-23 Mon',0)
        self.setDayCheckbutton('2013-09-24 Tues',1)
        self.setDayCheckbutton('2013-09-25 Wed',2)
        self.setDayCheckbutton('2013-09-26 Thur',3)
        self.setDayCheckbutton('2013-09-27 Fri',4)

    def setDayCheckbutton(self, String_date, Int_col):
        myLabel = Label(self.top, text = String_date)
        myLabel.grid(row = 0, column = Int_col)
        myLabelWeekday = Label(self.top, text = 'Monday')
        myLabelWeekday.grid(row = 1, column = Int_col)

        Int_listLength = len(CheckBox.List_String_buttonText)
        Int_rowNum = 2
        for i in range(0, Int_listLength):
            String_buttonText = CheckBox.List_String_buttonText[i]
            if String_buttonText in ('12:00-12:30','12:30-1:00'):
                cb = Checkbutton(self.top, text=String_buttonText, state = DISABLED)
            else:
                cb = Checkbutton(self.top, text=String_buttonText, command = self.ClickOn)
            cb.grid(row = Int_rowNum, column = Int_col)
            Int_rowNum += 1

    def ClickOn(self):
        dialog = Dialog(self.top)
#        self.top.destroy()
