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
