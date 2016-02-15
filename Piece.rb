# coding: utf-8

class Piece
  attr_reader :name, :value

  def initialize(board, player)

    @player = player
    @board = board
  end


end

class VoidPiece
  attr_reader :name, :value

  def initialize(board, player)


  end

  def to_s
    "     "
  end
end

class SlidingPiece < Piece

  def initialize(board, player)

  end

end


class Bishop < SlidingPiece

  def initialize(board, player)
  end

  def to_s
    "  ♗  "
  end


end

class Rook < SlidingPiece

  def initialize(board, player)
  end

  def to_s
    "  ♖  "
  end

end


class Queen < SlidingPiece

  def initialize(board, player)
  end

  def to_s
    "  ♕  "
  end

end

class SteppingPiece < Piece
  def initialize(board, player)

  end



  def move
    possible_moves = []
  end

end

class Knight < SteppingPiece

  def initialize(board, player)
  end

  def to_s
    "  ♘  "
  end

end

class King < SteppingPiece

  def initialize(board, player)
  end

  def to_s
    "  ♔  "
  end

end

class Pawn < Piece
  def initialize(board, player)

  end

  def to_s
    "  ♙  "
  end

end
