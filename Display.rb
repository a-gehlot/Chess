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
                    print @board[pos].symbol.colorize(:red) + " "
                elsif moves.include?(pos)
                    print @board[pos].symbol.colorize(:green) + " "
                else print @board[pos].symbol + " "
                end
            end
            puts
        end
    end

    def render_loop
        loop do
            @cursor.get_input
            system("clear")
            self.render
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
b.render_loop
