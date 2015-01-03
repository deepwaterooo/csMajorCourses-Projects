using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using Connect4Core;

namespace Connect4
{
    public partial class Page : UserControl
    {
        public Page()
        {
            InitializeComponent();
        }

        private void btnNewGame_Click(object sender, RoutedEventArgs e)
        {
            board.NewGame();
        }

        private void sliderLevel_ValueChanged(object sender, RoutedPropertyChangedEventArgs<double> e)
        {
            if(board!=null)
                board.level = (int)e.NewValue;
        }
    }
}
