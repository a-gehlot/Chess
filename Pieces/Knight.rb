require_relative "Stepable_mod.rb"

class Knight < Piece
    include Stepable
    def symbol
        @color == :black ? "♞" : "♘"
    end

    def move_diffs
        [[2,1],[1,2],[2,-1],[1,-2],[-2,-1],[-1,-2],[-2,1],[-1,2]]
    end
end