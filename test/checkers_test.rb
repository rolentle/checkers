gem 'minitest'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './checkers'

class CheckersModelTest < Minitest::Test

  attr_reader :cm

  def setup
    @cm = CheckersModel.new
  end
  def test_model_exists
    assert_kind_of CheckersModel, cm
  end

  def test_board_has_64_squares
    assert_equal 64, cm.board.flatten.count
  end

  def test_00_has_a_piece
    assert_kind_of Piece, cm.board[0][0]
  end

  def test_row0_has_four_pieces
    assert_equal 4, cm.board[0].count { |square| square.class == Piece }
  end

  def test_row1_has_four_pieces_every_other_square
    cm.board[1].each_index do |index|
      if index.odd?
        assert_kind_of Piece, cm.board[1][index]
      end
    end
  end

  def test_pieces_row2_are_white
    cm.board[2].each do |square|
      if square.class == Piece
	assert_equal :white,  square.color
      end
    end
  end

  def test_pice_77_has_black_piece
    assert_equal :black, cm.board[7][7].color
  end

  def test_row6_has_4_black_pieces
    assert_equal 4, cm.board[6].count { |square| square.class == Piece }
  end
end
