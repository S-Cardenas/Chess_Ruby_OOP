require_relative "stepping_piece"

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

  def deltas
    DELTA
  end


  def symbol
    "  ♘  "
  end
end
