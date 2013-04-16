#!/usr/bin/env ruby

$:.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib"))
$:.unshift(File.expand_path(File.dirname(__FILE__) + "/../jar"))

require "Franklin.jar"
require "ttt_responder"

java_import Java::Httpserver.Server
java_import Java::Httpserver.Router
java_import Java::HttpserverSockets.ServerSocketWrapper

router = Router.new
router.addRoute("/", TTTResponder.new)

socket = ServerSocketWrapper.new(Java::JavaNet.ServerSocket.new(5000))

server = Server.new(socket, router)
server.run
