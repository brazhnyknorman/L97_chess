# frozen_string_literal: false

def print_grid(board, grid = board.grid, margin_y = board.vertical_margin, margin_x = board.horizontal_margin)
  i = 0
  until i > 7
    print "#{margin_y[i]} "
    grid[i].each { |element| print "#{element} " }
    print "\n"

    i += 1
  end

  print '  '
  margin_x.each { |element| print "#{element} " }
  print "\n"
end
