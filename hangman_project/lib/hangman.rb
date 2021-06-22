class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  
def self.random_word
      return DICTIONARY.sample
  end

  def initialize()
    @secret_word = Hangman.random_word #random word is a class method so you need to call Hangman, then method name
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    return @guess_word
  end

  def attempted_chars
    return @attempted_chars
  end

  def remaining_incorrect_guesses
    return @remaining_incorrect_guesses
  end

  def already_attempted?(char)
  if @attempted_chars.include?(char)
    return true 
  else 
    return false
  end
end

  def get_matching_indices(char)
    newArr = []
    @secret_word.each_char.with_index { |ele, idx| newArr << idx if ele == char}
    return newArr 
  end

  def fill_indices(char, indices)
    #go thru index array, set each index as the char in the guess word
    indices.each { |index| @guess_word[index] = char}
  end

   def try_guess(char)
    if self.already_attempted?(char)
      p "that character was already attempted"
      return false
    end

    @attempted_chars << char

    #see if the guess matches whats in our indices
    matches = self.get_matching_indices(char)#see what indices match the char

    self.fill_indices(char, matches)#put char in these indices in our guess_word

    @remaining_incorrect_guesses -= 1 if matches.length == 0#if there are no matches, we get an empty array
    true
   end
    

  def ask_user_for_guess
    p 'Enter a char:'
    char = gets.chomp
    return self.try_guess (char)
  end

  def win?
    if @guess_word.join() == @secret_word
      p 'WIN'
      return true
    else
      return false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      p 'LOSE'
      return true
    else
      return false
    end
  end

  def game_over?
    if (self.win?) || (self.lose?)
      puts @secret_word
      return true
    else
      return false
    end
  end

end
