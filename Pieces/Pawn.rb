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