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

  describe "createGame" do
    it "creates a new TTT game" do

    end
  end
end
