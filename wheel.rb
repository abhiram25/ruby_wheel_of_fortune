def prompt(message)
  puts "=> #{message}"
end

system 'clear'

vowels = ["a", "e", "i", "o", "u"]

spinner_values =
  ["Bankrupt", "Lose a turn",
   300, 300, 300,
   300, 300, 300,
   350, 400, 400,
   450, 500, 500,
   550, 600, 600,
   600, 700, 800,
   800, 900, 900]

RIDDLES = { "dances with wolves" => "Movie",
            "kill two birds with one stone" => "Idiom",
            "ain't nuthin but a g thang" => "Song" }.freeze

def no_vowel_allowed(char, money, vowels)
  vowels.include?(char) && money < 250
end

def initialize_game(game, winning_phrase)
  winning_phrase = winning_phrase.split(//)
  winning_phrase.each_with_index do |char, index|
    if /[[:alpha:]]/ =~ char
      game[index] = "_ "
    else
      game[index] = char
    end
  end
  game.values.join("")
end

def spin(spinner_values)
  spinner_values.sample
end

def display_hint(hint)
  puts
  puts "It's a #{hint}"
end

def not_a_letter(letter)
  letter.to_i > 0 || letter.to_i == "0" || letter.length > 1
end

def unavailable_letter(chars, letter)
  !chars.include?(letter)
end

def no_letter?(winning_phrase, letter)
  !winning_phrase.include?(letter)
end

def update_game(game, winning_phrase, char)
  winning_phrase = winning_phrase.split(//)
  winning_phrase.each_with_index do |character, index|
    if character == char.upcase
      game[index] = char.upcase + " "
    elsif character == char.downcase
      game[index] = char + " "
    elsif !(/[[:alpha:]]/ =~ character)
      game[index] = character
    end
  end
  game.values.join("")
end

def letter_count(winning_phrase, letter)
  letter = letter.downcase
  count = winning_phrase.count(letter)
  if count < 1
    false
  elsif count == 1
    "There is #{count} '#{letter}' in this riddle"
  else
    "There are #{count} #{letter}'s in this riddle"
  end
end

def bankrupt?(pending_money)
  pending_money == "Bankrupt"
end

def lose_a_turn?(pending_money)
  pending_money == "Lose a turn"
end

def add_money_for_guess(player, computer)
  if computer == 0 || player > computer
    player + 1000
  else
    player + (computer - player) + 100
  end
end

def game_over?(game, guess, winning_phrase)
  !game.value?("_ ") || guess == winning_phrase
end

def valid_input?(decision)
  decision == "L" || decision == "G"
end

def correct_guess(guess, winning_phrase)
  guess == winning_phrase
end

def print_spinning
  puts
  puts "spinning."
  puts "spinning.."
  puts "spinning..."
end

def detect_winner(player, computer)
  if player > computer
    "player"
  elsif computer > player
    "computer"
  else
    "It was a tie"
  end
end

def count_blanks(game)
  game.values.count("_ ")
end

def display_winner(result, player, computer)
  if result == "player"
    puts "You have $#{player}"
    puts "Computer has $#{computer}"
    puts
    puts "Congrats you won"
  elsif result == "computer"
    puts "You have $#{player}"
    puts "Computer has $#{computer}"
    puts
    puts "Computer won"
  else
    puts "It's a tie"
  end
end

def computer_turn(winning_phrase, char, game, guess)
  !letter_count(winning_phrase, char) ||
    game_over?(game, guess, winning_phrase) ||
    correct_guess(guess, winning_phrase)
end
# def computer_picks_letter(char, game)

loop do
  system 'clear'
  chars = ["a", "b", "c",
           "d", "e", "f",
           "g", "h", "i",
           "j", "k", "l",
           "m", "n", "o",
           "p", "q", "r",
           "s", "t", "u",
           "v", "w", "x",
           "y", "z"]
  game = Hash.new
  player_score = 0
  computer_score = 0
  prompt "Welcome to Wheel of fortune"
  winning_phrase = RIDDLES.keys.sample
  input = ''
  guess = ''
  letter_screen = initialize_game(game, winning_phrase)
  hint = RIDDLES[winning_phrase]

  loop do
    loop do
      char = ''
      guess = ''
      p letter_screen
      display_hint(hint)
      pending_money = spin(spinner_values)
      puts "You have $#{player_score}"
      if bankrupt?(pending_money)
        puts "Ouch! Looks like you bankrupted"
        player_score = 0
        break
      elsif lose_a_turn?(pending_money)
        puts "Looks like you lost your turn"
        break
      else
        puts "It's $#{pending_money}, type 'L' to pick a letter or 'G' to guess the \ winning phrase"
        decision = ''
      end
      loop do
        break if lose_a_turn?(pending_money) || bankrupt?(pending_money)
        decision = gets.chomp.upcase
        if valid_input?(decision)
          break
        else
          puts "Please type 'L' to pick letter or 'G' to guess phrase"
        end
      end
      if decision == "L"
        loop do
          puts "Pick a Letter"
          char = gets.chomp
          if no_vowel_allowed(char, player_score, vowels)
            puts "You need more than $250 to pick a vowel"
          elsif not_a_letter(char)
            puts "Please type a letter a-z"
          elsif !letter_count(winning_phrase, char)
            puts "There is no #{char} in this riddle"
            break
          elsif unavailable_letter(chars, char)
            puts "#{char} is already there"
          else
            letter_screen = update_game(game, winning_phrase, char)
            player_score += pending_money
            player_score -= 250 if vowels.include?(char)
            character_count = letter_count(winning_phrase, char)
            puts character_count
            chars.delete(char)
            break
          end
        end
      elsif decision == "G"
        puts "Guess this riddle"
        guess = gets.chomp

        if correct_guess(guess, winning_phrase)
          player_score = add_money_for_guess(player_score, computer_score)
        else
          puts "Looks like you guessed wrong"
        end
      end
      binding.pry
      break if computer_turn(winning_phrase, char, game, guess)
    end
    loop do
      blanks = count_blanks(game)
      if game_over?(game, guess, winning_phrase)
        prompt "Game Over"
        puts
        break
      end
      print_spinning
      pending_money = spin(spinner_values)
      if bankrupt?(pending_money)
        puts
        puts "Computer bankrupted"
        computer_score = 0
        break
      elsif lose_a_turn?(pending_money)
        puts
        puts "Computer lost a turn"
        break
      elsif blanks > 3
        char = chars.delete(chars.sample)
        puts "Computer has $#{computer_score}"
        puts "Computer can win $#{pending_money}"
      else
        guess = winning_phrase
        prompt "computer guessed the right phrase"
        puts "The winning phrase is #{winning_phrase}"
        computer_score = add_money_for_guess(computer_score, player_score)
        break
      end
      if !letter_count(winning_phrase, char)
        puts "Computer picked #{char}, there are no #{char}'s"
        break
      else
        character_count = letter_count(winning_phrase, char)
        computer_score += pending_money
        puts character_count
        letter_screen = update_game(game, winning_phrase, char)
        next
      end
    end
    break if game_over?(game, guess, winning_phrase)
  end
  result = detect_winner(player_score, computer_score)
  display_winner(result, player_score, computer_score)

  puts "Would you like to play again? (y/n)"
  input = gets.chomp

  loop do
    if input == "y" || input == "n"
      break
    else
      puts "Please type y for yes or n for no"
    end
  end
  break if input == "n"
end

puts "Thank you for playing, Goodbye!"
