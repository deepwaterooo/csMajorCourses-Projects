using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using System.ComponentModel;

namespace Connect4
{
	public partial class Board : UserControl
	{
        Ellipse[,] holes = new Ellipse[7, 6];
        SolidColorBrush blackBrush = new SolidColorBrush(Color.FromArgb(255, 0, 0, 0));
        SolidColorBrush whiteBrush = new SolidColorBrush(Color.FromArgb(255, 255, 255, 255));
        SolidColorBrush borderBrush = new SolidColorBrush(Color.FromArgb(255, 28, 12, 124));
        SolidColorBrush yellowBrush = new SolidColorBrush(Color.FromArgb(255, 238, 246, 14));
        SolidColorBrush redBrush = new SolidColorBrush(Color.FromArgb(255, 246, 14, 14));
        BackgroundWorker worker;

        public Connect4Core.Game game = new Connect4Core.Game();
        public int level=2;

        int currentX;
        int currentY;
        
		public Board()
		{
			// Required to initialize variables
			InitializeComponent();

            for (int y = 0; y < 6; y++)
            {
                for (int x = 0; x < 7; x++)
                {
                    Ellipse ellipse = new Ellipse();
                    ellipse.Width = 32;
                    ellipse.Height = 32;
                    ellipse.Fill=blackBrush;
                    ellipse.Stroke = borderBrush;
                    ellipse.StrokeThickness = 3;
                    Canvas.SetLeft(ellipse, 2 + x * 35);
                    Canvas.SetTop(ellipse, 2 + y * 35);

                    holes[x, y] = ellipse;

                    LayoutRoot.Children.Add(ellipse);
                }
            }

            NewGame();
        }

        #region Methods

        public void NewGame()
        {
            game.MainBoard = new Connect4Core.Board(7, 6);
            game.MainBoard.BoardChanged += new EventHandler(MainBoard_BoardChanged);

            if (worker != null)
            {
                worker.RunWorkerCompleted -= new RunWorkerCompletedEventHandler(worker_RunWorkerCompleted);
            }

            worker = new BackgroundWorker();
            worker.DoWork +=new DoWorkEventHandler(worker_DoWork);
            worker.RunWorkerCompleted+=new RunWorkerCompletedEventHandler(worker_RunWorkerCompleted);
            
            RefreshBoard();
        }        

        public void RefreshBoard()
        {
            for (int yy = 5; yy >= 0; yy--)
            {
                if (game.MainBoard.Holes[currentX, yy] == Connect4Core.Color.Free)
                {
                    currentY = yy;
                    break;
                }
            }

            for (int y = 0; y < 6; y++)
            {
                for (int x = 0; x < 7; x++)
                {
                    if ((x == currentX) && (y == currentY) && (game.MainBoard.GameOver == false) && (game.MainBoard.CurrentTurn == Connect4Core.Color.Yellow))
                        holes[x, y].Stroke = whiteBrush;
                    else
                        holes[x, y].Stroke = borderBrush;
                }
            }

            for (int y = 0; y < 6; y++)
            {
                for (int x = 0; x < 7; x++)
                {
                    switch (game.MainBoard.Holes[x, y])
                    {
                        case Connect4Core.Color.Free:
                            holes[x, y].Fill = blackBrush;
                            break;
                        case Connect4Core.Color.Yellow:
                            holes[x, y].Fill = yellowBrush;
                            break;
                        case Connect4Core.Color.Red:
                            holes[x, y].Fill = redBrush;
                            break;
                    }
                }
            }
        }

        #endregion

        #region Events

        private void worker_DoWork(object sender, DoWorkEventArgs e)
        {
            try
            {
                switch (level)
                {
                    case 1:
                        e.Result = game.GetBestMove(7);
                        break;

                    case 2:
                        e.Result = game.GetBestMove(5);
                        break;

                    case 3:
                        e.Result = game.GetBestMove(3);
                        break;
                }

            }
            catch
            { }
        }

        private void worker_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            game.MainBoard.DoMove((int)e.Result);
        }

        private void MainBoard_BoardChanged(object sender, EventArgs e)
        {
            RefreshBoard();
        }

        private void LayoutRoot_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            if ((game.MainBoard.GameOver == false) && (game.MainBoard.CurrentTurn == Connect4Core.Color.Yellow))
            {
                currentX = (int)(e.StylusDevice.GetStylusPoints(LayoutRoot)[0].X / 35.0);
                if (currentX < 0)
                    currentX = 0;
                if (currentX > 6)
                    currentX = 6;

                currentY = -1;

                game.MainBoard.DoMove(currentX);

                if (game.MainBoard.GameOver == false)
                    worker.RunWorkerAsync();
            }
        }

        private void LayoutRoot_MouseMove(object sender, MouseEventArgs e)
        {
            currentX = (int)(e.StylusDevice.GetStylusPoints(LayoutRoot)[0].X / 35.0);
            if (currentX < 0)
                currentX = 0;
            if (currentX > 6)
                currentX = 6;

            currentY = -1;

            RefreshBoard();
        }

        #endregion
    }
}