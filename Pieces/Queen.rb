require_relative "Slideable_mod.rb"

class Queen < Piece
    include Slideable
    def symbol
        @color == :black ? "♛" : "♕"
    end

    def move_dirs
        { horizontal_dirs: true, diagonal_dirs: true }
    end
end