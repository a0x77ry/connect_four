# frozen_string_literal: true

# A game class for connect four
class Game
  require_relative 'board'
  require_relative 'player'

  attr_reader :board_grid, :player1, :player2

  def initialize(board = Board.new,
                 player1 = Player.new('Player 1', 'x'),
                 player2 = Player.new('Player 2', 'o'))
    @board = board
    @board_grid = board.grid
    @player1 = player1
    @player2 = player2
  end

  def play(player, column)
    lowest = find_lowest_in_column(column)
    board_grid[lowest - 1][col_to_grid(column)] = player.mark
    board_grid
  end

  def game_over_results(grid = @board_grid)
    horirozontal_rows = hor_rows(grid)
    vertical_rows = ver_rows(grid)
    diagonal_rows = diag_rows(grid)
    win_rows = horirozontal_rows + vertical_rows + diagonal_rows
    p1_win_str = @player1.mark * 4
    p2_win_str = @player2.mark * 4
    win_rows.each do |win_row|
      return [true, @player1.name] if win_row.include?(p1_win_str)
      return [true, @player2.name] if win_row.include?(p2_win_str)
    end
    return [true, nil] if @board.grid_full?(grid)

    [false, nil]
  end

  private

  def hor_rows(grid)
    row = Array.new(@board.rows, '')
    @board.rows.times do |row_index|
      @board.columns.times do |col_index|
        row[row_index] += grid[row_index][col_to_grid(col_index)]
      end
    end
    row
  end

  def ver_rows(grid)
    col = Array.new(@board.columns, '')
    @board.columns.times do |col_index|
      @board.rows.times do |row_index|
        col[col_index] += grid[row_index][col_to_grid(col_index)]
      end
    end
    col
  end

  def diag_line_right(grid, start_row, start_col, upwards)
    row = start_row
    col = col_to_grid(start_col)
    line = []
    until grid[row].nil? || grid[row][col].nil? || row.negative?
      line << grid[row][col]
      upwards ? row -= 1 : row += 1
      col += 2
    end
    line.join
  end

  def diag_rows(grid)
    up_start = [
      [3, 0],
      [4, 0],
      [5, 0],
      [5, 1],
      [5, 2],
      [5, 3]
    ]
    down_start = [
      [2, 0],
      [1, 0],
      [0, 0],
      [0, 1],
      [0, 2],
      [0, 3]
    ]
    rows = []
    up_start.each do |start|
      rows << diag_line_right(grid, start[0], start[1], true)
    end
    down_start.each do |start|
      rows << diag_line_right(grid, start[0], start[1], false)
    end
    rows
  end

  def col_to_grid(column_num)
    (2 * column_num) + 1
  end

  def get_column(column, board_grid)
    col_arr = []
    board_grid.each { |row| col_arr << row[col_to_grid(column)] }
    col_arr
  end

  def find_lowest_in_column(column, board_grid = @board_grid)
    col = get_column(column, board_grid)
    col.each_with_index { |item, i| return i unless item == '.' }
    6
  end
end
