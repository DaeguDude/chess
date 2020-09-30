require 'pry'

class Referee
  def initialize
    # TODO
  end

  def valid_move?(move, board, player)
    starting = move.first
    #ending = move.last
    return true unless empty_cell?(starting, board) || !own_piece?(starting, board, player)
    # Check starting move isn't empty cell
    # Check colour of piece matches colour of player
  end

  def convert_notation(notation)
    result = notation.each_char.map.with_index do |elt, idx|
      idx.even? ? convert_column(elt) : convert_row(elt)
    end
    starting = [result[1], result[0]]
    ending = [result[3], result[2]]
    [starting, ending]
  end

  def convert_column(letter)
    letter.tr('a-h', '0-7').to_i
  end

  def convert_row(digit)
    (digit.to_i - 8).abs
  end

  private

  def empty_cell?(starting, board)
    board.grid[starting.first][starting.last] == board.empty_cell
  end

  def own_piece?(starting, board, player)
    piece = board.grid[starting.first][starting.last]
    piece.colour == player.colour
  end
end
