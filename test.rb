

class SteppingPiece
  def initialize

  end



  def possible_moves(pos)
    possibilities = []
    row , column = pos[0], pos[1]

  end

end

class Knight < SteppingPiece
  attr_reader :player
  DELTA = [[2,1],
          [2,-1],
          [1,2],
          [1,-2],
          [-1,2],
          [-1,-2],
          [-2,1],
          [-2,-1]]

  def initialize

  end

  def possible_moves(pos)
    super
    DELTA.each do |position|
      next unless (0..7).to_a.include?(row + position[0]) && (0..7).to_a.include?(column + position[1])
      possibilities << [row + position[0], column + position[1]]
    end
    possibilities
  end

end

k = Knight.new
p k.possible_moves([0,3])
