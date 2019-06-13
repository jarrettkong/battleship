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
    if !@fired_upon && reveal && !empty?
      'S'
    elsif @fired_upon && empty?
      'M'
    elsif @fired_upon && !@ship.sunk?
      'H'
    elsif @fired_upon && @ship.sunk?
      'X'
    else
      '.'
    end
  end
end
