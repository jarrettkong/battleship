# frozen_string_literal: true

class Cell
  attr_accessor :coordinate, :ship

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
    when false && reveal && !empty?
      p empty?
      'S'
    when true && empty?
      'M'
    when true && !empty? && !@ship.sunk?
      'H'
    when true && !empty && @ship.sunk?
      'X'
    else
      '.'
    end
  end
end
