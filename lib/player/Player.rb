require_relative "display0"

class Player
  attr_reader :name
  attr_accessor :color, :king
  def initialize(board, color, name)
    @display = Display.new(board)
    @color = color
    @name = name
    @king = nil
  end

  def move
    result = nil
    until result
      @display.render
      result = @display.get_input
    end
    result
  end


end
