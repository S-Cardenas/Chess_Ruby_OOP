require_relative "Piece"

class SteppingPiece < Piece

  def possible_moves(pos)
    possibilities = []
    row , column = pos[0], pos[1]
      self.deltas.each do |position|
        potential_pos = [row + position[0], column + position[1]]
        next unless board.in_bounds?(potential_pos)
        if @board.piece_present?(potential_pos)
          next if @board.grid[row + position[0]][column + position[1]].color == self.color
        end
        possibilities << potential_pos
      end
    possibilities
  end

end
