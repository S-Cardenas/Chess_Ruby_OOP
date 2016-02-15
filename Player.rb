require_relative "display0"

class Player
  attr_accessor :color
  def initialize(board, color)
    @display = Display.new(board)
    @color = color
  end

  def move
    result = nil
    until result
      @display.render
      result = @display.get_input
    end
    p result
    result
  end
end
