require 'singleton'

class Piece
    attr_reader :color
    attr_writer :pos
    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end

    def to_s
    end

    def symbol
        symbol
    end

end

module Slideable
    HORIZONTAL_DIRS = [[1,0],[0,1],[-1,0],[0,-1]]
    DIAGONAL_DIRS = [[1,1],[-1,1],[-1,-1],[1,-1]]

    def moves 
        moves = []
        if horizontal_dirs
            HORIZONTAL_DIRS.each do |dir|
                a, b = dir
                moves << grow_unblocked_moves_in_dir(a, b)
            end
        end
        if diagonal_dirs
            DIAGONAL_DIRS.each do |dir|
                a, b = dir
                moves << grow_unblocked_moves_in_dir(a, b)
            end
        end
        moves.flatten(1)
    end

    def horizontal_dirs
        move_dirs[:horizontal_dirs]
    end

    def diagonal_dirs
        move_dirs[:diagonal_dirs]
    end

    def grow_unblocked_moves_in_dir(dx, dy)
        x, y = @pos
        new_move = [x + dx, y + dy]
        grown_moves = []
        while @board.valid_pos?(new_move)
            new_move = [x + dx, y + dy]
            unless @board[new_move].is_a?(NullPiece)
                if @board[new_move].color == self.color
                    break
                else grown_moves << new_move
                    break
                end
            end
            grown_moves << new_move
            x += dx
            y += dy
        end
        grown_moves
    end
end

module Stepable
    def moves
        x, y = @pos
        moves = []
        move_diffs.each do |dx, dy|
            new_pos = [x + dx, y + dy]
            moves << new_pos unless @board[new_pos].color == self.color
        end
        moves
    end
end


class Rook < Piece
    include Slideable
    def symbol
        @color == :black ? "♜" : "♖"
    end

    def move_dirs
        { horizontal_dirs: true, diagonal_dirs: false }
    end
end

class Bishop < Piece
    include Slideable
    def symbol
        @color == :black ? "♝" : "♗"
    end

    def move_dirs
        { horizontal_dirs: false, diagonal_dirs: true }
    end
end

class Queen < Piece
    include Slideable
    def symbol
        @color == :black ? "♛" : "♕"
    end

    def move_dirs
        { horizontal_dirs: true, diagonal_dirs: true }
    end
end

class King < Piece
    include Stepable
    def symbol
        @color == :black ? "♚" : "♔"
    end

    def move_diffs
        [[1,0],[-1,0],[0,1],[0,-1],[1,1],[-1,1],[-1,-1],[1,-1]]
    end
end

class Knight < Piece
    include Stepable
    def symbol
        @color == :black ? "♞" : "♘"
    end

    def move_diffs
        [[2,1],[1,2],[2,-1],[1,-2],[-2,-1],[-1,-2],[-2,1],[-1,2]]
    end
end

class NullPiece < Piece
    include Singleton

    def initialize
    end

    def moves
    end

    def color
        nil
    end

    def symbol
        "-"
    end
end

class Pawn < Piece
    def symbol
        @color == :black ? "♟" : "♙"
    end

    def moves
        x, y = @pos
        moves = [[x + forward_dir, y]]
        if at_start_row?
            moves << [x + forward_dir * 2, y]
        end
        moves
    end

    def forward_dir
        if @color == :black
            return 1
        else
            return -1
        end
    end

    def side_attacks
        x, y = @pos
        attacks = []
        potential_moves = [[x + forward_dir, y+1], [x + forward_dir, y-1]]
        potential_moves.each do |move|
            if @board.valid_pos?(move) && @board[pos].color != self.color
                attacks << move
            end
        end
        attacks
    end


    def at_start_row?
        if @color == :black && @pos[0] == 1 || @color == :white && pos[0] == 6
            return true
        end
        false
    end
end

class Board

    def initialize
        @rows = Array.new(8) { Array.new(8, NullPiece.instance) }
    end

    def populate
        row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
        (0..7).each do |yc|
            @rows[0][yc] = row[yc].new(:black, self, [0, yc])
            @rows[1][yc] = Pawn.new(:black, self, [1,yc])
            @rows[7][yc] = row[yc].new(:white, self, [0, yc])
            @rows[6][yc] = Pawn.new(:white, self, [6, yc])
        end
    end

    def move_piece(color, start_pos, end_pos)
        if color = self[start_pos].color && self[start_pos].moves.include?(end_pos)
            self[start_pos].pos = end_pos
            self[end_pos] = self[start_pos]
            self[start_pos] = NullPiece.instance
        else
            raise "can't move there"
        end
    end

    def [](pos)
        x, y = pos
        @rows[x][y]
    end

    def []=(pos, val)
        x, y = pos
        @rows[x][y] = val
    end

    def valid_pos?(pos)
        if pos.any? { |val| 0 >= val || val >= 7 }
            return false
        end
        true
    end

    def display
        (0..7).each do |row|
            (0..7).each do |col|
                print @rows[row][col].symbol + " "
            end
        end
    end

end




