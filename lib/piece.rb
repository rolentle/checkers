class Piece
  attr_reader :color, :model
  def initialize(model,color)
    @model = model
    @color = color
  end

  def position
    model.board.each_index do |row|
      if model.board[row].index(self)
        @position = [row,model.board[row].index(self)]
      end
    end
    @position
  end

  def move_to(new_position)
    if valid_move?(new_position)
      row = new_position[0]
      square = new_position[1]
      model.board[position[0]][position[1]] = ""
      model.board[row][square] = self
    end
  end

  def valid_move?(new_position)
    unless model.board[new_position[0]][new_position[1]].to_s.empty?
      raise StandardError
    end
    white_piece_logic(new_position) if color == :white
  end

  def white_piece_logic(new_position)
    if model.board[new_position[0]][new_position[1]].nil?
      raise StandardError
    elsif new_position[0] == position[0]+2 && new_position[1] == position[1]+2 && model.board[position[0]+1][position[1]+1].color == :black
      model.board[position[0]+1][position[1]+1] = ""
    elsif new_position[0] == position[0]+2 && new_position[1] == position[1]-2 && model.board[position[0]+1][position[1]-1].color == :black
      model.board[position[0]+1][position[1]-1] = ""
    elsif new_position[0] == position[0]+1 && new_position[1] == position[1]-1
      true
    elsif new_position[0] == position[0]+1 && new_position[1] == position[1]+1
      true
    else
      raise StandardError
    end
  end
end
