from Tkinter import *

class GUI(Frame):

    def __init__(self, parent):
        Frame.__init__(self, parent)    
        self.parent = parent
        self.initUI()

    def initUI(self):
        self.grid() 
        self.parent.title("Wahoos Menu Test")
        self.create_buttons() 

global count
count = -1

def create_buttons(self):
    for r in range(20):
        for c in range(14):
            Label(self, text='',
                borderwidth=0).grid(row=r,column=c)
    B = Button(self, text ="Begin Exam", relief=RIDGE, fg="black", command= self.on_button_press).grid(row=19, column=7)
    L = Label(self, text="What comes in the following", fg="blue").grid(row=6, column=0)
    self.veg = ['Lettuce', 'Cabbage', 'Cheese', 'Ahee Rice', 'Brown Rice', 'Banzai Veg', 'Red Cabbage', 'Black Beans', 'Cajun White Beans']
    self.vegboxes = []
    self.opt = []
    c = 1
    for ve in self.veg:
        c +=1
        self.v = IntVar()
        self.vegboxes.append(self.v)
        vo = Checkbutton(self, text=ve, variable=self.v, onvalue=1, offvalue=0).grid(row=c, column=11, sticky=W)            

    def on_button_press(self):
        global count
        count = count + 1
        menuItems = {'nft': ['cabbage', 'cheese', 'corn', 'nf', 'salsa'],
                     'nckt': ['lettuce', 'cheese', 'corn', 'nck', 'salsa']}
        menu = ['blackened fish taco', 'wahoos chicken salad']
        if count == len(menu):
            C = Button(self, text ="           Your Done!          ", relief=RIDGE, fg="black").grid(row=19, column=7)
        else:
            m = Label(self, text=menu[count], fg="black").grid(row=7, column=0)
            C = Button(self, text ="Submit and Continue", relief=RIDGE, fg="black", command= self.read_checks).grid(row=19, column=7)

    def read_checks(self):
        for v in self.veg:
            if self.v == 1:
                print(self.veg[v])          

    def main():
        root = Tk()
        app = GUI(root)
        root.mainloop()
    
    if __name__ == '__main__':
        main()