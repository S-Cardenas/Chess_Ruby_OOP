require 'byebug'
require_relative 'Board'
#might end up needing player

class Game

  attr_reader :current_player, :player_1, :player_2

  def initialize
    @board = Board.new
    @player_1 = @board.player_1
    @player_2 = @board.player_2
    @current_player = @player_1
  end

  def play
    puts "Welcome to chess! You can't win!"
    until game_won?
      puts "It is now #{@current_player.name}'s turn"
      take_turn
      switch_player
      p "#{current_player.name} is in check!" if @current_player.king.in_check?(@current_player)

    end
    puts "It ended...somehow?"
  end

  private
  def game_won?
    return true if @current_player.king.checkmate?(@current_player)
    false
  end

  def switch_player
    if @current_player == @player_1
      @current_player = @player_2
    else
      @current_player = @player_1
    end
  end

  def take_turn
    begin
    start_pos = @current_player.move


    end_pos = @current_player.move

    raise "Error" unless valid_move?(start_pos, end_pos)
    rescue
      "That was a poor life decision"
      retry
    end
    @board.move(start_pos, end_pos)
  end

  def valid_move?(start_pos, end_pos)
    if @current_player.king.in_check?(@current_player)
      return false if @current_player.king.non_check_moves(start_pos, end_pos, @current_player)
    end

    start_row,start_column = start_pos
    return false if @board.grid[start_row][start_column].class == VoidPiece
    return false unless @board.grid[start_row][start_column].color == @current_player.color

    possible_locations = @board.grid[start_row][start_column].possible_moves(start_pos)

    return false unless possible_locations.include?(end_pos)

    true
  end


end

g = Game.new
g.play
