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

  def test_black_piece_move_diagonally
    p51 = cm.board[5][1]
    p51.move_to([4,2])
    assert_equal [4,2], p51.position
  end

  def test_black_piece_cannot_move_side
    p51 = cm.board[5][1]
    assert_raises(StandardError) do
      p51.move_to([5,2])
    end
  end

  def test_black_piece_can_take_white_piece
    p51 = cm.board[5][1]
    cm.board[4][2] = Piece.new(cm, :white)
    p51.move_to([3,3])
    assert_equal "", cm.board[4][2]
  end

  def test_black_piece_can_another_white_piece
    p51 = cm.board[5][3]
    cm.board[4][2] = Piece.new(cm, :white)
    p51.move_to([3,1])
    assert_equal "", cm.board[4][2]
  end

  def test_white_piece_can_become_king
    cm.board[6][6] = Piece.new(cm, :white)
    cm.board[7][7] = ""
    cm.board[6][6].move_to([7,7])
    assert cm.board[7][7].king
  end

  def test_white_king_can_move_backward
    p66 = Piece.new(cm, :white)
    cm.board[6][6] = p66
    cm.board[7][7] = ""
    cm.board[6][6].move_to([7,7])
    cm.board[7][7].move_to([6,6])
    assert_equal cm.board[6][6], p66
  end

  def test_white_king_can_move_backwards_in_other_direction
    p66 = Piece.new(cm, :white)
    cm.board[6][6] = p66
    cm.board[7][5] = ""
    cm.board[6][6].move_to([7,5])
    cm.board[6][4] = ""
    cm.board[7][5].move_to([6,4])
    assert_equal cm.board[6][4], p66
  end

  def test_black_piece_can_become_king
    cm.board[1][1] = Piece.new(cm, :black)
    cm.board[0][0] = ""
    cm.board[1][1].move_to([0,0])
    assert cm.board[0][0].king
  end

  def test_black_king_can_move_backwards
    p13 = Piece.new(cm, :black)
    cm.board[1][3] = p13
    cm.board[0][2] = ""
    p13.move_to([0,2])
    p13.move_to([1,3])
    assert_equal cm.board[1][3], p13
  end

  def test_black_kingcan_move_backwards_in_other_directions
    p13 = Piece.new(cm, :black)
    cm.board[1][3] = p13
    cm.board[0][2] = ""
    p13.move_to([0,2])
    cm.board[1][1] = ""
    p13.move_to([1,1])
    assert_equal cm.board[1][1], p13
  end
end
