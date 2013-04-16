$:.unshift(File.expand_path(File.dirname(__FILE__) + "/../jar"))

require "Franklin.jar"

#java_import Java::HttpserverResponders.Responder
java_import Java::Httpserver.Utilities

class TTTResponder
  #include Responder

  #java_signature "Map<String, Object> respond(Map<String, Object>)"
  def respond(request)
    body = Utilities.toBytes("")
    header = Utilities.getCommonHeader("application/json", body.length)
    Utilities.generateResponse(Utilities.status_line(200), header, body)
  end
end
