$:.unshift(File.expand_path(File.dirname(__FILE__) + "/../TicTacToe/lib"))

require "json"

require "game"
require "game_runner"

class TTTGameHandler
  attr_reader :game_runner

  def get_move(request)
    request["Body"]["square"].to_i
  rescue
    0
  end

  def create_game
    @game_runner = GameRunner.new(Game.tic_tac_toe, [Human, Human])
  end

  def game_runner
    @game_runner ||= create_game
  end

  def squares_to_json
    squares = game_runner.game.board.squares.map { |square| square ? square.to_s.upcase : "" }
    {"squares" => squares }.to_json
  end

  def make_move(move)
    game_runner.make_move(move)
  rescue InvalidMoveException
  end

  def handle(request)
    move = get_move(request)
    make_move(move)
    squares_to_json
  end
end

class Human
  def self.request_move(runner)
  end
end
