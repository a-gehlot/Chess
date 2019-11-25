require 'singleton'

class NullPiece < Piece
    include Singleton

    def initialize
    end

    def moves
        []
    end

    def color
        nil
    end

    def symbol
        "-"
    end
end