# frozen_string_literal: true

require 'minitest/spec'
require 'minitest/autorun'
require './lib/cell'
require './lib/ship'

class CellTest < Minitest::Test
  def setup
    @cell = Cell.new('B4')
    @cruiser = Ship.new('Cruiser', 3)
  end

  def test_it_exists
    assert_instance_of Cell, @cell
  end

  def test_it_has_coordinate
    assert_equal @cell.coordinate, 'B4'
  end

  def test_it_has_ship
    assert_equal @cell.ship, nil
  end

  def test_it_is_empty
    assert_equal @cell.empty?, true
  end

  def test_it_is_fired_upon
    assert_equal @cell.fired_upon?, false
  end

  def test_it_has_ship
    @cell.place_ship(@cruiser)
    assert_equal @cell.ship, @cruiser
    assert_equal @cell.empty?, false
  end

  def test_it_has_been_hit
    @cell.fire_upon
    assert_equal @cell.fired_upon, true
  end

  def test_ship_loses_health
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    assert_equal @cell.ship.health, 2
  end

  def test_render_not_fired
    assert_equal @cell.render, '.'
  end

  def test_render_miss
    @cell.fire_upon
    assert_equal @cell.render, 'M'
  end

  def test_render_hit
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    assert_equal @cell.render, 'H'
  end

  def test_render_sunk
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    @cell.ship.hit
    @cell.ship.hit
    assert_equal @cell.render, 'X'
  end
end
