#from gi.repository import Gtk
import gtk
import sys

distros = [["Select distribution"], ["Fedora"], ["Mint"], ["Suse"]]

class MyWindow(gtk.ApplicationWindow):
    def __init__(self, app):
        gtk.Window.__init__(self, title="Welcome to GNOME", application=app)
        self.set_default_size(200, -1)
        self.set_border_width(10)

        # the data in the model, of type string
        listmodel = gtk.ListStore(str)
        # append the data in the model
        for i in range(len(distros)):
            listmodel.append(distros[i])

        # a combobox to see the data stored in the model
        combobox = gtk.ComboBox(model=listmodel)

        # a cellrenderer to render the text
        cell = gtk.CellRendererText()

        # pack the cell into the beginning of the combobox, allocating
        # no more space than needed
        combobox.pack_start(cell, False)
        # associate a property ("text") of the cellrenderer (cell) to a column (column 0)
        # in the model used by the combobox
        combobox.add_attribute(cell, "text", 0)

        # the first row is the active one by default at the beginning
        combobox.set_active(0)

        # connect the signal emitted when a row is selected to the callback function
        combobox.connect("changed", self.on_changed)

        # add the combobox to the window
        self.add(combobox)

    def on_changed(self, combo):
        # if the row selected is not the first one, write its value on the terminal
        if combo.get_active() != 0:
            print "You chose " + str(distros[combo.get_active()][0]) +"."
        return True


class MyApplication(gtk.Application):
    def __init__(self):
        gtk.Application.__init__(self)

    def do_activate(self):
        win = MyWindow(self)
        win.show_all()

    def do_startup(self):
        gtk.Application.do_startup(self)

app = MyApplication()
exit_status = app.run(sys.argv)
sys.exit(exit_status)