require_relative 'Piece'

class SlidingPiece < Piece
  def diagonal(pos)
    possible_moves = []
    [[-1,-1], [1,-1], [1,1], [-1,1]].each do |cardinal|
      new_pos = pos.dup
      new_pos[0] += cardinal[0]
      new_pos[1] += cardinal[1]
      while @board.in_bounds?(new_pos) && !@board.piece_present?(new_pos)
        possible_moves << [new_pos[0], new_pos[1]]
        new_pos[0] += cardinal[0]
        new_pos[1] += cardinal[1]

      end
      if @board.in_bounds?(new_pos)
        if @board.piece_present?(new_pos) && @board.grid[new_pos[0]][new_pos[1]].color != self.color
          possible_moves << new_pos
        end
      end
    end
    possible_moves
  end

  def orthogonal(pos)
    possible_moves = []
    [[0,-1], [1,0], [0,1], [-1,0]].each do |cardinal|
      new_pos = pos.dup
      new_pos[0] += cardinal[0]
      new_pos[1] += cardinal[1]
      while @board.in_bounds?(new_pos) && !@board.piece_present?(new_pos)
        possible_moves << [new_pos[0], new_pos[1]]
        new_pos[0] += cardinal[0]
        new_pos[1] += cardinal[1]

      end
      if @board.in_bounds?(new_pos)
        if @board.piece_present?(new_pos) && @board.grid[new_pos[0]][new_pos[1]].color != self.color
          possible_moves << new_pos
        end
      end
    end
    possible_moves
  end

end
