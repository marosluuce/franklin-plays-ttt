class NewgameHandler
  def handle(request, game_handler)
    game_handler.select_opponent(opponent(request))
    game_handler.create_game
  end

  def opponent(request)
    request["Body"]["newgame"]
  end
end
