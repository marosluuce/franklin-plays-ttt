class SquareHandler
  def handle(request, game_handler)
    make_move(extract_square(request), game_handler)
  end

  def make_move(square, game_handler)
    game_handler.make_move(square)
  end

  def extract_square(request)
    request["Body"]["square"].to_i
  end
end
