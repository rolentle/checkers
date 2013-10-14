gem 'minitest'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/checkers_controller'
require './lib/checkers.rb'

class CheckersControllerTest < Minitest::Test

  attr_reader :cc, :cm

  def setup
    @cm = CheckersModel.new
    @cc = CheckersController.new(cm)
  end

  def test_checkers_controller_exists
    assert_kind_of CheckersController, cc
  end

  def test_game_starts_player_white
    assert_equal :white, cc.current_player
  end

  def test_white_player_can_make_move
    p20 = cm.board[2][0]
    cc.move([2,0], [3,1])

    assert_equal cm.board[3][1], p20
  end

  def test_after_white_player_goes_its_blacks_turn
    p20 = cm.board[2][0]
    cc.move([2,0], [3,1])
    assert_equal :black, cc.current_player
  end

  def test_white_player_cant_move_black_pieces
    assert_raises(StandardError) do
      cc.move([5,5], [6,6])
    end
  end

  def test_game_is_over
    refute cc.check_game_is_over
  end

  def test_black_wins
    cm.white_pieces = nil
    assert_equal :black,cc.check_game_is_over
  end
end
