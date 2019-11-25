module Stepable
    def moves
        x, y = @pos
        moves = []
        self.move_diffs.each do |dx, dy|
            new_pos = [x + dx, y + dy]
            unless !@board.valid_pos?(new_pos) || @board[new_pos].color == self.color 
                moves << new_pos
            end 
        end
        moves
    end
end