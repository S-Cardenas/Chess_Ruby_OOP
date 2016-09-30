require_relative "stepping_piece"

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

  def enemy_pieces(current_player)
    pieces_array = []
    board.grid.each do |row|
      row.each do |space|
        next if space.class == VoidPiece
        if space.color != current_player.color
          pieces_array << space
        end
      end
    end
    pieces_array
  end

  def set_player
    @player.king = self
  end



  def in_check?(current_player)
    all_possible_moves = []
    enemy_pieces(current_player).each do |piece|
      all_possible_moves << piece.possible_moves(piece.current_pos)
    end
    all_possible_moves.flatten!(1)
    # debugger
    if all_possible_moves.include?(self.current_pos)
      return true
    end
    return false
  end

  def deep_dup(array)
      final_array = array.map do |element|
        if element.is_a?(Array)
          deep_dup(element)
        else element
        end
      end
      final_array
  end

  def non_check_moves(start_pos,end_pos, current_player)
    dup_board = deep_dup(@board.grid)
    dup_board[end_pos[0]][end_pos[1]] = dup_board[start_pos[0]][start_pos[1]]
    dup_board[start_pos[0]][start_pos[1]] = VoidPiece.new
    if current_player.king.in_check?(current_player)
      return false
    end
    return true
  end

  def allied_pieces(current_player)
    pieces_array = []
    board.grid.each do |row|
      row.each do |space|
        if space.color == current_player.color
          pieces_array << space
        end
      end
    end
    pieces_array
  end

  def checkmate?(current_player)
    all_possible_moves = {}
    allied_pieces(current_player).each do |piece|
      all_possible_moves[piece.current_pos] = piece.possible_moves(piece.current_pos)
    end

    all_possible_moves.each do |start_pos, possibles|
      possibles.each do |poss|
        return false if non_check_moves(start_pos, poss,current_player)
      end
    end
    true
  end


  def deltas
    DELTA
  end

  def symbol
    "  ♔  "
  end

end
