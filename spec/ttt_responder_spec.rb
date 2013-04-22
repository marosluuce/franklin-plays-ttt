require "ttt_responder"
require "nil_handler"

describe TTTResponder do
  let(:responder) { TTTResponder.new }

  it "creates a request handler" do
    RequestHandler.should_receive(:create).and_return(NilHandler.new)
    responder.respond({})
  end

  it "is a response" do
    request = {"Request-URI" => "/", "Method" => "GET"}
    response = responder.respond(request)

    response["status-line"].should eq("HTTP/1.1 200 OK")
  end

  it "converts a hash to json" do
    responder.to_json({"stuff" => "junk"}).should == '{"stuff":"junk"}'
  end
end
