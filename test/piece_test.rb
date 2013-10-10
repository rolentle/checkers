gem 'minitest'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/checkers'
require './lib/piece'

class PieceTest < Minitest::Test

  attr_reader :cm
  def setup
    @cm = CheckersModel.new
  end

  def test_it_knows_it_color
    p00 = cm.board[0][0]
    assert_equal :white, p00.color
  end

  def test_it_knows_its_position
    p02 = cm.board[0][2]
    assert_equal [0,2], p02.position
  end

  def test_move_to_moves_piece_diagonally
    p04 = cm.board[2][4]
    p04.move_to([3,5])
    assert_equal [3,5], p04.position
  end

  def test_cannot_move_to_the_left
    p24 = cm.board[2][4]
    assert_raises(StandardError) do
      p24.move_to([2,5])
    end
  end

  def test_cannot_move_off_board
    p17 = cm.board[1][7]
    assert_raises(StandardError) do
      p17.move_to([2,9])
    end
  end

  def test_cannot_move_to_an_occupied_square
    p17 = cm.board[1][7]
    assert_raises(StandardError) do
      p17.move_to([2,6])
    end
  end

  def test_white_piece_can_take_black_piece
    p24 = cm.board[2][4]
    cm.board[3][5] = Piece.new(cm, :black)
    p24.move_to([4,6])
    assert_equal "", cm.board[3][5]
  end

  def test_white_can_take_black_piece_on_the_left
    p24 = cm.board[2][4]
    cm.board[3][3] = Piece.new(cm, :black)
    p24.move_to([4,2])
    assert_equal "", cm.board[3][3]
  end

end
