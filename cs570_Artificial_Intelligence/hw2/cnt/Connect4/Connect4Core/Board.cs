using System;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using System.Collections.Generic;
using System.Text;

namespace Connect4Core
{
    public class Board
    {
        #region Properties

        public int Width { get; set; }
        public int Height { get; set; }
        public Color[,] Holes { get; set; }
        public Color CurrentTurn { get; set; }
        public Stack<int> MoveHistory { get; set; }
        public bool GameOver { get; set; }
        
        #endregion

        #region Events

        public event EventHandler BoardChanged;

        #endregion

        #region Constructors

        public Board(int width, int height)
        {
            Width = width;
            Height = height;
            CurrentTurn = Color.Yellow;
            MoveHistory = new Stack<int>();
            GameOver = false;

            Holes = new Color[Width, Height];

            for (int y = 0; y < Height; y++)
            {
                for (int x = 0; x < Width; x++)
                {
                    Holes[x, y] = Color.Free;
                }
            }
        }

        public Board(Board board)
        {
            Width = board.Width;
            Height = board.Height;
            CurrentTurn = board.CurrentTurn;
            MoveHistory = new Stack<int>();
            GameOver = board.GameOver;

            Holes = new Color[Width, Height];

            for (int y = 0; y < Height; y++)
            {
                for (int x = 0; x < Width; x++)
                {
                    Holes[x, y] = board.Holes[x, y];
                }
            }
        }

        #endregion

        #region Methods

        public List<int> GetPossibleMoves()
        {
            List<int> result = new List<int>();

            if (GameOver == false)
            {
                for (int x = 0; x < Width; x++)
                {
                    if (Holes[x, 0] == Color.Free)
                        result.Add(x);
                }
            }

            return result;
        }

        public void DoMove(int x)
        {
            for (int y = Height - 1; y >= 0; y--)
            {
                if (Holes[x, y] == Color.Free)
                {
                    Holes[x, y] = CurrentTurn;
                    MoveHistory.Push(x);

                    if (IsWinner(CurrentTurn))
                    {
                        GameOver = true;
                    }

                    ToggleTurn();
                    
                    if (BoardChanged != null)
                        BoardChanged(this, null);

                    return;
                }
            }
        }

        public void UndoMove()
        {
            int x = MoveHistory.Pop();
            for (int y = 0; y <Height; y++)
            {
                if (Holes[x, y] != Color.Free)
                {
                    Holes[x, y] = Color.Free;
                    GameOver = false;
                    ToggleTurn();

                    if (BoardChanged != null)
                        BoardChanged(this, null);

                    return;
                }
            }
        }

        public void ToggleTurn()
        {
            if (CurrentTurn == Color.Red)
                CurrentTurn = Color.Yellow;
            else
                CurrentTurn = Color.Red;
        }

        public bool IsWinner(Color player)
        {
            //Horizontal
            for (int y = 0; y < Height; y++)
            {
                for (int x = 0; x < Width-3; x++)
                {
                    if ((Holes[x, y] == player) && (Holes[x + 1, y] == player) && (Holes[x + 2, y] == player) && (Holes[x + 3, y] == player))
                        return true;
                }
            }

            //Vertical
            for (int y = 0; y < Height - 3; y++)
            {
                for (int x = 0; x < Width; x++)
                {
                    if ((Holes[x, y] == player) && (Holes[x, y + 1] == player) && (Holes[x, y + 2] == player) && (Holes[x, y + 3] == player))
                        return true;
                }
            }

            //Diagonal
            for (int y = 0; y < Height - 3; y++)
            {
                for (int x = 0; x < Width - 3; x++)
                {
                    if ((Holes[x, y] == player) && (Holes[x + 1, y + 1] == player) && (Holes[x + 2, y + 2] == player) && (Holes[x + 3, y + 3] == player))
                        return true;
                }
            }
            
            //Diagonal
            for (int y = 0; y < Height - 3; y++)
            {
                for (int x = 3; x < Width; x++)
                {
                    if ((Holes[x, y] == player) && (Holes[x - 1, y + 1] == player) && (Holes[x - 2, y + 2] == player) && (Holes[x - 3, y + 3] == player))
                        return true;
                }
            }
            
            return false;
        }

        public override string ToString()
        {
            StringBuilder result = new StringBuilder();
            for (int y = 0; y < Height; y++)
            {
                for (int x = 0; x < Width; x++)
                {
                    switch (Holes[x,y])
                    {
                        case Color.Free:
                            result.Append("|0");
                            break;
                        case Color.Yellow:
                            result.Append("|1");
                            break;
                        case Color.Red:
                            result.Append("|2");
                            break;
                    }
                }
                result.AppendLine();
            }

            return result.ToString();
        }

        #endregion
    }
}
