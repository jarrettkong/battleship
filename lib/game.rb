# frozen_string_literal: true

require_relative('./ship')
require_relative('./cell')
require_relative('./board')

class Game
  attr_accessor :board

  def initialize
    @player_board = Board.new
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
    place_cpu_ship(Ship.new('Cruiser', 3))
    place_cpu_ship(Ship.new('Submarine', 2))

    puts "\nThe CPU has placed their ships."
    puts 'You may now place your ships.'
    puts 'The Crusier is 2 units long and the Submarine is 2 units long.'

    place_ship(Ship.new('Cruiser', 3))
    place_ship(Ship.new('Submarine', 2))

    play_game
  end

  def place_ship(ship)
    puts "\nWhere would you like to place the #{ship.name} (#{ship.length} spaces)?"
    puts 'Type your coordinates separated by spaces ie. A1 A2 A3'
    coordinates = gets.chomp.split(' ')
    until @player_board.valid_placement?(ship, coordinates)
      puts "\nThose are invalid coordinates. Please try again."
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
    render
    while board_has_ships(@player_board) && board_has_ships(@cpu_board)
      puts "\nWhere would you like to attack?"
      coordinate = gets.chomp

      unless @cpu_board.valid_coordinate?(coordinate)
        puts 'Invalid coordinate.'
        next
      end

      @cpu_board.cells[coordinate].fire_upon
      puts "You have attacked #{coordinate}."
      determine_attack(@cpu_board, coordinate)
      cpu_attack
      render
    end
    determine_winner
  end

  def render
    puts '======== Player ========'
    puts @player_board.render(true)
    puts "\n======== CPU ========"
    puts @cpu_board.render
  end

  def cpu_attack
    coordinate = @player_board.cells.keys.sample
    @player_board.cells[coordinate].fire_upon
    puts "\nThe CPU has attacked #{coordinate}."
    puts determine_attack(@player_board, coordinate)
  end

  def determine_attack(board, coordinate)
    case board.cells[coordinate].render
    when 'M'
      puts 'The attack missed.'
    when 'H'
      puts 'The attack hit.'
    when 'X'
      puts 'The attack hit and the ship was sunk.'
    end
  end

  def board_has_ships(board)
    board.cells.any? { |_, cell| !cell.ship&.sunk? && !cell.ship.nil? }
  end

  def determine_winner
    puts "\nGAME OVER"
    if board_has_ships(@player_board)
      puts 'You have won!'
    else
      puts 'The CPU has won!'
    end
  end
end
