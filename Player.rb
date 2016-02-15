require_relative "display0"

class Player
  def initialize(board)
    @display = Display.new(board)
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
