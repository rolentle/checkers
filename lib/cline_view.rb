require './lib/checkers/'

class ClineView

  attr_accessor :model

  def initialize(model)
    @model = model
    print_board
  end

  def print_board
    model.board.each do |row|
      puts "#{'_'*32}"
      print"|"
      row.each do |square|
        if square.class == Piece
          if square.color == :white
	    print " W |"
	  else
	    print " B |"
	  end
        else
          print "   |"
        end
      end
      puts "\n"
    end
  end
end

ClineView.new(CheckersModel.new)
