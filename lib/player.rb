# frozen_string_literal: true

require_relative('./board')

class Player
  attr_accessor :board, :shot_history

  def initialize
    @board = Board.new
    @shot_history = []
  end
  
  def place_ship(ship)
    
  end
end