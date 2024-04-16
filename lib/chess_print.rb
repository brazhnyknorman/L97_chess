# frozen_string_literal: false

def print_grid(board, margin_y = board.vertical_margin, margin_x = board.horizontal_margin)
  grid = board.grid

  i = 0
  until i > 8
    print "#{margin_y[i]} "
    grid[i].each { |element| print "#{element} " }
    print "\n"

    i += 1
  end
end
