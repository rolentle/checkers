require './lib/piece'

class CheckersModel
  attr_accessor :board, :white_pieces, :black_pieces
  def initialize
    create_board
    populate_board
  end

  def create_board
    @board = []
    8.times do
      @board << Array.new(8, "")
    end
  end

  def populate_board
    populate_white_pieces
    populate_black_pieces
  end

  def populate_white_pieces
    board[0].each_index do  |index|
      board[0][index] = Piece.new(self, :white) if index.even?
    end

    board[1].each_index do |index|
      board[1][index] = Piece.new(self, :white) if index.odd?
    end

    board[2].each_index do  |index|
      board[2][index] = Piece.new(self, :white) if index.even?
    end
  end

  def populate_black_pieces
    board[5].each_index do |index|
      board[5][index] = Piece.new(self, :black) if index.odd?
    end

    board[6].each_index do  |index|
      board[6][index] = Piece.new(self, :black) if index.even?
    end

    board[7].each_index do |index|
      board[7][index] = Piece.new(self, :black) if index.odd?
    end
  end

  def all_pieces
    board.flatten.select { |square| square.class == Piece }
  end

  def black_pieces
    all_pieces.select { |piece| piece.color == :black }
  end

  def white_pieces
    all_pieces.select { |piece| piece.color == :white }
  end

  def game_over?
    !white_pieces || !black_pieces
  end

  def find_by_position(subject_position)
    all_pieces.find { |piece| piece.position == subject_position}
  end

  def winner?
    if !white_pieces
      :black
    elsif !black_pieces
      :white
    end
  end
end

