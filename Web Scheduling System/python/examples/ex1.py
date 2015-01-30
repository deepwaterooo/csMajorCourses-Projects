#!/usr/bin/env python

import gtk

distributions = ["Ubuntu", "Debian", "Sabayon", "Fedora", "Arch", "Mint", "Slackware", "Mandriva", "Sidux", "Mepis"]

class ComboBox:
    def __init__(self):
        window = gtk.Window()
        
        liststore = gtk.ListStore(str)
        for item in distributions:
            liststore.append([item])
        
        cell = gtk.CellRendererText()
        
        combobox = gtk.ComboBox(liststore)
        combobox.pack_start(cell, True)
        combobox.add_attribute(cell, "text", 0)
        
        combobox.set_active(0)
        
        window.add(combobox)
        
        window.connect("destroy", lambda w: gtk.main_quit())
        combobox.connect("changed", self.changed_item)
        
        window.show_all()
    
    def changed_item(self, widget):
        print "ComboBox item was changed to %s" % widget.get_active_text()

ComboBox()
gtk.main()