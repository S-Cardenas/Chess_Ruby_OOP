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

  def initialize(board)


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
  attr_reader :player

  def initialize(board, player)
    @player = player
  end

  def to_s
    if player.color == 'black'
      "  ♗  ".colorize(:black)
    else
      "  ♗  ".colorize(:white)
    end
  end


end

class Rook < SlidingPiece
  attr_reader :player

  def initialize(board, player)
    @player = player
  end

  def to_s
    if player.color == 'black'
      "  ♖  ".colorize(:black)
    else
      "  ♖  ".colorize(:white)
    end
  end

end


class Queen < SlidingPiece
  attr_reader :player

  def initialize(board, player)
    @player = player
  end

  def to_s
    if player.color == 'black'
      "  ♕  ".colorize(:black)
    else
      "  ♕  ".colorize(:white)
    end
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
  attr_reader :player

  def initialize(board, player)
    @player = player
  end

  def to_s
    if player.color == 'black'
      "  ♘  ".colorize(:black)
    else
      "  ♘  ".colorize(:white)
    end
  end

end

class King < SteppingPiece
  attr_reader :player

  def initialize(board, player)
    @player = player
  end

  def to_s
    if player.color == 'black'
      "  ♔  ".colorize(:black)
    else
      "  ♔  ".colorize(:white)
    end
  end

end

class Pawn < Piece
  attr_reader :player
  def initialize(board, player)
    @player = player
  end

  def to_s
    if player.color == 'black'
      "  ♙  ".colorize(:black)
    else
      "  ♙  ".colorize(:white)
    end
  end

end
