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

end