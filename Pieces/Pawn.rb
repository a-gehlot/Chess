class Pawn < Piece   
    def symbol
        @color == :black ? "♟" : "♙"
    end

    def moves
        x, y = @pos
        moves = []
        forward_move = [x + forward_dir, y]
        moves << forward_move unless !@board[forward_move].is_a?(NullPiece)
        if at_start_row?
            start_move = [x + forward_dir * 2, y]
            moves << start_move unless !@board[start_move].is_a?(NullPiece)
        end
        return moves + self.side_attacks
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
            if @board.valid_pos?(move) && @board[move].color != nil && @board[move].color != self.color
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