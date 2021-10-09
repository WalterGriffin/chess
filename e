# does user input tings and displaying
import pygame as p
from Chess import engine

p.init()
WIDTH = HEIGHT = 512
DIMENSION = 8
SQ_SIZE = HEIGHT // DIMENSION
MAX_FPS = 15
IMAGES = {}
def loadImages():
    pieces = ["bRook", "bKnight", "bBishop", "bQueen", "bKing", "bPawn", "wPawn", "wRook", "wKnight", "wBishop", "wQueen", "wKing"]
    for piece in pieces:
        IMAGES[piece] = p.transform.scale(p.image.load("ChessPieces/" + piece + ".png"), (SQ_SIZE, SQ_SIZE))
# main driver. user input + graphics
def main():
    p.init()
    screen = p.display.set_mode((WIDTH, HEIGHT))
    clock = p.time.Clock()
    screen.fill(p.Color("white"))
    gs = engine.GameState()
    loadImages()
    running = True
    while running:
        for e in p.event.get():
            if e.type == p.QUIT:
                running = False
        drawGameState(screen, gs)
        clock.tick(MAX_FPS)
        p.display.flip()
def drawGameState(screen, gs):
    drawBoard(screen)
    drawPieces(screen, gs.board)
def drawBoard(screen):
    colors = [p.Color("white"), p.Color("gray")]
    for r in range(DIMENSION):
        for c in range(DIMENSION):
            color = colors[((r+c) % 2)]
            p.draw.rect(screen, color, p.Rect(c*SQ_SIZE, r*SQ_SIZE, SQ_SIZE, SQ_SIZE))

def drawPieces(screen, board):
    pass

if __name__ == "__main__":
    main()
# will go into main later




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
