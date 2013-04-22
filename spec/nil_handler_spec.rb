require "nil_handler"

describe NilHandler do
  it "handles and does nothing" do
    handler = NilHandler.new

    game_handler = nil
    handler.handle({}, game_handler).should be_nil
    game_handler.should be_nil
  end
end
