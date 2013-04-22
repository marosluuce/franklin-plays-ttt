require "newgame_handler"
require "ttt_game_handler"

describe NewgameHandler do
  let(:request) { {"Body" => {"newgame" => "true"}} }
  let(:handler) { NewgameHandler.new }
  let(:game_handler) { TTTGameHandler.new }

  describe "handle" do

    before(:each) do
      game_handler.make_move(1)
      game_handler.make_move(4)
      game_handler.make_move(2)
      game_handler.make_move(5)
      game_handler.make_move(3)
    end

    it "creates a new game when newgame is true" do
      game_handler.game_runner.game.game_over?.should be_true
      handler.handle(request, game_handler)
      game_handler.game_runner.game.game_over?.should be_false
    end

    it "doesn't create a new game when newgame is false" do
      request["Body"]["newgame"] = "false"

      game_handler.game_runner.game.game_over?.should be_true
      handler.handle(request, game_handler)
      game_handler.game_runner.game.game_over?.should be_true
    end
  end

  it "extracts new game" do
    handler.extract_newgame(request).should == true
    handler.extract_newgame({"Body" => {"newgame" => ""}})
  end
end
