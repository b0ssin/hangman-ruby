
require_relative 'save_logic.rb'

class Hangman < Logic

	attr_accessor :name, :rand_word, :letters_remaining, :word_by_letter, :number_of_guesses

	def initialize(name)
		@name = name
		@word_list = File.readlines('./desk.txt') # stored as an array
		@rand_word = @word_list.shuffle[rand(2..@word_list.length - 1)].chomp.downcase
		puts "Greetings, #{@name}. I hope you enjoy the game."
	end

	def main_menu
		puts "Welcome to Hangman, #{@name}"
		puts "-" * 10
		puts "Enter the option you want (1-4):"
		puts "-" * 10
		puts "1. LOAD"
		puts "2. SAVE"
		puts "3. PLAY"
		puts "4. QUIT"
		choice = gets.chomp
		case choice
		when "1"
		  load
		when "2"
		  save
		when "3"
		  play
		when "4"
		  abort("Disgusting, I'm pro-choice! :*(")
		else
		  puts "Non-valid entry"
		  main_menu
		end
	end

	def save
	  puts 'Give me a save_file name!'
	  if @save_name.nil?
	    @save_name = gets.chomp
	  end
		super @save_name
		puts "Saved"
	end

	def load
		puts "Enter the name of the file"
		user_input = gets.chomp
		super user_input
		puts "Loaded, booting up..."
		puts "Oh, it is #{@name}!"
		@loaded = TRUE
		main_menu
	end
	

	def play
		@temp_match = []
		@word_by_letter = @rand_word.split('') unless @loaded
		@letters_remaining = ('a'..'z').to_a unless @loaded
		@number_of_guesses = 0 unless @loaded# goes to 5
		finished = FALSE
		puts "You have the following letters left: #{@letters_remaining.to_s}"

		

		while !finished
			puts ""
			puts 'Do you want to save your game?(y/n)'
			user_input = gets.chomp
			if user_input[0] == 'y'
				save
			end
			puts "-" * 10
			puts 'Guess a character'
			user_guess = gets.chomp
			@letters_remaining.delete(user_guess)
			if @word_by_letter.include? user_guess[0]
			  if !(@letters_remaining.include? user_guess[0])
			    puts 'You repeated a character.'
			  end
        puts 'Matched'
			else
				puts 'Wrong letter! Here\'s the letters_remaining:'
			  @number_of_guesses += 1
			end

			@word_by_letter.each do |letter|
        if @letters_remaining.include? letter
      	  print '_'
        else
      	  print letter
      	  @temp_match << letter 
        end
		  end
		  if @temp_match.sort == @word_by_letter.sort
      	  	puts 'You won!'
      	  	break
      	  else
      	  	@temp_match = []
      	  end
		  # win/lose
		  if @number_of_guesses > 4
		  	puts @word_by_letter.join('')
		  	puts 'Too many guesses, you\'re HUNG!'
		  	break
		  end
		  puts ""
		  puts "You've got #{5 - @number_of_guesses} guesses left!"
		end
	end
end

x = Hangman.new('jen'); y = Hangman.new('bob')
x.main_menu
