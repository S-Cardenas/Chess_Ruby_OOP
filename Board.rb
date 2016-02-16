require_relative 'display0'
require_relative 'Piece'
require_relative 'Player'
require 'byebug'

class Board
  attr_accessor :grid, :player_1, :player_2

  def initialize
    @grid = Array.new(8){Array.new(8)}
    @player_1 = Player.new(self,'white', "p1")
    @player_2 = Player.new(self,'black', "p2")
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
        @grid[row][space] = Pawn.new(self,@player_2,[row,space]) if row == 1
        @grid[row][space] = Pawn.new(self,@player_1,[row,space]) if row == 6
      end
    end
  end

  def populate_other
    knight_pos = [[0,1], [0,6], [7,1], [7,6]]
    knight_pos.take(2).each { |pos| @grid[pos[0]][pos[1]] = Knight.new(self,@player_2) }
    knight_pos.drop(2).each { |pos| @grid[pos[0]][pos[1]] = Knight.new(self,@player_1) }
    rook_pos = [[0,0], [0,7], [7,0], [7,7]]
    rook_pos.take(2).each { |pos| @grid[pos[0]][pos[1]] = Rook.new(self,@player_2) }
    rook_pos.drop(2).each { |pos| @grid[pos[0]][pos[1]] = Rook.new(self,@player_1) }
    bishop_pos = [[0,2], [0,5], [7,2], [7,5]]
    bishop_pos.take(2).each { |pos| @grid[pos[0]][pos[1]] = Bishop.new(self, @player_2) }
    bishop_pos.drop(2).each { |pos| @grid[pos[0]][pos[1]] = Bishop.new(self, @player_1) }
    @grid[0][3] = Queen.new(self,@player_2)
    @grid[7][3] = Queen.new(self,@player_1)
    @grid[0][4] = King.new(self,@player_2).set_player
    @grid[7][4] = King.new(self,@player_1).set_player
  end

  def populate_board_spaces
    array = [2,3,4,5]
    array.each do |row|
      @grid[row].each_index do |space|
        @grid[row][space] = VoidPiece.new
      end
    end
  end

  def move(start, end_pos)
    @grid[end_pos[0]][end_pos[1]] = @grid[start[0]][start[1]]
    @grid[start[0]][start[1]] = VoidPiece.new
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



  def piece_present?(pos)
    return false if @grid[pos[0]][pos[1]].class == VoidPiece || @grid[pos[0]][pos[1]].nil?
    true
  end


end

# b = Board.new
# b.grid[2][3] = Knight.new(self,b.player_1)
# debugger
# p b.grid[0][4].in_check?(b.player_2)
