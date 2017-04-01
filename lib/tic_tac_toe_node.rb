require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return @board.winner != evaluator if @board.over?

    children.each do |child|
      if child.next_mover_mark != evaluator
        child.children.any? { |grandchild| grandchild.losing_node?(evaluator) }
      else
        child.children.all? { |grandchild| grandchild.losing_node?(evaluator) }
      end
    end
  end

  def winning_node?(evaluator)
    return @board.winner == evaluator if @board.over?
    result = false
    children.each do |child|
      if child.next_mover_mark != evaluator
        result = child.children.all? { |grandchild| grandchild.winning_node?(evaluator) }
      else
        result = child.children.any? { |grandchild| grandchild.winning_node?(evaluator) }
      end
    end

    result

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
