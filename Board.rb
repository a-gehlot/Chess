class Board
    def initialize
        @rows = Array.new(8) { Array.new(8, nil) }
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

end

class Piece
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
            unless @board[new_move].nil?
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
            moves << [x + dx, y + dy]
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
        @color == black ? "♛" : "♕"
    end

    def move_dirs
        { horizontal_dirs: true, diagonal_dirs: true }
    end
end

class King < Piece
    def symbol
        @color == black ? "♚" : "♔"
    end

    def move_diffs
        [[1,0],[-1,0],[0,1],[0,-1],[1,1],[-1,1],[-1,-1],[1,-1]]
    end
end

class Knight < Piece
    def symbol
        @color == black ? "♞" : "♘"
    end

    def move_diffs
        [[2,1],[1,2],[2,-1],[1,-2],[-2,-1],[-1,-2],[-2,1],[-1,2]]
    end
end



