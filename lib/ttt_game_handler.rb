$:.unshift(File.expand_path(File.dirname(__FILE__) + "/../TicTacToe/lib"))

require "game"
require "game_runner"
require "easy_ai"
require "hard_ai"

class Human
  def self.request_move(runner)
  end
end

class TTTGameHandler
  attr_reader :game_runner, :opponent

  PLAYER_TYPES = {"easy_ai" => EasyAI, "hard_ai" => HardAI, "human" => Human}

  def get_move(request)
    request["Body"]["square"].to_i
  rescue
    0
  end

  def create_game
    @game_runner = GameRunner.new(Game.tic_tac_toe, [Human, opponent])
  end

  def game_runner
    @game_runner ||= create_game
  end

  def make_move(move)
    game_runner.make_move(move)
  rescue InvalidMoveException
  end

  def build_response
    {
      :squares => game_runner.game.board.squares.map { |square| square.to_s },
      :winner => game_runner.game.winner.to_s,
      :gameover => game_runner.game.game_over?,
      :currentplayer => "player #{game_runner.game.current_player}",
    }
  end

  def select_opponent(player_type)
    @opponent = if PLAYER_TYPES.has_key?(player_type)
      PLAYER_TYPES[player_type]
    else
      Human
    end
  end

  def opponent
    @opponent ||= Human
  end
end
