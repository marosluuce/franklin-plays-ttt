$:.unshift(File.expand_path(File.dirname(__FILE__) + "/../jar"))

require "json"

require "Franklin.jar"
require "ttt_game_handler"
require "request_handler"

java_import Java::Httpserver.Utilities

class TTTResponder
  def initialize
    @game_handler = TTTGameHandler.new
  end

  def respond(request)
    @request_handler = RequestHandler.create(request)
    @request_handler.handle(request, @game_handler)

    body = Utilities.toBytes(to_json(@game_handler.build_response))
    header = Utilities.getCommonHeader("application/json", body.length)
    Utilities.generateResponse(Utilities.status_line(200), header, body)
  end

  def to_json(hash)
    hash.to_json
  end
end
