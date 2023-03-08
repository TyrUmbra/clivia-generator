module Presenter
  #------WELCOME
  def print_welcome
    # print the welcome message
    puts "###################################"
    puts "#   Welcome to Clivia Generator   #"
    puts "###################################"
  end
  #WELCOME------

  #SCORES------
  def print_score
    # print the score message
    table_score = @players.map {|hash| [hash.score, hash.name]}
    table_order = table_score.sort.reverse
    table_scores = table_order.map {|hash| [hash[1], hash[0]]}
    print_scores(table_scores)
  end
  #------SCORES
end
