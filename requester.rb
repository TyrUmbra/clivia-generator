module Requester
  #------MENU
  def select_main_menu_action
    # prompt the user for the "random | scores | exit" actions
    action = ""
    until action == "exit"
      action = options(["random", "scores", "exit"])
      case action
      when "random" then puts random_trivia
      when "scores" then puts print_score
      when "exit" then puts "Thanks for playing!"
      end
    end
  end
  def options(menu)
    action = ""
    until menu.include?(action)
      puts menu.join(" | ")
      print "> "
      action = gets.chomp
      puts "Invalid option" unless menu.include?(action)
    end
    action
  end
  #MENU------
  def ask_question(question)
    score = 0
    question[:results].each do |questions|
      # show category and difficulty from question
      puts "The category is: #{@coder.decode(questions[:category].upcase)}"
      puts "The difficulty is: #{@coder.decode(questions[:difficulty].upcase)}"
      # show the question
      puts @coder.decode(@coder.decode(questions[:question]))
      # show each one of the options
      incorrec_answers = questions[:incorrect_answers].map {|answer| answer}
      incorrec_answers.push(questions[:correct_answer])
      answers = incorrec_answers.shuffle
      answers.each_with_index do |answer, index|
        puts "#{index + 1}. #{coder.decode(answer)}"
      end
      # grab user input        
      print "> "
      action = gets.chomp.to_i
      selected = ""
      answers.each_with_index do |answer, index|
        if index == action - 1
          selected = answer
        end
      end
      if selected == questions[:correct_answer]
        puts "The answer is.......CORRECT!"
        puts "-------------------------------"
        score += 10
      elsif questions[:incorrect_answers].include?(selected)
        puts "The answer is.......INCORRECT!"
        puts "The correct answer was: #{questions[:correct_answer]}"
        puts "-------------------------------"
      else
        puts "Incorrect option"
        puts "-------------------------------"
      end
    end
    will_save(score)
  end

  def will_save(score)
    # show user's score
    action = ""
    options = ["y", "n", "Y", "N"]
    until options.include?(action)
      puts "Well done! Your score is #{score}"
    # ask the user to save the score
      puts "--------------------------------------------------"
      puts "Do you want to save your score? (y/n)"
      print "> "
      action = gets.chomp
    # grab user input
      case action
      when "y" then puts score_save(score)
      when "Y" then puts score_save(score)
      when "n" then puts print_welcome
      when "N" then puts print_welcome
      end
    end
  end

  def score_save(score)
    puts "Select a Name: "
    name = gets.chomp
    if name == ""
      name = "Anonymous"
    end
    save({name: name, score: score})
  end
end
