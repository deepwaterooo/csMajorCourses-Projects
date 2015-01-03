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
using System.Collections;
using System.Collections.Generic;

namespace GameThinking
{
    public class AlphaBetaAlgorithm<Move, Player>
    {
        #region Properties

        public int MaxLevel { get; set; }
        public List<Player> Players { get; set; }
        public Player ThinkingPlayer { get; set; }
        public int Calculations { get; set; }

        #endregion

        #region Constructors

        public AlphaBetaAlgorithm()
        {
            
        }

        #endregion

        #region Methods

        public MoveScore<Move> GetBestMove(ISearchable<Move, Player> searchable)
        {
            Calculations = 0;
            return GetBestMove(searchable, ThinkingPlayer, 1, double.MaxValue);
        }

        protected MoveScore<Move> GetBestMove(ISearchable<Move, Player> searchable, Player currentPlayer, int level, double noBetterThan)
        {
            Player nextPlayer = GetNextPlayer(currentPlayer);
            MoveScore<Move> bestMove = new MoveScore<Move>();
            bestMove.Score = double.MinValue;
            
            foreach (Move move in searchable.GetAvailableMoves(currentPlayer))
            {
                ISearchable<Move, Player> newSearchable = searchable.DoMove(currentPlayer, move);

                //Calculate score
                double score;
                if ((level != MaxLevel) && (newSearchable.GetAvailableMoves(nextPlayer).GetEnumerator().MoveNext()))
                {
                    //Get the move for next player
                    if (nextPlayer.Equals(ThinkingPlayer))
                        score = GetBestMove(newSearchable, nextPlayer, level + 1, bestMove.Score).Score;
                    else
                        score = GetWorstMove(newSearchable, nextPlayer, level + 1, bestMove.Score).Score;
                }
                else
                {
                    //Calculate leaf score
                    score = newSearchable.CalculateScore(ThinkingPlayer);
                    Calculations++;
                }

                newSearchable.UndoMove(currentPlayer, move);

                //Evaluate score
                if (score >= bestMove.Score)
                {
                    bestMove.Move = move;
                    bestMove.Score = score;

                    if (score > noBetterThan)
                    {
                        return bestMove;
                    }
                }
            }

            if (bestMove.Move == null)
            {
                //There was no moves available in this turn (usually because game is over before the max level is reached)
                bestMove.Score = searchable.CalculateScore(ThinkingPlayer);
            }

            return bestMove;
        }

        protected MoveScore<Move> GetWorstMove(ISearchable<Move, Player> searchable, Player currentPlayer, int level, double noWorseThan)
        {
            Player nextPlayer = GetNextPlayer(currentPlayer);
            MoveScore<Move> worseMove = new MoveScore<Move>();
            worseMove.Score = double.MaxValue;

            foreach (Move move in searchable.GetAvailableMoves(currentPlayer))
            {
                ISearchable<Move, Player> newSearchable = searchable.DoMove(currentPlayer, move);

                //Calculate score
                double score;
                if ((level != MaxLevel) && (newSearchable.GetAvailableMoves(nextPlayer).GetEnumerator().MoveNext()))
                {
                    //Get the move for next player
                    if (nextPlayer.Equals(ThinkingPlayer))
                        score = GetBestMove(newSearchable, nextPlayer, level + 1, worseMove.Score).Score;
                    else
                        score = GetWorstMove(newSearchable, nextPlayer, level + 1, worseMove.Score).Score;
                }
                else
                {
                    //Calculate leaf score
                    score = newSearchable.CalculateScore(ThinkingPlayer);
                    Calculations++;
                }

                newSearchable.UndoMove(currentPlayer, move);

                //Evaluate score
                if (score <= worseMove.Score)
                {
                    worseMove.Move = move;
                    worseMove.Score = score;

                    if (score < noWorseThan)
                    {
                        return worseMove;
                    }
                }
            }

            if (worseMove.Move == null)
            {
                //There was no moves available in this turn (usually because game is over before the max level is reached)
                worseMove.Score = searchable.CalculateScore(ThinkingPlayer);
            }

            return worseMove;
        }

        protected Player GetNextPlayer(Player currentPlayer)
        {
            int index = Players.IndexOf(currentPlayer);
            index++;
            if (index >= Players.Count)
                index = 0;

            return Players[index];
        }

        #endregion
    }
}
