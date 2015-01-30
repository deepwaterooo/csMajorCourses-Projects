from Tkinter import *

master = Tk()

listbox = Listbox(master, exportselection=0)
listbox.pack(side=LEFT)

listbox.insert(END, "a list entry")

for item in ["one", "two", "three", "four\nFive"]:
    listbox.insert(END, item)

listbox2 = Listbox(master, exportselection=0)
listbox2.pack(side=LEFT)

listbox2.insert(END, "a list entry")

for item in ["one", "two", "three", "four"]:
    listbox2.insert(END, item)

mainloop()