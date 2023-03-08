# do not forget to require your gem dependencies
require "httparty"
require "terminal-table"
require "json"
require "htmlentities"
# do not forget to require_relative your local dependencies
require_relative "presenter"
require_relative "requester"
require_relative "players"

class CliviaGenerator
  attr_reader :coder
  include Presenter
  include Requester
  # maybe we need to include a couple of modules?

  def initialize
    # we need to initialize a couple of properties here
    @random = nil
    @data = JSON.parse(File.read("score.json"), symbolize_names: true)
    @players = @data.map { |data_total| Players.new(**data_total) }
    @coder = HTMLEntities.new(:expanded)
  end
  #------START#
  def start
    # welcome message
    print_welcome
    # prompt the user for an action
    select_main_menu_action
    # keep going until the user types exit
  end
  #START------#

  def random_trivia
    # load the questions from the api
    url = "https://opentdb.com/api.php?amount=10"
    response = HTTParty.get(url)
    random = JSON.parse(response.body, symbolize_names: true)
    @random = random
    # questions are loaded, then let's ask them
    ask_question(random)
  end
  def save(data)
    new_player = Players.new(**data)
    @players.push(new_player)
    File.write("score.json", @players.to_json)
  end
  def print_scores(scores)
    # print the scores sorted from top to bottom
    table = Terminal::Table.new
    table.title = "Top Scores"
    table.headings = ["Name", "Score"]
    table.rows = scores
    puts table
  end
end

trivia = CliviaGenerator.new
trivia.start
