class Piece
    attr_reader :color
    attr_accessor :pos
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

    def valid_moves
        valid_moves = []
        self.moves.each do |move|
            unless move.empty? || move_into_check?(move) 
                valid_moves << move
            end
        end
        valid_moves
    end

    def move_into_check?(end_pos)
        duplicate = @board.dup
        duplicate.move_piece!(@color, @pos, end_pos)
        duplicate.in_check?(@color)
    end
end