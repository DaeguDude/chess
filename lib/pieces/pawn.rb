class Pawn < Piece
  attr_reader :first_move

  def initialize(colour: :white)
    @colour = colour
  end

  def post_initialize
    @first_move = true
  end

  def moves
    if first_move
      colour == :white ? [[-1, 0], [-2, 0]] : [[1, 0], [2, 0]]
      self.first_move = false
    else
      colour == :white ? [[-1, 0]] : [[1, 0]]
    end
  end

  def to_s
    colour == :white ? white_pawn : black_pawn
  end
end
