require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if board.won? 
      return board.winner != evaluator
    elsif board.tied?
      return false
    else
      if next_mover_mark == evaluator
        children.all? do |child|
          child.losing_node?(evaluator)
        end
      else 
        children.any? do |child|
          child.losing_node?(evaluator)
        end
      end
    end
  end

  def winning_node?(evaluator)
    if board.won? 
      return board.winner == evaluator
    elsif board.tied?
      return false
    else
      if next_mover_mark != evaluator
        children.all? do |child|
          child.winning_node?(evaluator)
        end
      else 
        children.any? do |child|
          child.winning_node?(evaluator)
        end
      end
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    next_moves = []
    (0..2).each do |num1|
      (0..2).each do |num2|
        pos = [num1, num2]
        if board.empty?(pos)
          n_board = board.dup
          n_board[pos] = next_mover_mark
          if next_mover_mark == :x
            next_moves << TicTacToeNode.new(n_board, :o, [num1, num2])
          else
            next_moves << TicTacToeNode.new(n_board, :x, [num1, num2])
          end
        end
      end
    end
    return next_moves 
  end
  
end
