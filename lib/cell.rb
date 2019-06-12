# frozen_string_literal: true

class Cell
  attr_accessor :coordinate, :ship, :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    @ship&.hit
  end

  def place_ship(ship)
    @ship = ship
  end

  def render(reveal = false)
    case @fired_upon
    when false && reveal
      'S'
    when true && empty?
      'M'
    when true && !@ship.sunk?
      'H'
    when true && @ship.sunk?
      'X'
    else
      '.'
    end
  end
end
