require "colorize"
require_relative "cursorable"

class Display
  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
  end

  def build_grid
    @board.grid.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :blue
    elsif (i + j).odd?
      bg = :light_black
    else
      bg = :cyan
    end
    { background: bg }
  end

  def render
    system("clear")
    puts "Please select a square."
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    build_grid.each_with_index do  |row, idx|
      print idx + 1
      puts row.join
    end
    out = ' '
    "ABCDEFGH".split('').each do |letter|
      out += "  " + letter + "  "
    end
    puts out
  end

end
