// CS502          Appointment Scheduler Project
// Heyan Huang    Jia Wan
// April 9, 2013

// create a table model
// listening for data changes
   // http://docs.oracle.com/javase/tutorial/uiswing/components/table.html#data
// firing data change events
/*
import javax.swing.event.*;   // listening for data changes
import javax.swing.table.TableModel;
import javax.swing.*;
import javax.atw.*;
*/

package components;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
 
public class SimpleTableDemo extends JPanel {
    private boolean DEBUG = false;
 
    public SimpleTableDemo() {
        super(new GridLayout(1,0));

	// declare column names in a string array
	String[] columnNames = {"TimePeriod","Monday", "Tuesday","Wednesday","Thursday","Friday"};

	// data is initialized and stored in a two-dimensional object array: 
	// JTable(Object[][] rowData, Object[] columnNames)
	// JTable(Vector rowData, Vector columnNames)
	Object[][] data = {
	    {"7:30-8:00", "Kathy", "Smith","Snowboarding", new Integer(5), new Boolean(false)},
	    {"8:00-8:30", "Kathy", "Smith","Snowboarding", new Integer(5), new Boolean(false)},
	    {"8:30-9:00", "John", "Doe","Rowing", new Integer(3), new Boolean(true)},
	    {"9:00-9:30", "John", "Doe","Rowing", new Integer(3), new Boolean(true)},
	    {"9:30-10:00", "Sue", "Black","Knitting", new Integer(2), new Boolean(false)},
	    {"10:00-10;30", "Sue", "Black","Knitting", new Integer(2), new Boolean(false)},
	    {"10:30-11:00", "Jane", "White","Speed reading", new Integer(20), new Boolean(true)},
	    {"11:00-11:30", "Jane", "White","Speed reading", new Integer(20), new Boolean(true)},
	    {"11:30-12:00", "Joe", "Brown","Pool", new Integer(10), new Boolean(false)},
	    {"12:00-12:30", "Joe", "Brown","Pool", new Integer(10), new Boolean(false)},
	    {"12:30-1:00", "Joe", "Brown","Pool", new Integer(10), new Boolean(false)},
	    {"1:00-1:30", "Joe", "Brown","Pool", new Integer(10), new Boolean(false)},
	    {"1:30-2:00", "Joe", "Brown","Pool", new Integer(10), new Boolean(false)},
	    {"2:30-3:00", "Joe", "Brown","Pool", new Integer(10), new Boolean(false)},
	    {"3:00-3:30", "Joe", "Brown","Pool", new Integer(10), new Boolean(false)},
	    {"3:30-4:00", "Joe", "Brown","Pool", new Integer(10), new Boolean(false)},
	    {"4:00-4:30", "Joe", "Brown","Pool", new Integer(10), new Boolean(false)},
	    {"4:30-5:00", "Joe", "Brown","Pool", new Integer(10), new Boolean(false)}
	};

	// table is constructed using these data and columnnames: 
        final JTable table = new JTable(data, columnNames);

	// JScriollPane scrollPane = new JScrollPane(table); 
        table.setPreferredScrollableViewportSize(new Dimension(500, 70));
        table.setFillsViewportHeight(true);
 
        if (DEBUG) {
            table.addMouseListener(new MouseAdapter() {
		    public void mouseClicked(MouseEvent e) {
			printDebugData(table);
		    }
		});
        }
 
        //Create the scroll pane and add the table to it.
        JScrollPane scrollPane = new JScrollPane(table);
 
        //Add the scroll pane to this panel.
        add(scrollPane);
    }
 
    private void printDebugData(JTable table) {
        int numRows = table.getRowCount();
        int numCols = table.getColumnCount();
        javax.swing.table.TableModel model = table.getModel();
 
        System.out.println("Value of data: ");
        for (int i=0; i < numRows; i++) {
            System.out.print("    row " + i + ":");
            for (int j=0; j < numCols; j++) {
                System.out.print("  " + model.getValueAt(i, j));
            }
            System.out.println();
        }
        System.out.println("--------------------------");
    }
 
    // Create the GUI and show it.  For thread safety, this method should be invoked from the event-dispatching thread.
    private static void createAndShowGUI() {

        //Create and set up the window.
        JFrame frame = new JFrame("SimpleTableDemo");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
 
        //Create and set up the content pane.
        SimpleTableDemo newContentPane = new SimpleTableDemo();
        newContentPane.setOpaque(true); //content panes must be opaque
        frame.setContentPane(newContentPane);
 
        //Display the window.
        frame.pack();
        frame.setVisible(true);
    }
    /*
      public static void main(String[] args) {
      //Schedule a job for the event-dispatching thread:
      //creating and showing this application's GUI.
      javax.swing.SwingUtilities.invokeLater(new Runnable() {
      public void run() {
      createAndShowGUI();
      }
      });
      }  */

    // following another example to create some buttons
    public GuiApp1()
    {
	JFrame guiFrame = new JFrame();
        
	//make sure the program exits when the frame closes
	guiFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	guiFrame.setTitle("Example GUI");
	guiFrame.setSize(300,250);
      
	//This will center the JFrame in the middle of the screen    ????????????????/
	guiFrame.setLocationRelativeTo(null);
        
	//Options for the JComboBox 
	String[] LengthOptions = {"30 minutes", "1 hours", "2 hours"};
				     
	// The first JPanel contains a JLabel and JCombobox for the appointment length options
	final JPanel comboPanel = new JPanel();
	JLabel comboLbl = new JLabel("Appointment Lenth: ");
	JComboBox fruits = new JComboBox(LengthOptions);
        
	comboPanel.add(comboLbl);  // Jlabel
	comboPanel.add(fruits);    // JCombobox

	//	    JButton vegFruitBut = new JButton( "Submit Changes");
	JButton SubmitBut = new JButton( "Submit Changes");
        
	//The ActionListener class is used to handle the event that happens when the user clicks the button.
	//As there is not a lot that needs to happen we can define an anonymous inner class to make the code simpler.
	SubmitBut.addActionListener(new ActionListener()
	    {
		@Override
		    public void actionPerformed(ActionEvent event)
		{
		    //When the fruit of veg button is pressed the setVisible value of the listPanel and comboPanel is switched from true to value or vice versa.
		    listPanel.setVisible(!listPanel.isVisible());
		    comboPanel.setVisible(!comboPanel.isVisible());
		}
	    });
        
	//The JFrame uses the BorderLayout layout manager.
	//Put the two JPanels and JButton in different areas.
	guiFrame.add(comboPanel, BorderLayout.NORTH);
	guiFrame.add(listPanel, BorderLayout.CENTER);
	guiFrame.add(vegFruitBut,BorderLayout.SOUTH);
        
	//make sure the JFrame is visible
	guiFrame.setVisible(true);
    }
    /*
    //Note: Typically the main method will be in a separate class. As this is a simple one class example it's all in the one class.
    public static void main(String[] args) {
	new GuiApp1();
	}    */   

    public static void main(String[] args)
    {
	//Schedule a job for the event-dispatching thread:
	//creating and showing this application's GUI.
	javax.swing.SwingUtilities.invokeLater(new Runnable() {
		public void run() {
		    createAndShowGUI();
		}
	    });
	new GuiApp1();
    }

}