# frozen_string_literal: true

class Ship
  attr_accessor :name, :length, :health

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
  end

  def hit
    @health -= 1 unless @health.zero?
  end

  def sunk?
    @health.zero?
  end
end
