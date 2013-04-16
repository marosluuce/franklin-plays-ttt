$:.unshift(File.expand_path(File.dirname(__FILE__) + "/../jar"))

require "Franklin.jar"
require "ttt_game_handler"

java_import Java::Httpserver.Utilities

class TTTResponder
  def initialize
    @handler = TTTGameHandler.new
  end

  def respond(request)
    response = @handler.handle(request)
    body = Utilities.toBytes(response)
    header = Utilities.getCommonHeader("application/json", body.length)
    Utilities.generateResponse(Utilities.status_line(200), header, body)
  end
end
