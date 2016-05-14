require 'spec_helper'

module TicTacToe
  describe Board do
    context '#initialize' do
      it 'initializes the board with a grid' do
        expect { Board.new(grid: 'grid') }.to_not raise_error
      end

      it 'sets the grid with three rows by default' do
        board = Board.new
        expect(board.grid.size).to eq(3)
      end

      it 'sets the grid with three things in each row by default' do
        board = Board.new
        board.grid.each do |row|
          expect(row.size).to eq(3)
        end
      end
    end

    context '#grid' do
      it 'returns the grid' do
        board = Board.new(grid: 'blah')
        expect(board.grid).to eq 'blah'
      end
    end

    context '#get_cell' do
      it 'returns the cell based on the (x, y) coordinate' do
        grid = [['', '', ''], ['', '', 'something'], ['', '', '']]
        board = Board.new(grid: grid)
        expect(board.get_cell(2, 1)).to eq 'something'
      end
    end

    # We could test the set_cell method with an instance of the Cell class cuz
    # cell objects respond to value messages, but then the board_spec will
    # rely on the Cell class. Let us use a Struct to create an object that
    # responds to value messages instead of creating a Cell object and making
    # a needless dependency in our test suite.
    context '#set_cell' do
      it 'updates the value of the cell object at a (x, y) coordinate' do
        Cat = Struct.new(:value)
        grid = [[Cat.new('cool'), '', ''], ['', '', ''], ['', '', '']]
        board = Board.new(grid: grid)
        board.set_cell(0, 0, 'meow')
        expect(board.get_cell(0, 0).value).to eq 'meow'
      end
    end

    TestCell = Struct.new(:value)
    let(:x_cell) { TestCell.new('X') }
    let(:y_cell) { TestCell.new('Y') }
    let(:empty) { TestCell.new }

    # here we stubbed winner and draw with rspec cuz we hadnt written them yet
    # after writing those two methods the correct code was written
    # but the stubs were commented out and left for future reference as a
    # learning tool of what can be done in these cases
    context '#game_over' do
      it 'returns :winner if winner? is true' do
        board = Board.new
        board.stub(:winner?) { true }
        expect(board.game_over).to eq :winner
      end

      it 'returns :draw if winner? is false and draw? is true' do
        board = Board.new
        board.stub(:winner?) { false }
        board.stub(:draw?) { true }
        expect(board.game_over).to eq :draw
      end

      it 'returns false if winner? is false and draw? is false' do
        board = Board.new
        board.stub(:winner?) { false }
        board.stub(:draw?) { false }
        expect(board.game_over).to be false
      end

      it 'returns :winner when row has objects that are all the same' do
        grid = [
          [x_cell, x_cell, x_cell],
          [y_cell, x_cell, y_cell],
          [y_cell, y_cell, empty]
        ]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :winner
      end

      it 'returns :winner when column has objects with values that are all the same' do
        grid = [
          [x_cell, x_cell, empty],
          [y_cell, x_cell, y_cell],
          [y_cell, x_cell, empty]
        ]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :winner
      end

      it 'returns :winner when diagonal has objects with values that are all the same' do
        grid = [
          [x_cell, empty, empty],
          [y_cell, x_cell, y_cell],
          [y_cell, x_cell, x_cell]
        ]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :winner
      end

      it 'returns :draw when all spaces on the board are taken' do
        grid = [
          [x_cell, y_cell, x_cell],
          [y_cell, x_cell, y_cell],
          [y_cell, x_cell, y_cell]
        ]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :draw
      end

      it 'returns false when there is no winner or draw' do
        # grid = [
        #   [x_cell, empty, empty],
        #   [y_cell, empty, empty],
        #   [y_cell, empty, empty]
        # ]
        grid = [
          [x_cell, y_cell, x_cell],
          [y_cell, x_cell, y_cell],
          [y_cell, x_cell, empty]
        ]
        board = Board.new(grid: grid)
        expect(board.game_over).to be false
      end
    end
  end
end
