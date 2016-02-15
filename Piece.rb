# coding: utf-8

class Piece
  attr_reader :player, :board

  def initialize(board, player)
    @player = player
    @board = board
  end

  def to_s
    symbol.colorize(self.color.to_sym)
  end


end

class VoidPiece

  def to_s
    "     "
  end
end

class SlidingPiece < Piece
  def diagonal

  end

  def orthogonal

  end

end


class Bishop < SlidingPiece
  attr_reader :player



  def symbol
    "  ♗  "
  end

end

class Rook < SlidingPiece

  def symbol
    "  ♖  "
  end


end


class Queen < SlidingPiece



  def symbol
    "  ♕  "
  end

end

class SteppingPiece < Piece

  def possible_moves(pos)
    self.deltas.each do |position|
      next unless board.in_bounds?([row + position[0], column + position[1]])
      possibilities << [row + position[0], column + position[1]]
    end
    possibilities
  end

end

class Knight < SteppingPiece

  DELTA = [
        [2,1],
        [2,-1],
        [1,2],
        [1,-2],
        [-1,2],
        [-1,-2],
        [-2,1],
        [-2,-1]
      ]

  def initialize(board, player)
    @player = player
  end

  def deltas
    DELTA
  end


  def symbol
    "  ♘  "
  end
end

class King < SteppingPiece

  DELTA = [
    [1,1],
    [1,0],
    [1,-1],
    [0,1],
    [0,-1],
    [-1,1],
    [-1,0],
    [-1,-1]
  ]

  def deltas
    DELTA
  end

  def symbol
    "  ♔  "
  end

end

class Pawn < Piece

  def symbol
    "  ♙  "
  end

end
