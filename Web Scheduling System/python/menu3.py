from Tkinter import Tk, Frame, Menu


class Example(Frame):
  
    def __init__(self, parent):
        Frame.__init__(self, parent)   
         
        self.parent = parent
        
        self.initUI()
        
    def initUI(self):
      
        self.parent.title("Submenu")
        
        menubar = Menu(self.parent)
        self.parent.config(menu=menubar)
        
        fileMenu = Menu(menubar)       
        
        submenu = Menu(fileMenu)
        submenu.add_command(label="New feed")
        submenu.add_command(label="Bookmarks")
        submenu.add_command(label="Mail")
        fileMenu.add_cascade(label='Import', menu=submenu, underline=0)
        
        fileMenu.add_separator()
        
        fileMenu.add_command(label="Exit", underline=0, command=self.onExit)
        menubar.add_cascade(label="File", underline=0, menu=fileMenu)        
                

    def onExit(self):
        self.quit()


def main():
  
    root = Tk()
    root.geometry("250x150+300+300")
    app = Example(root)
    root.mainloop()  


if __name__ == '__main__':
    main()  