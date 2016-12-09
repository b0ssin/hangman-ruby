class Logic

	def save name
	  word_letters = ""
	  letters_left = ""
		File.open("./#{name}.txt", 'w') do |f|
		  f.puts @name
		  f.puts @rand_word
		  @word_by_letter.each do |letter|
		    word_letters << letter
		  end
		  f.puts word_letters
		  @letters_remaining.each do |letter|
		    letters_left << letter
		  end
		  f.puts letters_left
		  f.puts @number_of_guesses.to_s

		end
	end

	def load name
		data = File.open("./#{name}.txt", 'r')
		data_array = []
		data.each { |line| data_array << line.to_s }
		puts data_array[0].inspect
		@name = data_array[0].chomp.to_s
		data_array[1].inspect
		@rand_word = data_array[1].chomp.to_s
		puts data_array[2].inspect
		@word_by_letter = []
		data_array[2].chomp.split("").each { |letter| @word_by_letter << letter }
		puts data_array[3].inspect
		@letters_remaining = []
		data_array[3].chomp.split("").each { |letter| @letters_remaining << letter }
		puts data_array[4].inspect
		@number_of_guesses = data_array[4].chomp.to_i
	end

end
