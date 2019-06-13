# frozen_string_literal: true

require_relative './cell'

class Board
  attr_accessor :cells

  def initialize
    @cells = {}

    @keys = %w[A1 A2 A3 A4 B1 B2 B3 B4 C1 C2 C3 C4 D1 D2 D3 D4].freeze
    @keys.map { |cell| @cells[cell] = Cell.new(cell) }
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
    if valid_placement?(ship, coordinates)
      coordinates.each { |coord| @cells[coord].place_ship(ship) }
    end
  end

  def render(reveal = false)
    rows = @cells.keys.map do |k|
      k[1]
    end.uniq
    columns = @cells.keys.map do |k|
      k[0]
    end.uniq

    rows.each_with_object(+"  A B C D\n") do |row, acc|
      acc << "#{row} "
      columns.each do |col|
        acc << @cells[col + row].render(reveal) + ' '
      end
      acc << "\n"
    end
  end
end
