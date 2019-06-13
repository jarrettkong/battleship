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
    setup
  end

  def setup
    place_cpu_ship(@cpu_cruiser)
    place_cpu_ship(@cpu_submarine)

    puts 'The CPU has placed their ships.'
    puts 'You may now place your ships.'
    puts "The Crusier is 2 units long and the Submarine is 2 units long.\n\n"

    place_ship(@player_cruiser)
    place_ship(@player_submarine)

    play_game
  end

  def place_ship(ship)
    puts "Where would you like to place the #{ship.name}?"
    puts 'Type your coordinates separated by spaces ie. A1 A2 A3'
    coordinates = gets.chomp.split(' ')
    until @player_board.valid_placement?(ship, coordinates)
      puts 'Those are invalid coordinates. Please try again.'
      puts 'Type your coordinates separated by spaces ie. A1 A2 A3'
      coordinates = gets.chomp.split(' ')
    end
    @player_board.place(ship, coordinates)
  end

  def place_cpu_ship(ship)
    coordinates = @cpu_board.cells.keys.sample(ship.length)
    until @cpu_board.valid_placement?(ship, coordinates)
      coordinates = @cpu_board.cells.keys.sample(ship.length)
    end
    @cpu_board.place(ship, coordinates)
  end

  def play_game
    
  end
end
