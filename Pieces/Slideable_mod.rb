
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
            if @board[new_move].is_a?(NullPiece)
                grown_moves << new_move.dup
            elsif @board[new_move].color == self.color
                return grown_moves
            else
                grown_moves << new_move
                return grown_moves
            end
            new_move[0] += dx
            new_move[1] += dy
        end
        grown_moves
    end
end