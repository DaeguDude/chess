require_relative "lib/board"
require_relative "lib/piece"
require_relative "lib/game"

pp Board.new.grid

puts Piece.new(colour: 'White', type: 'Rook')
