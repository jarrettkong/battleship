# frozen_string_literal: true

require_relative './ship'
require_relative './player'
require_relative './cpu'

class Game
  def initialize
    @player = Player.new
    @cpu = CPU.new
  end

  def start
    option = nil
    puts 'Welcome to BATTLESHIP'
    loop do
      puts 'Enter p to play. Enter q to quit.'
      option = gets.chomp.downcase
      break if %w[p q].include?(option)

      puts 'Invalid option.'
    end

    exit if option == 'q'
    setup
  end

  def setup
    @cpu.place_ship(Ship.new('Cruiser', 3))
    @cpu.place_ship(Ship.new('Submarine', 2))

    puts "\nThe CPU has placed their ships."
    puts 'You may now place your ships.'
    puts 'The Crusier is 2 units long and the Submarine is 2 units long.'

    place_ship(Ship.new('Cruiser', 3))
    place_ship(Ship.new('Submarine', 2))

    play_game
  end

  def place_ship(ship)
    coordinates = nil
    puts "\nWhere would you like to place the #{ship.name} (#{ship.length} spaces)?"
    loop do
      puts 'Type your coordinates ascending separated by spaces ie. A1 A2 A3'
      coordinates = gets.chomp.split(' ')
      break if @player.board.valid_placement?(ship, coordinates)

      puts "\nThose are invalid coordinates. Please try again."
    end
    @player.place_ship(ship, coordinates)
  end

  def play_game
    render
    while @player.ships? && @cpu.ships?
      puts "\nWhere would you like to attack?"
      coordinate = gets.chomp.upcase

      unless @cpu.board.valid_coordinate?(coordinate)
        puts 'Invalid coordinate.'
        next
      end

      if @player.shot_history.include?(coordinate)
        puts "You have already attacked #{coordinate}"
        next
      end

      puts @player.attack(@cpu, coordinate)
      puts @cpu.attack(@player)
      render
    end
    determine_winner
    start
  end

  def render
    puts "\n======== Player ========"
    puts @player.board.render(true)
    puts "\n======== CPU ========"
    puts @cpu.board.render
  end

  def determine_winner
    puts "\nGAME OVER"
    if !@player.ships? && !@cpu.ships?
      puts "It's a tie!\n\n"
    elsif @player.ships?
      puts "You have won!\n\n"
    else
      puts "The CPU has won!\n\n"
    end
  end
end
