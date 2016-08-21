require 'io/console'


class Game
  attr_accessor :mystery_word, :mystery_word_array, :blanks_array, :fish_tank, :letter, :counter
  def initialize
    puts "Welcome to Word Guess! It works like hangman."
    puts
    puts "Player 1 will be the  guesser."
    puts "Player 2, what do you want the mystery word to be?"
    @mystery_word = STDIN.noecho(&:gets).chomp
    @mystery_word_array = mystery_word.split("")
    @blanks_array = mystery_word_array.fill("_ ")
    @letter = letter
    @fish_tank = ["
      ________________________________________________________________________________
                                                            \\  |                   /
                                                             \\_|__________________/
                                                                |
                                                                |
                                                                |
      ><(((º>                                                  ~J
      ________________________________________________________________________________",
      # #fish after 1 wrong guesses
       "
       ________________________________________________________________________________
                                                              \\  |                   /
                                                                \\|__________________/
                                                                  |
                                                                  |
                                                                  |
       .·´¯`·.><(((º>                                            ~J
       ________________________________________________________________________________",

      #fish after 2 wrong guesses
       "
      ________________________________________________________________________________
                                                            \\  |                   /
                                                              \\|__________________/
                                                                |
                                                                |
                                                                |
      .·´¯`·..·´¯`·.><(((º>                                    ~J
      ________________________________________________________________________________",

      #fish after 3 wrong guesses
       "
      ________________________________________________________________________________
                                                            \\  |                   /
                                                              \\|__________________/
                                                                |
                                                                |
                                                                |
      .·´¯`·..·´¯`·..·´¯`·.><(((º>                             ~J
      ________________________________________________________________________________",

      #fish after 4 wrong guesses
       "
      ________________________________________________________________________________
                                                            \\  |                   /
                                                              \\|__________________/
                                                                |
                                                                |
                                                                |
      .·´¯`·..·´¯`·..·´¯`·..·´¯`·.><(((º>                      ~J
      ________________________________________________________________________________",

      #fish after 5 wrong guesses
       "
      ________________________________________________________________________________
                                                            \\  |                   /
                                                              \\|__________________/
                                                                |
                                                                |
                                                                |
      .·´¯`·..·´¯`·..·´¯`·..·´¯`·..·´¯`·.><(((º>               ~J
      ________________________________________________________________________________",

      #fish after 6 wrong guesses
       "
      ________________________________________________________________________________
                                                            \\  |                   /
                                                              \\|__________________/
                                                                |
                                                                |
                                                                |
      .·´¯`·..·´¯`·..·´¯`·..·´¯`·..·´¯`·..·´¯`·.><(((º>        ~J
      ________________________________________________________________________________",

      #fish after 7 wrong guesses
       "
      ________________________________________________________________________________
                                                            \\  |                   /
                                                              \\|__________________/
                                                                |
                                                                |
                                                                |
      .·´¯`·..·´¯`·..·´¯`·..·´¯`·..·´¯`·..·´¯`·..·´¯`·.><(((º> ~J
      ________________________________________________________________________________"]

    #introduction

    puts
    puts "This is your fish: ><(((º> "
    puts
    puts "Try to prevent Fishy from being caught by the fisherman."
    puts
    puts @fish_tank[0]
    puts
    puts "Every time you make an incorrect letter guess, Fishy will swim closer to the hook. If Fishy reaches the hook, Fishy will be eaten. If you're feeling very lucky and brave you can guess a whole word, but if you are incorrect it will count as a guess and Fishy will swim. Good luck!"
    puts
  end #end of initialize



#ask the user to guess a letter
  def ask
    @counter = 0
    guesses = []

    until @blanks_array.join("") == mystery_word || @counter == fish_tank.length || @letter ==mystery_word
      puts @blanks_array.join("")
      puts "The letters you've guessed are: #{guesses.sort.join(", ")}"
      puts "Which letter would you like to guess?"
      puts
      @letter = gets.chomp.downcase

      if @letter.length > 1
        whole_word_guessed

      else
        alphabet_array = [*('a'..'z')]
        if alphabet_array.include? letter
          if guesses.include? letter
            puts "You've already guessed that letter!"
          else
            guesses.push(@letter)
            check_letter
          end #end of conditional to see if the letter has already been guessed
        else
          puts "You must guess a letter, a - z."
        end #end of conditional to see if user input is a letter
      end #end of conditional to see if they entered more than one letter

    end #end of until loop

    #This outputs whether the user lost or won
    if @counter == @fish_tank.length
      puts "Sorry, Fishy is for dinner!"
    else
      puts "Congratulations! You won! Fishy is safe."
    end#end of win or lose conditional
  end#end of ask method

  def check_letter
    if @mystery_word.include?(@letter)
        puts "Yes, there is at least one #{@letter} in the mystery word."
      #replace the blanks in the mystery with the guessed letter
        if @mystery_word.count(@letter) > 1
          puts "Turns out there are #{@mystery_word.count(letter)} #{@letter}'s'"
          replace_letter
        else
          replace_letter
        end#end of the conditional to see if the guessed letter occurs more than once in the mystery word

      puts @fish_tank[@counter]
      puts "Fishy stays in place."
      puts
      puts
    else
      wrong_guess
    end #end of conditional to see if the letter guessed is in the mystery_word
  end

  def replace_letter
    indices_array = (0...@mystery_word.length).find_all { |i| @mystery_word[i,1] == "#{@letter}" }

    indices_array.each do |x|
    @blanks_array[x] = @letter
    end
  end

#Allow the program to accept the whole word as input from the user. If the word is guessed correctly, the user will win. Otherwise, it will be treated as another guess.
  def whole_word_guessed

    if @letter == mystery_word
      puts "You're a lucky guesser! Yes the word was: #{@letter}"

    else
      puts "No, #{@letter} is not the mystery_word."
        wrong_guess

      if @letter.length != mystery_word.length
        puts "Come on, count the blanks. Your guess doesn't even have the right number of letters."
      end

      if  @letter =~ /\d/ || @letter.include?("!" + "," + "*" + "." + "@")
      puts "What do you have against Fishy?! Those aren't even letters!"
      end
    end #end of conditional to see if the whole word guessed is correct
  end #end of whole_world guessed method

def wrong_guess
  @counter += 1
  puts @fish_tank[@counter]
  puts "Fishy swims toward danger!"
  puts
  puts
end # end of wrong_guess method

end #end of class

test_game = Game.new
test_game.ask
