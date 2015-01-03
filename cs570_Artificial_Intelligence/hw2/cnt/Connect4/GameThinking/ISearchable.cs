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
    public interface ISearchable<Move, Player>
    {
        List<Move> GetAvailableMoves(Player player);
        double CalculateScore(Player player);
        ISearchable<Move, Player> DoMove(Player player, Move move);
        ISearchable<Move, Player> UndoMove(Player player, Move move);
    }
}
