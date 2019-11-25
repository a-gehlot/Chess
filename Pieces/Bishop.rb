require_relative "Slideable_mod.rb"

class Bishop < Piece
    include Slideable
    def symbol
        @color == :black ? "♝" : "♗"
    end

    def move_dirs
        { horizontal_dirs: false, diagonal_dirs: true }
    end
end