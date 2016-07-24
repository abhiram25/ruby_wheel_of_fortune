require 'pry'

system 'clear'

def prompt(message)
  puts "=> #{message}"
end

VOWELS = ["a", "e", "i", "o", "u"].freeze

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

def no_vowel_allowed(char, money)
  VOWELS.include?(char) && money < 250
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
  letter.to_i > 0 || letter.to_i == "0"
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
  letter.downcase!
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

def game_over?(game)
  !game.value?("_ ")
end

def valid_input?(decision)
  decision == "L" || decision == "G"
end

def display_player_score(player_score)
  puts "spinning."
  puts "spinning.."
  puts "spinning..."
  puts "You have $#{player_score}"
end

def count_blanks(game)
  game.values.count("_ ")
end

# computer_pick_letter(blanks, )

loop do
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
  letter_screen = initialize_game(game, winning_phrase)
  hint = RIDDLES[winning_phrase]
  loop do
    p letter_screen
    if game_over?(game)
      prompt "Game Over"
      puts
      break
    end
    display_hint(hint)
    pending_money = spin(spinner_values)
    display_player_score(player_score)
    if bankrupt?(pending_money)
      puts "Ouch! Looks like you bankrupted"
      player_score = 0
      break
    elsif lose_a_turn?(pending_money)
      puts "Looks like you lost your turn"
      break
    else
      puts "It's $#{pending_money}, type 'L' to pick a letter or 'G' to guess the winning phrase"
      decision = ''
    end
      loop do
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
        if no_vowel_allowed(char, player_score)
          puts "You need more than $250 to pick a vowel"
        elsif not_a_letter(char)
          puts "Please type a letter a-z"
        elsif unavailable_letter(chars, char)
          puts "#{char} is already there"
        elsif !letter_count(winning_phrase, char)
          puts "There is no #{char} in this riddle"
          break
        else
          letter_screen = update_game(game, winning_phrase, char)
          player_score += pending_money
          player_score -= 250 if VOWELS.include?(char)
          character_count = letter_count(winning_phrase, char)
          puts character_count
          chars.delete(char)
          break
        end
      end
    elsif decision == "G"
      puts "Guess this riddle"
      answer = gets.chomp
      if answer == winning_phrase
        puts "Congrats you won!"
        player_score = add_money_for_guess(player_score, computer_score)
        break
      end
    end
   end
end
