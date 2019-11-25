Dir["./Pieces/*.rb"].each {|file| require file }

class Board

    attr_reader :rows

    def initialize
        @rows = Array.new(8) { Array.new(8, NullPiece.instance) }
    end

    def populate
        row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
        (0..7).each do |yc|
            @rows[0][yc] = row[yc].new(:black, self, [0, yc])
            @rows[1][yc] = Pawn.new(:black, self, [1,yc])
            @rows[7][yc] = row[yc].new(:white, self, [7, yc])
            @rows[6][yc] = Pawn.new(:white, self, [6, yc])
        end
    end

    def move_piece!(color, start_pos, end_pos)
        if color == self[start_pos].color && self[start_pos].moves.include?(end_pos)
            self[start_pos].pos = end_pos
            self[end_pos] = self[start_pos]
            self[start_pos] = NullPiece.instance
        else
            raise "can't move there"
        end
    end

    def move_piece(color, start_pos, end_pos)
        if color == self[start_pos].color && self[start_pos].valid_moves.include?(end_pos)
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
        if pos.any? { |val| 0 > val || val > 7 }
            return false
        end
        true
    end

    def in_check?(color)
        king_pos = find_king(color)
        @rows.flatten.any? { |piece| piece.color != color && piece.moves.include?(king_pos) }
    end

    def checkmate?(color)
        self.in_check?(color) && @rows.flatten.none? { |piece| !piece.valid_moves.empty? && piece.color == color }
    end

    def find_king(color)
        piece = @rows.flatten.find { |x| x.is_a?(King) && x.color == color }
        return piece.pos
    end

    def dup
        Marshal.load(Marshal.dump(self))
    end


end




