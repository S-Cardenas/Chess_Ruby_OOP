require_relative 'display0'
require_relative 'Piece'
require_relative 'Player'

class Board
  attr_accessor :grid

  def initialize (player_1, player_2)
    @grid = Array.new(8){Array.new(8)}
    @player_1  = player_1
    @player_2 = player_2
    populate
  end

  def populate
    populate_pawns
    populate_other
    populate_board_spaces
  end

  def populate_pawns
    array = [1,6]
    array.each do |row|
      @grid[row].each_index do |space|
        @grid[row][space] = Pawn.new(self)
      end
    end
  end

  def populate_other
    knight_pos = [[0,1], [0,6], [7,1], [7,6]]
    knight_pos.each { |pos| @grid[pos[0]][pos[1]] = Knight.new(self) }
    rook_pos = [[0,0], [7,0], [0,7], [7,7]]
    rook_pos.each { |pos| @grid[pos[0]][pos[1]] = Rook.new(self) }
    bishop_pos = [[0,2], [0,5], [7,2], [7,5]]
    bishop_pos.each { |pos| @grid[pos[0]][pos[1]] = Bishop.new(self) }
    queens_pos = [[0,3], [7,3]]
    queens_pos.each { |pos| @grid[pos[0]][pos[1]] = Queen.new(self) }
    kings_pos = [[0,4], [7,4]]
    kings_pos.each { |pos| @grid[pos[0]][pos[1]] = King.new(self) }
  end

  def populate_board_spaces
    array = [2,3,4,5]
    array.each do |row|
      @grid[row].each_index do |space|
        @grid[row][space] = VoidPiece.new(self)
      end
    end
  end

  def move(start, end_pos)
    unless piece_present?(start)
      raise "No piece there"
    end
    if valid_move?(start, end_pos)  #COME BACK TO MEEEE
      if piece_present?(end_pos)
        @grid[end_pos[0]][end_pos[1]] = nil
      end
      @grid[end_pos[0]][end_pos[1]] = @grid[start[0]][start[1]]
      @grid[start[0]][start[1]] = nil
    end

  end


  def valid_move?(start,end_pos) #COME BACK TO MEEE TOOO
    true
  end

  def render
    @grid.each do |row|
      array = []
      row.each do |space|
        if space.nil?
          array << " "
        else
          array <<  space.to_s
        end
      end
      p array
    end
  end

  def in_bounds?(pos)
    pos.all? {|place| place.between?(0,7)}
  end

  private
  def piece_present?(pos)
    return false if @grid[pos[0], pos[1]].nil?
    true
  end

end

b = Board.new("a","b")
p1 = Player.new(b)
p1.move
