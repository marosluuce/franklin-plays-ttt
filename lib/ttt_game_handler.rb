class TTTGameHandler
  def get_move(request)
    request["Body"]["square"].to_i
  rescue
    0
  end
end
