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
    return false if ship.length != coordinates.length
    return false if coordinates.uniq.length != coordinates.length
    return false if diagonal?(coordinates)
    # return false if overlap?(ship, coordinates)
    true
  end

  def diagonal?(coordinates)
    # valid_letters = ('A'..'D').to_a
    # valid_numbers = (1..4).to_a
    letters = coordinates.map { |coor| coor[0] }
    numbers = coordinates.map { |coor| coor[1] }
    
    true
  end
end
