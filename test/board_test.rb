# frozen_string_literal: true

require 'minitest/spec'
require 'minitest/autorun'
require './lib/ship'
require './lib/board'

class BoardTest < Minitest::Test
  def setup
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
    @board = Board.new
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_it_has_cells
    assert_instance_of Hash, @board.cells
    @board.cells.each_value { |value| assert_instance_of Cell, value }
    assert_equal @board.cells.keys.include?('A1'), true
    assert_equal @board.cells.keys.include?('D4'), true
  end

  def test_valid_coordinate
    assert_equal @board.valid_coordinate?('A1'), true
    assert_equal @board.valid_coordinate?('A99'), false
  end

  def test_valid_placement_length
    assert_equal @board.valid_placement?(@cruiser, %w[A1 A2]), false
    assert_equal @board.valid_placement?(@submarine, %w[A1 A3 A4]), false
  end

  def test_valid_placement_unique
    assert_equal @board.valid_placement?(@cruiser, %w[B3 C3 C3]), false
    assert_equal @board.valid_placement?(@submarine, %w[A1 A1]), false
  end

  def test_valid_placement_consecutive
    assert_equal @board.valid_placement?(@cruiser, %w[A1 A2 A4]), false
    assert_equal @board.valid_placement?(@submarine, %w[A1 C1]), false
    assert_equal @board.valid_placement?(@cruiser, %w[A3 A2 A1]), false
    assert_equal @board.valid_placement?(@submarine, %w[C1 B1]), false
  end

  def test_valid_placement_out_of_bounds
    assert_equal @board.valid_placement?(@cruiser, %w[A3 A4 A5]), false
    assert_equal @board.valid_placement?(@submarine, %w[F1 G1]), false
  end

  def test_valid_placement_diagonal
    assert_equal @board.valid_placement?(@cruiser, %w[A1 B2 C3]), false
    assert_equal @board.valid_placement?(@submarine, %w[C2 D3]), false
  end

  def test_valid_placement_true
    assert_equal @board.valid_placement?(@submarine, %w[A1 A2]), true
    assert_equal @board.valid_placement?(@cruiser, %w[B1 C1 D1]), true
  end

  def test_place_ship
    @board.place(@cruiser, %w[B1 C1 D1])
    assert_equal @board.cells['B1'].ship, @cruiser
    assert_equal @board.cells['C1'].ship, @cruiser
    assert_equal @board.cells['D1'].ship, @cruiser
  end

  def test_place_ship_invalid
    @board.place(@cruiser, %w[B1 C1 D1])
    assert_equal @board.cells['B1'].ship, @cruiser
    assert_equal @board.cells['C1'].ship, @cruiser
    assert_equal @board.cells['D1'].ship, @cruiser

    @board.place(@submarine, %w[C1 C2])
    assert_equal @board.cells['C1'].ship, @cruiser
    assert_nil @board.cells['C2'].ship
  end

  def test_render
    @board.place(@submarine, %w[C1 C2])

    expected = "  A B C D\n1 . . . . \n2 . . . . \n3 . . . . \n4 . . . . \n"
    assert_equal @board.render, expected
  end

  def test_render_reveal
    @board.place(@submarine, %w[C1 C2])

    expected = "  A B C D\n1 . . S . \n2 . . S . \n3 . . . . \n4 . . . . \n"
    assert_equal @board.render(true), expected
  end

  def test_render_miss
    @board.cells['C1'].fire_upon
    expected = "  A B C D\n1 . . M . \n2 . . . . \n3 . . . . \n4 . . . . \n"
    assert_equal @board.render, expected
  end

  def test_render_hit
    @board.place(@submarine, %w[C1 C2])
    @board.cells['C1'].fire_upon

    expected = "  A B C D\n1 . . H . \n2 . . . . \n3 . . . . \n4 . . . . \n"
    assert_equal @board.render, expected
  end

  def test_render_sunk
    @board.place(@submarine, %w[C1 C2])
    @board.cells['C1'].fire_upon
    @board.cells['C2'].fire_upon

    expected = "  A B C D\n1 . . X . \n2 . . X . \n3 . . . . \n4 . . . . \n"
    assert_equal @board.render, expected
  end
end
