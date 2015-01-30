from Tkinter import *
 
class TestMenu:
    def __init__(self, master):
        self.master = master
        self.menubar = Menu(self.master)
        
        self.chkmenu = Menu(self.menubar)
        self.chkmenu.add_checkbutton(label='A')
        self.chkmenu.add_checkbutton(label='B')
        self.chkmenu.add_checkbutton(label="C")
        self.chkmenu.add_checkbutton(label='D')
        self.chkmenu.add_checkbutton(label='E')    
        self.chkmenu.invoke(self.chkmenu.index('C'))
 
        self.menubar.add_cascade(label="Checkbutton Menu", menu=self.chkmenu)
        self.top = Toplevel(menu=self.menubar, width=500, relief=RAISED,borderwidth=2)
 
def main():
    root = Tk()
    root.withdraw()
    app = TestMenu(root)
    root.mainloop()
 
if __name__ == '__main__':
    main()
 