# frozen_string_literal: true

require 'minitest/spec'
require 'minitest/autorun'
require './lib/ship'

class ShipTest < Minitest::Test
  def setup
    @cruiser = Ship.new('Cruiser', 3)
  end

  def test_it_exists
    assert_instance_of Ship, @cruiser
  end

  def test_it_has_name
    assert_equal @cruiser.name, 'Cruiser'
  end

  def test_it_has_length
    assert_equal @cruiser.length, 3
  end

  def test_it_has_health
    assert_equal @cruiser.health, 3
  end

  def test_it_is_not_sunk
    assert_equal @cruiser.sunk?, false
  end

  def test_it_loses_health_when_hit
    @cruiser.hit
    assert_equal @cruiser.health, 2
  end

  def test_it_sinks
    @cruiser.hit
    @cruiser.hit
    @cruiser.hit
    assert_equal @cruiser.health, 0
    assert_equal @cruiser.sunk?, true
  end
end
