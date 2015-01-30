import Tkinter as tk

class GUI(tk.Tk):
    def __init__(self):
        tk.Tk.__init__(self)

        self.buttonDic = {
        'Brown Rice':0,
        'Banzai Veg':0,
        'Red Cabbage':0,
        'Black Beans':0
        }

        for key in self.buttonDic:
            self.buttonDic[key] = tk.IntVar()
            aCheckButton = tk.Checkbutton(self, text=key,
                                            variable=self.buttonDic[key])
            aCheckButton.grid(sticky='w')

        submitButton = tk.Button(self, text="Submit",
                                        command=self.query_checkbuttons)
        submitButton.grid()

    def query_checkbuttons(self):
        for key, value in self.buttonDic.items():
            state = value.get()
            if state != 0:
                print(key)
                self.buttonDic[key].set(0)

gui = GUI()
gui.mainloop()