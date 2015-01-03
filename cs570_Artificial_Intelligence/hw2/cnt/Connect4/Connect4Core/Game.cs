using System;
using System.Collections;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using GameThinking;
using System.Collections.Generic;

namespace Connect4Core
{
    public class Game : ISearchable<int, Color>
    {
        const double scoreTwo = 10;
        const double scoreThree = 40;
        
        #region Properties

        public int Width { get; set; }
        public int Height { get; set; }
        public Board MainBoard { get; set; }
        public Board ThinkingBoard { get; set; }
        public List<Color> Players { get; set; }

        #endregion

        #region Constructor

        public Game():this(7,6)
        {

        }

        public Game(int width, int height)
        {
            Width = width;
            Height = height;
            MainBoard = new Board(width, height);
            
            Players = new List<Color>();
            Players.Add(Color.Yellow);
            Players.Add(Color.Red);
        }

        #endregion

        #region Methods

        public int GetBestMove(int maxLevel)
        {
            ThinkingBoard = new Board(MainBoard);

            AlphaBetaAlgorithm<int, Color> alg = new AlphaBetaAlgorithm<int, Color>();
            alg.MaxLevel = maxLevel;
            alg.Players = Players;
            alg.ThinkingPlayer = MainBoard.CurrentTurn;

            return (int)alg.GetBestMove(this).Move;
        }

        protected double CalculateOportunitiesByPlayer(Color player)
        {
            double score = 0;

            for (int x = 0; x < Width; x++)
            {
                for (int y = 0; y < Height; y++)
                {
                    if (ThinkingBoard.Holes[x, y] == Color.Free)
                    {
                        //Vertical 2
                        if (y < Height - 2)
                        {
                            if ((ThinkingBoard.Holes[x, y + 1] == player) && (ThinkingBoard.Holes[x, y + 2] == player))
                                score += scoreTwo;
                        }

                        //Vertical 2~
                        if (y >=2)
                        {
                            if ((ThinkingBoard.Holes[x, y - 1] == player) && (ThinkingBoard.Holes[x, y - 2] == player))
                                score += scoreTwo;
                        }

                        //Horizontal 2
                        if (x < Width - 2)
                        {
                            if ((ThinkingBoard.Holes[x + 1, y] == player) && (ThinkingBoard.Holes[x + 2, y] == player))
                                score += scoreTwo;

                            //Diagonal 2
                            if (y < Height - 2)
                            {
                                if ((ThinkingBoard.Holes[x + 1, y+1] == player) && (ThinkingBoard.Holes[x + 2, y+2] == player))
                                    score += scoreTwo;
                            }

                            if (y >= 2)
                            {
                                if ((ThinkingBoard.Holes[x + 1, y - 1] == player) && (ThinkingBoard.Holes[x + 2, y - 2] == player))
                                    score += scoreTwo;
                            }
                        }

                        //Horizontal 2~
                        if (x >= 2)
                        {
                            if ((ThinkingBoard.Holes[x - 1, y] == player) && (ThinkingBoard.Holes[x - 2, y] == player))
                                score += scoreTwo;

                            //Diagonal 2~
                            if (y < Height - 2)
                            {
                                if ((ThinkingBoard.Holes[x - 1, y + 1] == player) && (ThinkingBoard.Holes[x - 2, y + 2] == player))
                                    score += scoreTwo;
                            }

                            if (y >= 2)
                            {
                                if ((ThinkingBoard.Holes[x - 1, y - 1] == player) && (ThinkingBoard.Holes[x - 2, y - 2] == player))
                                    score += scoreTwo;
                            }
                        }

                        //Vertical 3
                        if (y < Height - 3)
                        {
                            if ((ThinkingBoard.Holes[x, y + 1] == player) && (ThinkingBoard.Holes[x, y + 2] == player) && (ThinkingBoard.Holes[x, y + 3] == player))
                                score += scoreThree;
                        }

                        //Vertical 3~
                        if (y >= 3)
                        {
                            if ((ThinkingBoard.Holes[x, y - 1] == player) && (ThinkingBoard.Holes[x, y - 2] == player) && (ThinkingBoard.Holes[x, y - 3] == player))
                                score += scoreThree;
                        }

                        //Horizontal 3
                        if (x < Width - 3)
                        {
                            if ((ThinkingBoard.Holes[x + 1, y] == player) && (ThinkingBoard.Holes[x + 2, y] == player) && (ThinkingBoard.Holes[x +3, y] == player))
                                score += scoreThree;

                            //Diagonal 3
                            if (y < Height - 3)
                            {
                                if ((ThinkingBoard.Holes[x + 1, y + 1] == player) && (ThinkingBoard.Holes[x + 2, y + 2] == player) && (ThinkingBoard.Holes[x + 3, y + 3] == player))
                                    score += scoreThree;
                            }

                            if (y >= 3)
                            {
                                if ((ThinkingBoard.Holes[x + 1, y - 1] == player) && (ThinkingBoard.Holes[x + 2, y - 2] == player) && (ThinkingBoard.Holes[x + 3, y - 3] == player))
                                    score += scoreThree;
                            }
                        }

                        //Horizontal 3~
                        if (x >= 3)
                        {
                            if ((ThinkingBoard.Holes[x - 1, y] == player) && (ThinkingBoard.Holes[x - 2, y] == player) && (ThinkingBoard.Holes[x - 3, y] == player))
                                score += scoreThree;

                            //Diagonal 3~
                            if (y < Height - 3)
                            {
                                if ((ThinkingBoard.Holes[x - 1, y + 1] == player) && (ThinkingBoard.Holes[x - 2, y + 2] == player) && (ThinkingBoard.Holes[x - 3, y + 3] == player))
                                    score += scoreThree;
                            }

                            if (y >= 3)
                            {
                                if ((ThinkingBoard.Holes[x - 1, y - 1] == player) && (ThinkingBoard.Holes[x - 2, y - 2] == player) && (ThinkingBoard.Holes[x - 3, y - 3] == player))
                                    score += scoreThree;
                            }
                        }
                    }
                }
            }

            return score;
        }

        #endregion

        #region ISearchable Members

        public List<int> GetAvailableMoves(Color player)
        {
            return ThinkingBoard.GetPossibleMoves();
        }

        public double CalculateScore(Color player)
        {
            Color computer=(Color)player;
            
            //Check winning conditions first
            if (ThinkingBoard.GameOver)
            {
                if (ThinkingBoard.IsWinner(Color.Red))
                {
                    if (computer.Equals(Color.Red))
                        return double.MaxValue;
                    else
                        return double.MinValue;
                }

                if (ThinkingBoard.IsWinner(Color.Yellow))
                {
                    if (computer.Equals(Color.Yellow))
                        return double.MaxValue;
                    else
                        return double.MinValue;
                }
            }

            //Calculate scores
            if (computer == Color.Yellow)
                return CalculateOportunitiesByPlayer(Color.Yellow) - CalculateOportunitiesByPlayer(Color.Red);
            else
                return CalculateOportunitiesByPlayer(Color.Red) - CalculateOportunitiesByPlayer(Color.Yellow);
        }

        public ISearchable<int, Color> DoMove(Color player, int move)
        {
            ThinkingBoard.DoMove(move);
            return this;
        }

        public ISearchable<int, Color> UndoMove(Color player, int move)
        {
            ThinkingBoard.UndoMove();
            return this;
        }

        #endregion
    }
}
