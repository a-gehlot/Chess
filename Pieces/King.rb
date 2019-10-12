require_relative "Stepable_mod.rb"

class King < Piece
    include Stepable
    def symbol
        @color == :black ? "♚" : "♔"
    end

    def move_diffs
        [[1,0],[-1,0],[0,1],[0,-1],[1,1],[-1,1],[-1,-1],[1,-1]]
    end
end