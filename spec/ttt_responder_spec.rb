require "ttt_responder"

describe TTTResponder do
  it "is a response" do
    responder = TTTResponder.new
    request = {"Request-URI" => "/", "Method" => "GET"}
    response = responder.respond(request)

    response["status-line"].should eq("HTTP/1.1 200 OK")
  end
end
