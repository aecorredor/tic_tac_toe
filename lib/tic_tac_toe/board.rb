module TicTacToe
  class Board
    attr_reader :grid
    def initialize(input = {})
      @grid = input.fetch(:grid, default_grid)
    end

    def get_cell(x, y)
      grid[y][x]
    end

    def set_cell(x, y, value)
      get_cell(x, y).value = value
    end

    def game_over
      return :winner if winner?
      return :draw if draw?
      false
    end

    def draw?
      # same as .map{ |cell| cell.value }.none_empty?
      # grid.flatten.map(&:value).none_empty?
      grid.flatten.map { |cell| cell.value }.none_empty?
    end

    def winner?
      winning_positions.each do |winning_position|
        next if winning_position_values(winning_position).all_empty?
        return true if winning_position_values(winning_position).all_same?
      end
      false
    end

    def winning_position_values(winning_position)
      # same as { |cell| cell.value }
      # winning_position.map(&:value)
      winning_position.map { |cell| cell.value }
    end

    private

    def default_grid
      # creates a 3 by 3 grid, using an array with 3 nested arrays inside of it
      Array.new(3) { Array.new(3) { Cell.new } }
    end

    # there are 8 winning positions, 3 columns, 3 rows, and 2 diagonals
    # we define the following methods to determine the winner
    def winning_positions
      grid + # these are the rows
        grid.transpose + # these are the columns
        diagonals # this methods returns the two diagonals
    end

    def diagonals
      [
        [get_cell(0, 0), get_cell(1, 1), get_cell(2, 2)],
        [get_cell(0, 2), get_cell(1, 1), get_cell(2, 0)]
      ]
    end
  end
end
