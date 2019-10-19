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
                if pos == @cursor.cursor_pos
                    print @board[pos].symbol.colorize(:red) + " "
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
a.move_piece(:white, [6,5], [5,5])
b.render
a.move_piece(:black, [1,4], [3,4])
b.render
a.move_piece(:white, [6,6], [4,6])
b.render
a.move_piece(:black, [0,3], [4,7])
b.render
puts a.checkmate?(:white)
