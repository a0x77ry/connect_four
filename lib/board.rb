# frozen_string_literal: true

# A board class for connect four
class Board
  EMPTY_MARK = '.'
  DIV_MARK = '|'
  ROWS = 6
  COLUMNS = 7

  attr_reader :grid, :rows, :columns

  def initialize(grid = make_default_grid(ROWS, COLUMNS),
                 rows = ROWS,
                 columns = COLUMNS)
    @grid = grid
    @rows = rows
    @columns = columns
  end

  def grid_full?(grid)
    full = true
    grid.each { |row| full = false if row.include?('.') }
    full
  end

  private

  def make_default_row(col_num)
    default_row = []
    col_num.times { default_row << DIV_MARK << EMPTY_MARK }
    default_row << DIV_MARK
    default_row.join
  end

  def make_default_grid(rows, columns)
    default_grid = []
    rows.times { default_grid << make_default_row(columns) }
    default_grid
  end
end
