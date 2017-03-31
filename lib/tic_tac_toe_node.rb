require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    nodes_array = []

    3.times do |row|
      3.times do |col|
        pos = [row, col]
        next unless @board.empty?(pos)
        child_node = make_child(pos)
        nodes_array << child_node
      end
    end

    nodes_array
  end

  def make_child(pos)
    child_board = @board.dup
    child_board[pos] = @next_mover_mark

    TicTacToeNode.new(child_board, child_mark, pos)
  end

  def child_mark
    @next_mover_mark == :x ? :o : :x
  end
end
