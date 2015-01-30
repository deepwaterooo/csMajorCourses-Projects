import arcpy
import pythonaddins

class ComboBoxClass(object):
    """Implementation for ComboBox_addin.combobox (ComboBox)"""
    def __init__(self):
            self.editable = True
            self.enabled = True
            self.width = 'WWWWWWWW'
            self.dropdownWidth = 'WWWWWWW'

    def onFocus(self, focused):
        if focused:
            self.mxd = arcpy.mapping.MapDocument('current')
            layers = arcpy.mapping.ListLayers(self.mxd)
            self.items = []
            for layer in layers:
                self.items.append(layer.name)

    def onSelChange(self, selection):
        global fc
        fc = arcpy.mapping.ListLayers(self.mxd, selection)[0]
        
class ButtonClass(object):
    """Implementation for ComboBox_addin.button (Button)"""
    def __init__(self):
        self.enabled = True
        self.checked = False
    def onClick(self):
        print fc