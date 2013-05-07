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

  describe "make_move" do
    it "makes a move" do
      handler.game_runner.should_receive(:make_move).with(1)
      handler.make_move(1)
    end

    it "does not make a move when it receives an InvalidMoveException" do
      response = handler.build_response
      handler.make_move(-1)
      response["squares"].should == handler.build_response["squares"]
    end
  end

  describe "build_response" do
    it "is a hash with the current squares" do
      handler.build_response[:squares].should == handler.game_runner.game.board.squares.map { |squares| squares.to_s }
    end

    it "is a hash with the winner" do
      handler.build_response[:winner].should == handler.game_runner.game.winner.to_s
    end

    it "is a hash with gameover" do
      handler.game_runner.game.stub(:game_over?).and_return(true)
      handler.build_response[:gameover].should == true
      handler.game_runner.game.stub(:game_over?).and_return(false)
      handler.build_response[:gameover].should == false
    end

    it "is a hash with the current player" do
      handler.build_response[:currentplayer].should == "player x"
      handler.make_move(1)
      handler.build_response[:currentplayer].should == "player o"
    end
  end

  describe "select_opponent" do
    it "is a player type when type exists" do
      stub_const("TTTGameHandler::PLAYER_TYPES", {"easy_ai" => EasyAI})
      handler.select_opponent("easy_ai")
      handler.opponent.should == EasyAI
    end

    it "is Human when type does not exist" do
      stub_const("TTTGameHandler::PLAYER_TYPES", {})
      handler.select_opponent("easy_ai")
      handler.opponent.should == Human
    end
  end

  describe "opponent" do
    it "is Human by default" do
      handler.opponent.should == Human
    end
  end
end
