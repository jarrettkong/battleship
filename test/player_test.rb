# frozen_string_literal: true

require 'minitest/spec'
require 'minitest/autorun'
require './lib/player'
require './lib/ship'

class PlayerTest < Minitest::Test
  def setup
    @player = Player.new
    @opponent = Player.new

    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)

    @player.place_ship(@cruiser, %w[A1 A2 A3])
    @opponent.place_ship(@submarine, %w[D1 D2])
  end

  def test_it_exists
    assert_instance_of Player, @player
  end

  def test_place_ship
    assert_equal @player.board.cells['A1'].ship, @cruiser
    assert_equal @player.board.cells['A2'].ship, @cruiser
    assert_equal @player.board.cells['A3'].ship, @cruiser
  end

  def test_attack
    result = @player.attack(@opponent, 'D1')
    assert_includes @player.shot_history, 'D1'
  end

  def test_determine_attack_miss
    expected = 'You have attacked A1. The attack missed.'
    result = @player.attack(@opponent, 'A1')
    assert_equal result, expected
  end

  def test_determine_attack_hit
    expected = 'You have attacked D1. The attack hit.'
    result = @player.attack(@opponent, 'D1')
    assert_equal result, expected
  end

  def test_determine_attack_sunk
    expected = 'You have attacked D2. The attack hit and the ship was sunk.'
    @player.attack(@opponent, 'D1')
    result = @player.attack(@opponent, 'D2')
    assert_equal result, expected
  end

  def test_ships_true
    assert_equal @player.ships?, true
  end

  def test_ships_false
    @new_player = Player.new    
    assert_equal @new_player.ships?, false
  end
end
