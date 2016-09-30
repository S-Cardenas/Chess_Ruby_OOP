require_relative 'sliding_piece'

class Bishop < SlidingPiece


  def possible_moves(pos)
    diagonal(pos)
  end

  def symbol
    "  ♗  "
  end

end
