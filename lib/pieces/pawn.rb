class Pawn < Piece
  attr_reader :first_move

  def post_initialize
    @first_move = true
  end

  def move_list(board, starting)
    move_map(board, starting) + attack_map(board, starting)
  end

  def update(_ = nil)
    toggle_first_move
  end

  def undo_update
    @first_move = true
  end

  def to_s
    colour == :white ? white_pawn : black_pawn
  end

  # Zero and seven represent the top and and bottom of a standard chess board.
  def promotable?(pos)
    case colour
    when :white
      pos.first.zero?
    when :black
      pos.first == 7
    end
  end

  private

  def toggle_first_move
    @first_move = false
  end

  def single_move
    colour == :white ? [[-1, 0]] : [[1, 0]].freeze
  end

  def double_move
    colour == :white ? [[-2, 0]] : [[2, 0]].freeze
  end

  def attacks
    case colour
    when :white
      [[-1, -1], [-1, 1]].freeze
    when :black
      [[1, -1], [1, 1]].freeze
    end
  end

  def move_map(board, starting)
    single = single_map(board, starting)
    return single if single.empty? || !first_move

    single + double_map(board, starting)
  end

  def attack_map(board, move)
    list = attacks.map { |atk| [move.first + atk.first, move.last + atk.last] }
    list.select { |atk| valid_move?(board, atk) && enemy?(board, atk) }
  end

  def single_map(board, starting)
    single = single_move.map { |move| [starting.first + move.first, starting.last + move.last] }
    single.select { |move| valid_move?(board, move) && empty?(board, move) }
  end

  def double_map(board, starting)
    double = double_move.map { |move| [starting.first + move.first, starting.last + move.last] }
    double.select { |move| valid_move?(board, move) && empty?(board, move) }
  end

  # OPTIMISE: More succint way to express this idea
  def en_passant(board, starting)
    colour == :white ? passant_white(board, starting) : passant_black(board, starting)
  end

  def passant_white
    res = []
    [1, -1].each do |move|
      piece = board[starting.first][starting.last + move]
      next unless piece.colour == enemy_colour?
      next unless piece.passable?

      res << [starting.first - 1, starting.last + move]
    end
    res
  end

  def passant_black
    res = []
    [1, -1].each do |move|
      piece = board[starting.first][starting.last + move]
      next unless piece.colour == enemy_colour?
      next unless piece.passable?

      res << [starting.first + 1, starting.last + move]
    end
    res
  end
end
