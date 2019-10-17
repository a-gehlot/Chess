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

end