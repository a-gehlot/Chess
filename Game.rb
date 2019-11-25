require_relative "Display.rb"

class Game
    def initialize
        @board = Board.new
        @board.populate
        @display = Display.new(@board)
        @players = {"Player1" => Player.new(:white, @display), "Player2" => Player.new(:black, @display)}
        @current_player = @players["Player1"]
    end

    def swap_turn!
        if @current_player == @players["Player1"]
            @current_player = @players["Player2"]
        else
            @current_player = @players["Player1"]
        end
    end

    def play
        until @board.checkmate?(:white) || @board.checkmate?(:black)
            @current_player.make_move
            self.swap_turn! #this method is where running into trouble
        end
    end




end

class Player
    def initialize(color, display)
        @color = color
        @display = display
    end

    def make_move
        @display.render_turn(@color)
    end

end
