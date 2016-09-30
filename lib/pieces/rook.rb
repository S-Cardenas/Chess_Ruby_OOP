require_relative 'sliding_piece'

class Rook < SlidingPiece


  def possible_moves(pos)
    orthogonal(pos)
  end

  def symbol
    "  ♖  "
  end


end
