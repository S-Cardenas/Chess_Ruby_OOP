require_relative 'sliding_piece'

class Queen < SlidingPiece


  def possible_moves(pos)
    orthogonal(pos) + diagonal(pos)
  end


  def symbol
    "  ♕  "
  end

end
