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