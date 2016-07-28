1. Game is displayed
2. Hint is displayed
3. Player and computer start at $0
4. Player spins
   a. If player spins and the result is bankrupt, his money goes to 0
   	  then computer's turn
   b. If player spins and the result is Lose a turn, then it becomes
      the computer's turn.
   c. If the player spins and gets a money value, it should be set to a
      variable that stores it as pending money.
5. Ask if player wants pick a letter or guess the phrase
   a. Player picks a letter
      1. Player cannot pick a vowel if he has less than $250
      2. If letter is guessed correctly, then pending money is added to
         player's money
   	      i. Display the game
   	      ii. Display the hint
   	      iii. Player goes again until player is wrong
   	      iv. If game over, compare score and declare winner
   	  3. If letter picked was a vowel, subtract 250 from player's money
   	  4. If the the letter is incorrect,
      	 i. update player score
      	 ii. computer turn
      5. letter is removed from list of available characters
    b. Player guesses phrase
       a. Add $1000 if computer has no money
          or else add the difference between computer's money
          and player's money + 100
6. Computer Turn
   i. Only if player turn is false or else break
   ii. computer_turn is true until it picks wrong letter
7. Computer spins and the value gets stored to a pending_money variable
	i.  If bankrupt? then computer loses money
	ii. If Lose_a_turn? then it becomes player's turn
8. Computer Can only pick constanants if computer has less than 250
   a. If there is more than 3 "_ ", then computer picks random letter or else
   	  Computer takes a guess at winning phrase
   	  i. When computer guesses the right phase
   	  	  Add $1000 if player has no money
          or else add the difference between player's money
          and computer's money + 100
   b. If the letter picked is correct
   	  i. Display game
   	  ii. Update computer_money
   	  iii. Computer goes again until he gets one wrong
   	  iv. If game over, compare score and declare winner
   	  v. When computer has $250 or more he can pick a vowel
   	  vi.  If three or more vowels exist already, then pick a random letter
   	  vii. If game over, compare score and declare winner
   c. If incorrect letter
   	  i. Update score
   	  ii. Player turn
9. Ask to play again

Once it becomes the computer's turn

Computer will keep picking a letter until it picks the wrong letter
After

When game is over ask to play again

If no, then break otherwise go again

If there are more than 3 or more blanks in the game, then pick any letter other wise guess the right phrase.

1. Create a method that counts the number values in the hash that is "_ "
2. Write a conditional if blank is greater than 3, pick a letter or else guess
3. Create a method that will pick a vowel if there is a _ between two constanants
   or else pick a random letter
4.

Bonus features

1. When we pick a letter and it happens to be in the index of 0, it needs to be capitalized



