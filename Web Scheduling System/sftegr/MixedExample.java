/*
 * (swing1.1beta3)
 */
 
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.table.*;
import javax.swing.border.*;

import jp.gr.java_conf.tame.swing.table.*;
import jp.gr.java_conf.tame.swing.colorchooser.*;



/**
 * @version 1.0 11/22/98
 */
public class MixedExample extends JFrame {

  public MixedExample() {
    super( "Mixed Example" ); 
    
    AttributiveCellTableModel ml = new AttributiveCellTableModel(20,5) {
      public Object getValueAt(int row, int col) { 
        return "" + row + ","+ col; 
      }
    };
    CellAttribute cellAtt = ml.getCellAttribute();
    MultiSpanCellTable table = new MultiSpanCellTable( ml );
    table.setCellSelectionEnabled(true);
    table.setSelectionMode(ListSelectionModel.SINGLE_INTERVAL_SELECTION);
    table.setDefaultRenderer(Object.class ,new AttributiveCellRenderer());
    JScrollPane scroll = new JScrollPane( table );

    ColorPanel colorPanel = new ColorPanel(table,(ColoredCell)cellAtt);
    FontPanel   fontPanel = new FontPanel(table, (CellFont)cellAtt);
    SpanPanel   spanPanel = new SpanPanel(table, (CellSpan)cellAtt);
    Box boxAtt = new Box(BoxLayout.Y_AXIS);
    boxAtt.add(colorPanel);
    boxAtt.add(fontPanel);
    boxAtt.add(spanPanel);
    
    Box box = new Box(BoxLayout.X_AXIS);
    box.add(scroll);
    box.add(new JSeparator(SwingConstants.HORIZONTAL));
    box.add(boxAtt);
    getContentPane().add( box );
    setSize( 400, 300 );
    setVisible(true);
  }

  class ColorPanel extends JPanel {
    JTable table;
    ColoredCell cellAtt;
    ColorPanel(final JTable table, final ColoredCell cellAtt) {
      this.table   = table;
      this.cellAtt = cellAtt;
      setLayout(new GridLayout(2,1));
      setBorder(BorderFactory.createTitledBorder("Color"));
      JButton b_fore   = new JButton("Foreground");
      b_fore.addActionListener(new ActionListener() {
        public void actionPerformed(ActionEvent e) {
          changeColor(true);
        }
      });
      JButton b_back   = new JButton("Background");
      b_back.addActionListener(new ActionListener() {
        public void actionPerformed(ActionEvent e) {
          changeColor(false);
        }
      });
      JPanel p_buttons = new JPanel();
      add(b_fore);
      add(b_back);
    }
  
    private final void changeColor(boolean isForeground) {
      int[] columns = table.getSelectedColumns();
      int[] rows    = table.getSelectedRows();
      if ((rows == null) || (columns == null)) return;
      if ((rows.length<1)||(columns.length<1)) return;
      Color target    = cellAtt.getForeground(rows[0], columns[0]);
      Color reference = cellAtt.getBackground(rows[0], columns[0]);
      for (int i=0;i<rows.length;i++) {
        int row = rows[i];
        for (int j=0;j<columns.length;j++) {
	  int column = columns[j];
	  target    = (target    != cellAtt.getForeground(row, column)) ?
	    null : target;
	  reference = (reference != cellAtt.getBackground(row, column)) ?
	    null : reference;
        }
      }
      String title;
      if (isForeground) {
        target    = (target   !=null) ? target    : table.getForeground();
        reference = (reference!=null) ? reference : table.getBackground();
        title = "Foreground Color";
      } else {
        target    = (reference!=null) ? reference : table.getBackground();
        reference = (target   !=null) ? target    : table.getForeground();
        title = "Foreground Color";
      }	
      TextColorChooser chooser =
        new TextColorChooser(target, reference, isForeground);
      Color color = chooser.showDialog(MixedExample.this,title);
      if (color != null) {	
        if (isForeground) {
	  cellAtt.setForeground(color, rows, columns);
        } else {
	  cellAtt.setBackground(color, rows, columns);
        }
        table.clearSelection();
        table.revalidate();
        table.repaint();	  
      }
    }
  }

  class FontPanel extends JPanel {
    String[] str_size  = {"10","12","14","16","20"};
    String[] str_style = {"PLAIN","BOLD","ITALIC"};
    JComboBox name,style,size;

    FontPanel(final JTable table, final CellFont cellAtt) {
      setLayout(new BorderLayout());
      setBorder(BorderFactory.createTitledBorder("Font"));
      Box box = new Box(BoxLayout.X_AXIS);
      JPanel p2 = new JPanel(new GridLayout(3,1));
      JPanel p3 = new JPanel(new GridLayout(3,1));
      JPanel p4 = new JPanel(new BorderLayout());
      p2.add(new JLabel("Name:"));
      p2.add(new JLabel("Style:"));    
      p2.add(new JLabel("Size:"));
      Toolkit toolkit = Toolkit.getDefaultToolkit();
      name  = new JComboBox(toolkit.getFontList());
      style = new JComboBox(str_style);
      size  = new JComboBox(str_size);
      size.setEditable(true);
      JButton b_apply   = new JButton("Apply");
      b_apply.addActionListener(new ActionListener() {
        public void actionPerformed(ActionEvent e) {
          int[] columns = table.getSelectedColumns();
          int[] rows    = table.getSelectedRows();
          if ((rows == null) || (columns == null)) return;
          if ((rows.length<1)||(columns.length<1)) return;
          Font font = new Font((String)name.getSelectedItem(),
                              style.getSelectedIndex(),
              Integer.parseInt((String)size.getSelectedItem()));
          cellAtt.setFont(font, rows, columns);
          table.clearSelection();
          table.revalidate();
          table.repaint();	  
        }
      });
      p3.add(name);
      p3.add(style);
      p3.add(size);
      p4.add(BorderLayout.CENTER,b_apply);
      box.add(p2);
      box.add(p3);
      add(BorderLayout.CENTER,box);
      add(BorderLayout.SOUTH, p4);
    }
  }

  class SpanPanel extends JPanel {
    JTable table;
    CellSpan cellAtt;
    SpanPanel(final JTable table, final CellSpan cellAtt) {
      this.table   = table;
      this.cellAtt = cellAtt;
      setLayout(new GridLayout(2,1));
      setBorder(BorderFactory.createTitledBorder("Span"));
      JButton b_one   = new JButton("Combine");
      b_one.addActionListener(new ActionListener() {
        public void actionPerformed(ActionEvent e) {
	  int[] columns = table.getSelectedColumns();
	  int[] rows    = table.getSelectedRows();
	  cellAtt.combine(rows,columns);
	  table.clearSelection();
	  table.revalidate();
	  table.repaint();
        }
      });
      JButton b_split = new JButton("Split");
      b_split.addActionListener(new ActionListener() {
        public void actionPerformed(ActionEvent e) {
	  int column = table.getSelectedColumn();
	  int row    = table.getSelectedRow();
	  cellAtt.split(row,column);
	  table.clearSelection();
	  table.revalidate();
	  table.repaint();
        }
      });
      add(b_one);
      add(b_split);
    }
  }
  
  public static void main(String[] args) {
    MixedExample frame = new MixedExample();
    frame.addWindowListener( new WindowAdapter() {
      public void windowClosing( WindowEvent e ) {
        System.exit(0);
      }
    });
  }
}

