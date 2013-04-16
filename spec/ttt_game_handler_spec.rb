require "ttt_game_handler"

describe TTTGameHandler do
  let(:handler) { TTTGameHandler.new }

  describe "get_move" do
    it "extracts the move from the request" do
      request = {"Body" => {"square" => "1"}}
      handler.get_move(request).should == 1
    end

    it "is 0 if an exception is thrown" do
      request = {}
      handler.get_move(request).should == 0
    end
  end

  describe "create_game" do
    it "creates a new TTT game" do
      handler.create_game.should be_an_instance_of GameRunner
    end
  end

  describe "squares_to_json" do
    it "is a JSON representation of the squares on the game board" do
      handler.squares_to_json.should == '{"squares":["","","","","","","","",""]}'
    end
  end

  describe "make_move" do
    it "makes a move" do
      handler.game_runner.should_receive(:make_move).with(1)
      handler.make_move(1)
    end

    it "does not make a move when it receives an InvalidMoveException" do
      squares = handler.squares_to_json
      handler.make_move(-1)
      handler.squares_to_json.should == squares
    end
  end

  describe "handle" do
    it "processes a request and returns the json board" do
      request = {"Body" => {"square" => "1"}}
      handler.handle(request).should == '{"squares":["X","","","","","","","",""]}'
    end
  end
end
