# frozen_string_literal: true

require_relative './player'

class CPU < Player
  def initialize
    super
  end

  def place_ship(ship)
    coordinates = @board.cells.keys.sample(ship.length)
    until @board.valid_placement?(ship, coordinates)
      coordinates = @board.cells.keys.sample(ship.length)
    end
    @board.place(ship, coordinates)
  end

  def attack(player)
    coordinate = player.board.cells.keys.sample
    while @shot_history.include?(coordinate)
      coordinate = player.board.cells.keys.sample
    end
    player.board.cells[coordinate].fire_upon
    @shot_history << coordinate
    "The CPU has attacked #{coordinate}. #{determine_attack(player.board, coordinate)}"
  end
end
