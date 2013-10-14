class Piece
  attr_reader :color, :model, :king

  def initialize(model,color)
    @model = model
    @color = color
    @king = false
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

      if color == :white && row == 7
	@king = true
      elsif color == :black && row == 0
	@king = true
      end
    end
  end

  def valid_move?(new_position)
    unless model.board[new_position[0]][new_position[1]].to_s.empty?
      raise StandardError
    end

    if new_position == position
      raise StandardError
    end

    if color == :white
      white_piece_logic(new_position)
    elsif color == :black
      black_piece_logic(new_position)
    end
  end

  def white_piece_logic(new_position)
    if new_position[0] == position[0]+2 && new_position[1] == position[1]+2 && model.board[position[0]+1][position[1]+1].color == :black
      model.board[position[0]+1][position[1]+1] = ""
    elsif new_position[0] == position[0]+2 && new_position[1] == position[1]-2 && model.board[position[0]+1][position[1]-1].color == :black
      model.board[position[0]+1][position[1]-1] = ""
    elsif new_position[0] == position[0]+1 && new_position[1] == position[1]-1
      true
    elsif new_position[0] == position[0]+1 && new_position[1] == position[1]+1
      true
    elsif new_position[0] == position[0]+4 && new_position[1] == position[1]+4 && model.board[position[0]+1][position[1]+1].color == :black && model.board[position[0]+2][position[1]+2] == "" && model.board[position[0]+3][position[1]+3].color == :black
      model.board[position[0]+1][position[1]+1] = ""
      model.board[position[0]+3][position[1]+3] = ""
    elsif new_position[0] == position[0]+4 && new_position[1] == position[1]-4 && model.board[position[0]+1][position[1]-1].color == :black && model.board[position[0]+2][position[1]-2] == "" && model.board[position[0]+3][position[1]-3].color == :black
      model.board[position[0]+1][position[1]-1] = ""
      model.board[position[0]+3][position[1]-3] = ""
    elsif king && new_position[0] == position[0]-1 && new_position[1] == position[1]-1
      true
    elsif king && new_position[0] == position[0]-1 && new_position[1] == position[1]+1
      true
    else
      raise StandardError
    end
  end

  def black_piece_logic(new_position)
    if new_position[0] == position[0]-2 && new_position[1] == position[1]+2 && model.board[position[0]-1][position[1]+1].color == :white
      model.board[position[0]-1][position[1]+1] = ""
    elsif new_position[0] == position[0]-2 && new_position[1] == position[1]-2 && model.board[position[0]-1][position[1]-1].color ==:white
      model.board[position[0]-1][position[1]-1] = ""
    elsif new_position[0] == position[0]-1 && new_position[1] == position[1]-1
      true
    elsif new_position[0] == position[0]-1 && new_position[1] == position[1]+1
      true
    elsif new_position[0] == position[0]-4 && new_position[1] == position[1]+4 && model.board[position[0]-1][position[1]+1].color == :white && model.board[position[0]-2][position[1]+2] == "" && model.board[position[0]-3][position[1]+3].color == :white
      model.board[position[0]-1][position[1]+1] = ""
      model.board[position[0]-3][position[1]+3] = ""
    elsif new_position[0] == position[0]-4 && new_position[1] == position[1]-4 && model.board[position[0]-1][position[1]-1].color == :white && model.board[position[0]-2][position[1]-2] == "" && model.board[position[0]-3][position[1]-3].color == :white
      model.board[position[0]-1][position[1]-1] = ""
      model.board[position[0]-3][position[1]-3] = ""
    elsif king && new_position[0] == position[0]+1 && new_position[1] == position[1]+1
      true
    elsif king && new_position[0] == position[0]+1 && new_position[1] == position[1]-1
      true
    else
      raise StandardError
    end
  end
end
