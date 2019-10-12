Dir["./Pieces/*.rb"].each {|file| require file }

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




