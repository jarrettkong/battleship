# frozen_string_literal: true

require_relative('./board')

class Player
  attr_accessor :board, :shot_history

  def initialize
    @board = Board.new
    @shot_history = []
  end
  
  def place_ship(ship, coordinates)
    @board.place(ship, coordinates)
  end

  def attack(player, coordinate)
    player.board.cells[coordinate].fire_upon
    determine_attack(player.board, coordinate)
  end

  def determine_attack(board, coordinate)
    case board.cells[coordinate].render
    when 'M'
      return 'The attack missed.'
    when 'H'
      return 'The attack hit.'
    when 'X'
      return 'The attack hit and the ship was sunk.'
    end
  end

  def has_ships?
    @board.cells.any? { |_, cell| !cell.ship&.sunk? && !cell.ship.nil? }
  end
end