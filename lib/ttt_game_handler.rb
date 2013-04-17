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

  def make_move(move)
    game_runner.make_move(move)
  rescue InvalidMoveException
  end

  def handle(request)
    move = get_move(request)
    make_move(move)
    build_response
  end

  def build_response
    {
      "squares" => game_runner.game.board.squares,
      "winner" => game_runner.game.winner.to_s,
      "gameover" => game_runner.game.game_over?,
    }
  end
end

class Human
  def self.request_move(runner)
  end
end
