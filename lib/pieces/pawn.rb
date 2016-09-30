require_relative "Piece"

class Pawn < Piece

  def initialize(board, player, starting)
    super(board,player)
    @starting = starting
  end


  def moved?
    return true if @starting != self.current_pos
    false
  end

  def possible_moves(pos)
    possibilities = []
    row , column = pos[0], pos[1]
      self.deltas.each do |position|
        potential_pos = [row + position[0], column + position[1]]
        next unless board.in_bounds?(potential_pos)
        possibilities << potential_pos
      end
    possibilities
  end

  def deltas
    deltas = []
    if self.color == 'white'
      i = -1

    else self.color == 'black'
      i = 1
    end

    deltas << [1 * i,0]
    deltas << [2 * i,0] unless self.moved?
    [[1 * i,1],[1 * i,-1]].each do |cardinal|
      space_in_question = board.grid[self.current_pos[0] + cardinal[0]][self.current_pos[1] + cardinal[1]]
      if board.piece_present?([self.current_pos[0] + cardinal[0], self.current_pos[1] + cardinal[1]])
        deltas << cardinal if space_in_question.color != self.color
      end
    end
    deltas
  end

  def symbol
    "  ♙  "
  end

end
