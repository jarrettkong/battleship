# frozen_string_literal: true

require 'minitest/spec'
require 'minitest/autorun'
require './lib/cpu'
require './lib/player'
require './lib/ship'

class PlayerTest < Minitest::Test
  def setup
    @cpu = CPU.new
    @opponent = Player.new

    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)

    @cpu.place_ship(@cruiser)
    @opponent.place_ship(@submarine, %w[D1 D2])
  end

  def test_it_exists
    assert_instance_of CPU, @cpu
  end

  def test_place_ship_exists
    @new_cpu = CPU.new
    assert_equal @new_cpu.ships?, false
    @new_cpu.place_ship(@cruiser)
    assert_equal @new_cpu.ships?, true
  end

  def test_attack_shot_history
    result = @cpu.attack(@opponent)
    assert_equal @cpu.shot_history.length, 1
  end

  def test_attack_miss
    result = nil
    loop do
      result = @cpu.attack(@opponent)
      break if @cpu.shot_history.include?('A1')
    end
    expected = 'The CPU has attacked A1. The attack missed.'
    assert_equal result, expected
  end

  def test_attack_hit
    result = nil
    loop do
      result = @cpu.attack(@opponent)
      break if @cpu.shot_history.include?('D1') || @cpu.shot_history.include?('D2')
    end
    expected_d1 = 'The CPU has attacked D1. The attack hit.'
    expected_d2 = 'The CPU has attacked D1. The attack hit.'
    assert_equal result, expected_d1 || expected_d2
  end

  def test_attack_sunk
    result = nil
    loop do
      result = @cpu.attack(@opponent)
      break if @cpu.shot_history.include?('D1') && @cpu.shot_history.include?('D2')
    end
    expected_d1 = 'The CPU has attacked D1. The attack hit and the ship was sunk.'
    expected_d2 = 'The CPU has attacked D2. The attack hit and the ship was sunk.'
    assert_equal result, expected_d1, expected_d2
  end
end
