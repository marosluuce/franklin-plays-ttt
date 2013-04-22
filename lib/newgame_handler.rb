class NewgameHandler
  def handle(request, game_handler)
    game_handler.create_game if extract_newgame(request)
  end

  def extract_newgame(request)
    value = request["Body"]["newgame"]
    value == "true"
  end
end
