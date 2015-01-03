# http://stackoverflow.com/questions/14115253/python-alpha-beta-minimax-for-connect-4

def alphaBeta(myBoard, column, depth, alpha, beta, player):
    parent = board()
    for r in range(ROWS):
        for c in range(COLUMNS):
            parent.board[r][c] = myBoard.board[r][c]
    parent.move(column, player)
    if parent.isFull() or parent.isWon()[0] or depth <= 0:
        if parent.isFull(): return 0
        if parent.isWon()[1] == player: return float('inf')
        elif parent.isWon()[0]: return -1*float('inf')
        else: return statScore(parent, player)
    if player == "O":
        for child in range(COLUMNS):
            alpha = max(alpha, alphaBeta(parent, child, depth-1, alpha, beta, "X"))
            if beta <= alpha:
                break
        return alpha
    else:
        for child in range(COLUMNS):
            beta = min(beta, alphaBeta(parent, child, depth-1, alpha, beta, "O"))
            if beta <= alpha:
                break
        return beta

def ai(myBoard, depth):
    output = []
    bestScore = float('inf')
    for column in range(COLUMNS):
        if myBoard.isValid(column):
            score = alphaBeta(myBoard, column, depth, -1*float('inf'), float('inf'), "O")
            if score < bestScore:
                output = [column]
                bestScore = score
            elif score == bestScore:
                output.append(column)
    move = random.choice(output)
    return move
