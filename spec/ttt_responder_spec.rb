require "ttt_responder"

describe TTTResponder do
  let(:responder) { TTTResponder.new }

  it "is a response" do
    request = {"Request-URI" => "/", "Method" => "GET"}
    response = responder.respond(request)

    response["status-line"].should eq("HTTP/1.1 200 OK")
  end

  it "converts a hash to json" do
    responder.to_json({"stuff" => "junk"}).should == '{"stuff":"junk"}'
  end
end
