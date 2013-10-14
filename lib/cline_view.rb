require './lib/checkers/'
require './lib/checkers_controller'

class ClineView

  attr_accessor :model, :app

  def initialize(app)
    @app = app
    @model = app.model
    print_board
    ask_for_move
  end

  def ask_for_move
    while !app.check_game_is_over
    puts "It is #{app.current_player}'s turn.\nPlease pick a piece to move using the coordinates i.e  x , y"
    piece = gets.chomp.split(",")
    puts "Where whould you like to put that piece?"
    new_position = gets.chomp.split (",")

    app.move(piece, new_position)
    print_board
    end
  end

  def print_board
    puts "  #{(0..7).to_a.join("|  ")}"
    model.board.each do |row|
      puts "#{'_'*32}"
      print"#{model.board.index(row)}"
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

ClineView.new(CheckersController.new(CheckersModel.new))
