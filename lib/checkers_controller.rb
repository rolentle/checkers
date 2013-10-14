class CheckersController
  attr_accessor :current_player, :model

  def initialize(model)
    @current_player = :white
    @model = model
  end

  def move(old_position, new_position)
    piece = model.find_by_position(old_position)
    if piece.color == current_player
      piece.move_to(new_position)
      change_player
      exit if check_game_is_over
    else
      raise StandardError
    end
  end

  def change_player
    if current_player == :white
      @current_player = :black
    else
      @current_player = :white
    end
  end

  def check_game_is_over
    model.winner?
  end
end
