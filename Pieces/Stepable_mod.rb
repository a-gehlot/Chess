module Stepable
    def moves
        x, y = @pos
        moves = []
        move_diffs.each do |dx, dy|
            new_pos = [x + dx, y + dy]
            unless @board[new_pos].color == self.color || !@board.valid_pos?(new_pos)
                moves << new_pos
            end 
        end
        moves
    end
end