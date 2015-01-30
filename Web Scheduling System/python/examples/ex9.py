from Tkinter import *
import os

root = Tk()


def buttonPressed():
    # this is the problem in the program.
    # it keeps returning [''] in the print statement and doesn't quit
    # any applications
    listOfApps = form1.form.get().split(',')
    # the print is just so i can see the output
    print(listOfApps)
    # goes through each item in list and kills them(yes i know there are much easier
    # ways to do this, i'm just trying to learn a bit about GUI and the os module
    for i in listOfApps:
        try:
            os.system("killall " + i)
        except:
            pass
def buttonPressed2():
    filesToOpen = form2.form.get().split(', ')
    for i in filesToOpen:
        try:
            os.system("open " + i)
        except:
            pass

class form_and_submit:
    def _init_(self):
        pass
    #creates an instance of a form with seperate variables for button text, buton command, and color of the frame
    def create_container(self, buttonText, buttonCommand, color):
        #Creating all widgets/containers
        self.container = Frame(root)
        self.form = Entry(self.container)
        self.button = Button(self.container)
        #defining variables for all widgets/containers
        root['background'] = color
        self.container['background'] = color
        self.button['text'] = buttonText
        self.button['command'] = buttonCommand
        self.form['background'] = color
        self.form['border'] = '5'
        self.form['highlightthickness'] = '0'
        #Packing all widgets/containers
        self.container.pack()
        self.form.pack()
        self.button.pack()

#creating forms and putting them in root with desire attributes
form1 = form_and_submit()
form2 = form_and_submit()
form1.create_container('kill matching processes', buttonPressed, 'red')
form2.create_container('Open desired files', buttonPressed2, 'blue')
#starts up window
root.mainloop()