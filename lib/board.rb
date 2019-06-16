# frozen_string_literal: true

require_relative './cell'

class Board
  attr_accessor :cells

  def initialize
    numbers = (1..4).to_a
    letters = ('A'..'D').to_a

    @cells = letters.inject({}) do |acc, letter|
      numbers.each do |num|
        coordinate = letter + num.to_s
        acc[coordinate] = Cell.new(coordinate)
      end
      acc
    end
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    possible_coordinates = calculate_possible_coordinates(coordinates[0], ship.length)
    return false if coordinates.any? { |coord| !valid_coordinate?(coord) }
    return false if coordinates.any? { |coord| overlap?(coord) }
    return false unless possible_coordinates.include?(coordinates)

    true
  end

  def calculate_possible_coordinates(start, length)
    letters = (start[0].ord..(start[0].ord + length - 1)).to_a.map!(&:chr)
    numbers = (start[1].to_i..(start[1].to_i + length - 1)).to_a
    [
      numbers.map { |num| "#{letters[0]}#{num}" },
      letters.map { |letter| "#{letter}#{numbers[0]}" }
    ]
  end

  def overlap?(coordinate)
    !@cells[coordinate].ship.nil?
  end

  def place(ship, coordinates)
    coordinates.each { |coord| @cells[coord].place_ship(ship) } if valid_placement?(ship, coordinates)
  end

  def render(reveal = false)
    rows = @cells.keys.map do |k|
      k[1]
    end.uniq
    columns = @cells.keys.map do |k|
      k[0]
    end.uniq

    rows.inject(+"  #{columns.join(' ')}\n") do |acc, row|
      acc << "#{row} "
      columns.each do |col|
        acc << "#{@cells[col + row].render(reveal)} "
      end
      acc << "\n"
    end
  end
end
