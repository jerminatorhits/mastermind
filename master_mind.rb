class Mastermind

  def initialize
  	playing = true
	while playing == true
	  puts
	  puts "Welcome to Mastermind. The hardest game in the world."
	  puts
	  print "Type 'y' to make a code or something else to solve the computer's code: "
	  @choose_code = gets.chomp
	  #puts
	  if @choose_code == "y"
	  	puts "What is your 4-digit code?"
	  	input = valid_input(gets.chomp)
	  	answer = []
	  	(0..3).each { |x|
	  	  answer[x] = input[x]
	    }
	  	puts
	  	puts "The Computer will try to guess your code in 12 moves: "
	  else
	  	puts "Try and guess the 4-digit code in 12 moves.  Each digit is from 1-6."
	  	answer = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
	  end
      if guess_sequence(answer) == "BBBB"
		person = @choose_code ? "The Computer" : "You"
		print "guessed the code right! "
	  else
		print @choose_code ? "The Computer failed to get the answer #{answer[0]} #{answer[1]} #{answer[2]} #{answer[3]}." : "Sorry, the answer was #{answer[0]} #{answer[1]} #{answer[2]} #{answer[3]}. You lose. "
      end
        print "Wanna play again? Type y or n: "
		response = gets.chomp
	  if response == "y"
	    playing = true
	  else
        playing = false
	  end
	end
  end

  def is_number?(string)
  	string =~ /\A\d+\z/ ? true : false
  end
  
  def deep_copy(o)
    Marshal.load(Marshal.dump(o))
  end

  def ans_hash_calc(answer)
  	answer_hash = {1 => 0,
	  				 2 => 0,
					 3 => 0,
					 4 => 0,
					 5 => 0,
					 6 => 0,
	  }
	  answer.each { |x|
	  	x = x.to_i
		if answer_hash.key?(x)
		  answer_hash[x] += 1
		else
		  answer_hash[x] = 1
	    end
	  }
	answer_hash
  end

  def valid_input(guess)
    while guess.length != 4 || (guess !~ /\D/) == false
      if guess.length != 4
	    puts "Code is too long or short."
      end
      if (guess !~ /\D/) == false
        puts "Input is not a number."
      end
      print "Pick 4 digits: "
	  guess = gets.chomp
	end
	guess
  end

  def guess_sequence(answer)
      turn_count = 1
	  finished = false
	  saved_arr = []
	  while turn_count < 13 && finished == false
	    if @choose_code == "y"
	      guess = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
          (0..3).each { |x|
          	if saved_arr[x] != nil
          		guess[x] = saved_arr[x]
          	end
          }
          print "Computer guesses #{guess[0]}#{guess[1]}#{guess[2]}#{guess[3]}"
        else
	      print "Turn: #{turn_count}. Your guess: "
          guess = valid_input(gets.chomp)
        end
		#feedback = [nil, nil, nil, nil]
		feedback = ""
		#puts answer_hash
		#puts "^this is the first hash"
		answer_hash = ans_hash_calc(answer)
		puts answer_hash
		puts "6Mr"
		arty = []
		my_array = [0, 1, 2, 3]
		my_array.each { |x| 
		  #puts x
		  if answer[x].to_i == guess[x].to_i
		    feedback += "B"
			answer_hash[guess[x].to_i] -= 1
			#puts answer_hash
			#puts "^this is for B"
			arty.push(x)
			saved_arr[x] = guess[x].to_i
		  end
		}
		my_array -= arty
		puts answer_hash
		puts "^for the W's"
		my_array.each { |x|
		  if answer_hash[guess[x].to_i] > 0
		    answer_hash[guess[x].to_i] -= 1
		    puts answer_hash
			puts "^this is for W"
			feedback += "W"
		  end
		}
		puts feedback
		if feedback == "BBBB"
		  finished = true
		end
		turn_count += 1
	  end
	  feedback
  end

end

Mastermind.new



