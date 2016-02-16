# coding: utf-8
require 'byebug'
class Piece
  attr_reader :player, :board

  def initialize(board, player)
    @player = player
    @board = board
  end

  def to_s
    symbol.colorize(self.color.to_sym)
  end

  def current_pos
    @board.grid.each_with_index do |row, i|
      row.each_with_index do |space, j|
        return [i, j] if space == self
      end
    end
  end

  def color
    player.color
  end

end

class VoidPiece
  def color
    "Mauve"
  end

  def to_s
    "     "
  end
end

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


class Bishop < SlidingPiece


  def possible_moves(pos)
    diagonal(pos)
  end

  def symbol
    "  ♗  "
  end

end

class Rook < SlidingPiece


  def possible_moves(pos)
    orthogonal(pos)
  end

  def symbol
    "  ♖  "
  end


end


class Queen < SlidingPiece


  def possible_moves(pos)
    orthogonal(pos) + diagonal(pos)
  end


  def symbol
    "  ♕  "
  end

end

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
