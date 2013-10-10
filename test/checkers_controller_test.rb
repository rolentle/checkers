gem 'minitest'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/checkers_controller'

class CheckersControllerTest < Minitest::Test
  def test_checkers_controller_exists
    cc = CheckersController.new
    assert_kind_of CheckersController, cc
  end
end
