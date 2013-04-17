$:.unshift(File.expand_path(File.dirname(__FILE__) + "/../jar"))

require "json"

require "Franklin.jar"
require "ttt_game_handler"

java_import Java::Httpserver.Utilities

class TTTResponder
  def initialize
    @handler = TTTGameHandler.new
  end

  def respond(request)
    response = to_json(@handler.handle(request))
    body = Utilities.toBytes(response)
    header = Utilities.getCommonHeader("application/json", body.length)
    Utilities.generateResponse(Utilities.status_line(200), header, body)
  end

  def to_json(hash)
    hash.to_json
  end
end
