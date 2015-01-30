import Tkinter as tk

class GUI(tk.Tk):
    def __init__(self):
        tk.Tk.__init__(self)

        self.score = 0

        self.buttonDic = {
        'Brown Rice':0,
        'Banzai Veg':0,
        'Red Cabbage':0,
        'Black Beans':0
        }

        aFrame = self.aFrame = tk.Frame(self)
        aFrame.grid()

        for key in self.buttonDic:
            self.buttonDic[key] = tk.IntVar()
            aCheckButton = tk.Checkbutton(aFrame, text=key,
                                            variable=self.buttonDic[key])
            aCheckButton.grid(sticky='w')

        submitButton = tk.Button(aFrame, text="Submit",
                                        command=self.query_checkbuttons)
        submitButton.grid()

        self.trueList = ['Brown Rice', 'Black Beans']

    def query_checkbuttons(self):
        for key, value in self.buttonDic.items():
            state = value.get()
            if state != 0:
                if key in self.trueList:
                    self.score += 1
                else:
                    self.score -= 1
                self.buttonDic[key].set(0)
        self.result_screen()

    def result_screen(self):
        self.aFrame.grid_forget()
        self.rFrame = tk.Frame(self)
        self.rFrame.grid()
        self.scoreText = tk.Text(self.rFrame, width=20, height=1)
        self.scoreText.grid()
        self.scoreText.insert('end', self.score)
        self.after(3000, func=self.go_back)

    def go_back(self):
        self.score = 0
        self.rFrame.destroy()
        self.aFrame.grid()


gui = GUI()
gui.mainloop()