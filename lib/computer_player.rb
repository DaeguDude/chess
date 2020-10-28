# A computer controlled player. Not very smart. Picks legal moves randomly.
class ComputerPlayer
  attr_reader :colour, :move_tree

  def initialize(colour:, board:, move_tree:)
    @colour = colour
    @board = board
    @move_tree = move_tree
  end

  def input_move
    move_tree.convert_to_moves(colour).sample
  end
end