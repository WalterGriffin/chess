# does user input tings and displaying
import pygame as p
from Chess import engine

p.init()
WIDTH = HEIGHT = 512
DIMENSION = 8
SQ_SIZE = HEIGHT // DIMENSION
MAX_FPS = 15
IMAGES = {}

# loads images
def loadImages():
    pieces = ["bRook", "bKnight", "bBishop", "bQueen", "bKing", "bPawn", "wPawn", "wRook", "wKnight", "wBishop", "wQueen", "wKing"]
    for piece in pieces:
        IMAGES[piece] = p.transform.scale(p.image.load("ChessPieces/" + piece + ".png"), (SQ_SIZE, SQ_SIZE))

# main driver. deals with user input + graphics
def main():
    p.init()
    screen = p.display.set_mode((WIDTH, HEIGHT))
    clock = p.time.Clock()
    screen.fill(p.Color("white"))
    gs = engine.GameState()
    loadImages()
    running = True
    sqSelected = () # no square selected initially. tuple (row, col) that keeps track of user's last click
    playerClicks = [] # keep track of player clicks. 2 tuples
    while running:
        for e in p.event.get():
            if e.type == p.QUIT:
                running = False
            # mouse handler
            elif e.type == p.MOUSEBUTTONDOWN:
                location = p.mouse.get_pos() #xy location of mouse
                col = location[0]//SQ_SIZE
                row = location[1]//SQ_SIZE
                if sqSelected == (row, col): # user clicked same square twice
                    sqSelected = () # deselect
                    playerClicks = [] # clear player clicks
                else:
                    sqSelected = (row, col)
                    playerClicks.append(sqSelected) # append for 1st and 2nd clicks
                if len(playerClicks) == 2: # after 2nd click
                    move = engine.Move(playerClicks[0], playerClicks[1], gs.board)
                    print(move.getChessNotation())
                    gs.makeMove(move)
                    sqSelected = () # reset user clicks
                    playerClicks = []
            # key handler
            elif e.type == p.KEYDOWN:
                if e.key == p.K_z: # undo when z is pressed
                    gs.undoMove()

        drawGameState(screen, gs)
        clock.tick(MAX_FPS)
        p.display.flip()

# graphics during current state
def drawGameState(screen, gs):
    drawBoard(screen)
    drawPieces(screen, gs.board)

# makes square/board
def drawBoard(screen):
    colors = [p.Color("white"), p.Color("gray")]
    for r in range(DIMENSION):
        for c in range(DIMENSION):
            color = colors[((r+c) % 2)]
            p.draw.rect(screen, color, p.Rect(c*SQ_SIZE, r*SQ_SIZE, SQ_SIZE, SQ_SIZE))

# makes pieces on board
def drawPieces(screen, board):
    for r in range(DIMENSION):
        for c in range(DIMENSION):
            piece = board[r][c]
            if piece != "--": #not blank
                screen.blit(IMAGES[piece], p.Rect(c*SQ_SIZE, r*SQ_SIZE, SQ_SIZE, SQ_SIZE))

if __name__ == "__main__":
    main()




# will go in main later

def main ():
 player1 = input("Welcome to chess! What would you like your name to be? ")
 print("Welcome, " + player1 + "!")
 player2 = input("What is the second player's name? ")
 if player2 == player1:
   print("Sorry, but both players cannot have the same name.")
 else:
   print("Welcome, " + player2 + "!")
 timechosen = input("In minutes, how long would you like your chess match to be? ")
 if timechosen == "0":
   print("Sorry, but you cannot input that time.")
 if timechosen != int:
   pass
 turntime = input("Okay, in seconds, what is the maximum time that each turn should take? ")
 if turntime == "0":
   print("Sorry, but you cannot input that time.")
 firstm = input("Which player is going first? ")
 if firstm == player1 or player2:
   print("Okay, " + firstm + " is going first.")
 else:
   print("The name of the player you entered was invalid.")
 chesstype1 = input("For your chess pieces, would you like a wooden design? ")
 if chesstype1 == "yes" or "Yes":
   print("The chess pieces will have a wooden design.")
 else:
   chesstype2 = input("Would you like to have a modern design instead? ")
   if chesstype2 == "yes" or "Yes":
    print("The chess pieces will have a modern design.")
   else:
     print("There are no more designs to choose from.")
main()




# stores all data abt current chess game. will determine valid moves
class GameState():
    def __init__(self):
        # board is 8 by 8 list. "--" means empty space
        self.board = [
            ["bRook", "bKnight", "bBishop", "bQueen", "bKing", "bBishop", "bKnight", "bRook"],
            ["bPawn", "bPawn", "bPawn", "bPawn", "bPawn", "bPawn", "bPawn", "bPawn"],
            ["--", "--", "--", "--", "--", "--", "--", "--"],
            ["--", "--", "--", "--", "--", "--", "--", "--"],
            ["--", "--", "--", "--", "--", "--", "--", "--"],
            ["--", "--", "--", "--", "--", "--", "--", "--"],
            ["wPawn", "wPawn", "wPawn", "wPawn", "wPawn", "wPawn", "wPawn", "wPawn"],
            ["wRook", "wKnight", "wBishop", "wQueen", "wKing", "wBishop", "wKnight", "wRook"]]
        self.whiteToMove = True
        self.moveLog = []

    # takes move as parameter and executes it. won't for 4 castling, pawn promotion, and en passant
    def makeMove(self, move):
        self.board[move.startRow][move.startCol] = "--"
        self.board[move.endRow][move.endCol] = move.pieceMoved
        self.moveLog.append(move) # log move so we can undo it later
        self.whiteToMove = not self.whiteToMove # swap players

    #will undo the last move made
    def undoMove(self):
        if len(self.moveLog) !=0: # make sure that there is move 2 undo
            move = self.moveLog.pop()
            self.board[move.startRow][move.startCol] = move.pieceMoved
            self.board[move.endRow][move.endCol] = move.pieceCaptured
            self.whiteToMove = not self.whiteToMove # switch turns back

class Move():
    # maps keys to values
    # key : value
    ranksToRows = {"1": 7, "2": 6, "3": 5, "4": 4,
                   "5": 3, "6": 2, "7": 1, "8": 0}
    rowsToRanks = {v: k for k, v in ranksToRows.items()}
    filesToCols = {"a": 0, "b": 1, "c": 2, "d": 3,
                   "e": 4, "f": 5, "g": 6, "h": 7}
    colsToFiles = {v: k for k, v in filesToCols.items()}

    def __init__(self, startSq, endSq, board):
        self.startRow = startSq[0]
        self.startCol = startSq[1]
        self.endRow = endSq[0]
        self.endCol = endSq[1]
        self.pieceMoved = board[self.startRow][self.startCol]
        self.pieceCaptured = board[self.endRow][self.endCol]

    def getChessNotation(self):
        return self.getRankFile(self.startRow, self.startCol) + self.getRankFile(self.endRow, self.endCol)

    def getRankFile(self, r, c):
        return self.colsToFiles[c] + self.rowsToRanks[r]
