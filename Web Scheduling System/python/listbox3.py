# a simple Tkinter ListBox example for multiline select
# use ctrl mouse click or shift mouse click
from Tkinter import *
def get_list():
    """
    function to read the listbox selection(s)
    (mutliple lines can be selected)
    and put the result(s) in a label
    """
    # tuple of line index(es)
    sel = listbox1.curselection()
    # get the text, might be multi-line
    seltext = '\n'.join([listbox1.get(x) for x in sel])
    choices.set(seltext)
root = Tk()
# used in label
choices = StringVar(root)
# extended mode allows CTRL or SHIFT mouse selections
listbox1 = Listbox(root, selectmode = EXTENDED)
listbox1.pack()
# click the button to show the selection(s)
button1 = Button(root, text = "Get Selection(s)", command = get_list)
button1.pack()
# display selection(s)
label1 = Label(root, textvariable = choices)
label1.pack()
# store some items in the listbox
items = ["one", "two", "three", "four", "five", "six"]
for item in items:
    listbox1.insert(END, item)
# highlight line 3 of listbox (line 1 is zero)
# lb.selection_set(first, last=None) can select more than 1 line
listbox1.selection_set(3)
root.mainloop()