require 'colorize'
require_relative 'cursor.rb'
require_relative 'board.rb'

class Display

    attr_reader :cursor

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def render
        (0..7).each do |row|
            (0..7).each do |col|
                pos = [row,col]
                moves = @board[@cursor.cursor_pos].moves
                if pos == @cursor.cursor_pos
                    print @board[pos].symbol.colorize(:background => :green) + " "
                elsif moves.include?(pos)
                    print @board[pos].symbol.colorize(:cyan) + " "
                else 
                    print @board[pos].symbol + " "
                end
            end
            puts
        end
    end

    def render_select(frozen)
        (0..7).each do |row|
            (0..7).each do |col|
                pos = [row, col]
                moves = @board[frozen].moves
                if pos == @cursor.cursor_pos
                    print @board[pos].symbol.colorize(:color => :magenta, :background => :green) + " "
                elsif moves.include?(pos)
                    print @board[pos].symbol.colorize(:blue) + " "
                else
                    print @board[pos].symbol + " "
                end
            end
            puts
        end
    end

    def render_turn(color)
    begin
        a = @cursor.get_input
        if @cursor.selected
            system("clear")
            self.render_select(a)
            until !@cursor.selected
                b = @cursor.get_input
                system("clear")
                self.render_select(a)
            end
            @board.move_piece(color, a, b)
        end
        system("clear")
        self.render
    rescue
        puts "invalid"
        retry
    end
    end

end

a = Board.new
b = Display.new(a)
a.populate
a.move_piece(:white, [6,5], [4,5])
b.render
a.move_piece(:black, [1,4], [3,4])
b.render
a.move_piece(:white, [6,6], [4,6])
b.render_turn(:black)
