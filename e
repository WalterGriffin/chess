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
