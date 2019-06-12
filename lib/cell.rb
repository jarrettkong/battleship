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
    @ship.health -= 1 unless @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def render
    case self
    when @fired_upon

    end
  end
end
