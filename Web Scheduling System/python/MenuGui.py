from Tkinter import Tk, Frame, Menu

import sys
sys.path.append('C:/502/')

from Dialog import Dialog

class MenuGui(Frame):
    def __init__(self, parent):
        Frame.__init__(self, parent)   
        self.parent = parent        
        self.parent.title("Curent Week's Schedule: ")
        self.menubar = Menu(self.parent)
        self.parent.config(menu=self.menubar)

        self.setDayMenuCheckButton("2013-09-23" + "\n" + "Mon")
        self.setDayMenuCheckButton('2013-09-24 Tues')
        self.setDayMenuCheckButton('2013-09-25 Wed')
        self.setDayMenuCheckButton('2013-09-26 Thur')
        self.setDayMenuCheckButton('2013-09-27 Fri')
        
        self.menubar.post(self.master.x_root,self.master.x_root)

    def setDayMenuCheckButton(self, String_date):
        dayMenu = Menu(self.menubar, tearoff = 0)
        dayMenu.add_checkbutton(label='8:00-8:30', command=self.onExit)
        dayMenu.add_checkbutton(label='8:30-9:00', command=self.onExit)
        dayMenu.add_checkbutton(label='9:00-9:30', command=self.onExit)
        dayMenu.add_checkbutton(label='9:30-10:00', command=self.onExit)
        dayMenu.add_checkbutton(label='10:00-10:30', command=self.onExit)
        dayMenu.add_checkbutton(label='10:30-11:00', command=self.onExit)
        dayMenu.add_checkbutton(label='11:00-11:30', command=self.onExit)
        dayMenu.add_checkbutton(label='11:30-12:00', command=self.onExit)
        dayMenu.add_checkbutton(label='12:00-12:30', command=self.onExit, background = 'grey', state= 'disabled')
        dayMenu.add_checkbutton(label='12:30-1:00', command=self.onExit, background = 'grey', state= 'disabled')
        dayMenu.add_checkbutton(label='1:00-1:30', command=self.onExit)
        dayMenu.add_checkbutton(label='1:30-2:00', command=self.onExit)
        dayMenu.add_checkbutton(label='2:00-2:30', command=self.onExit)
        dayMenu.add_checkbutton(label='2:30-3:00', command=self.onExit)
        dayMenu.add_checkbutton(label='3:00-3:30', command=self.onExit)
        dayMenu.add_checkbutton(label='3:30-4:00', command=self.onExit)
        dayMenu.add_checkbutton(label='4:00-4:30', command=self.onExit)
        dayMenu.add_checkbutton(label='4:30-5:00', command=self.onExit)
        self.menubar.add_cascade(label=String_date, menu=dayMenu)

    def popup(self, event):
        self.menubar.post(event.x_root, event.y_root)

    def onExit(self):
        dialog = Dialog(self)
#        pass

def main():
    root = Tk()
    root.geometry("250x150+300+300")
    app = MenuGui(root)
    root.mainloop()  

if __name__ == '__main__':
    main()  



