# frozen_string_literal: true

require_relative('./ship')
require_relative('./cell')
require_relative('./board')

class Game
  attr_accessor :board

  def initialize
    @player_submarine = Ship.new('Submarine', 2)
    @player_cruiser = Ship.new('Cruiser', 3)
    @player_board = Board.new

    @cpu_submarine = Ship.new('Submarine', 2)
    @cpu_cruiser = Ship.new('Cruiser', 3)
    @cpu_board = Board.new
  end

  def start
    puts 'Welcome to BATTLESHIP'
    puts 'Enter p to play. Enter q to quit.'
    option = gets.chomp.downcase

    while option != 'p' && option != 'q'
      puts 'Enter p to play. Enter q to quit.'
      option = gets.chomp
    end

    exit if option == 'q'
    play_game
  end

  def play_game
    place_cpu_ship(@cpu_cruiser)
    place_cpu_ship(@cpu_submarine)
    puts 'The CPU has placed their ships.'
    puts 'You may now place your ships.'
    puts 'The Crusier is 2 units long and the Submarine is 2 units long.'
  end

  def place_cpu_ship(ship)
    coordinates = @cpu_board.cells.keys.sample(ship.length)
    until @cpu_board.valid_placement?(ship, coordinates)
      coordinates = @cpu_board.cells.keys.sample(ship.length)
    end
    @cpu_board.place(ship, coordinates)
  end
end
