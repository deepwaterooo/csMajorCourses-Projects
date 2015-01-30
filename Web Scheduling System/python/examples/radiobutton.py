from Tkinter import *
root = Tk()
root.title('Radiobutton')
fruit=[('Passion fruit\nSecond line', 1), ('Loganberries', 2), 
        ('Mangoes\nin syrup', 3), ('Oranges', 4), 
        ('Apples', 5), ('Grapefruit', 6)]
var = IntVar()
for text, value in fruit:
    Radiobutton(root, text=text, value=value, variable=var).pack(anchor=W)
var.set(3)
root.mainloop()