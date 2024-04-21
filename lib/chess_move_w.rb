# frozen_string_literal: false

require_relative '../lib/chess_move_b'

def king_move_w(starting, ending, grid, check_if_opponent_is_checked)
  original_board = grid.map(&:dup)
  temp_board = hypothetical_board_w(starting, ending, original_board, '♚')

  currently_under_check = under_check_w?(original_board, starting, false)
  will_be_under_check = under_check_w?(temp_board, ending, false)

  return true if valid_king_move_w(starting, original_board).include?(ending) && will_be_under_check == false

  false
end

def valid_king_move_w(pointer, grid, valid_moves = [])
  king_axes_w(pointer, grid, 0, -1).each { |element| valid_moves << element }  # Up
  king_axes_w(pointer, grid, 0, 1).each { |element| valid_moves << element }   # Down
  king_axes_w(pointer, grid, 1, 0).each { |element| valid_moves << element }   # Right
  king_axes_w(pointer, grid, -1, 0).each { |element| valid_moves << element }  # Left
  king_axes_w(pointer, grid, 1, 1).each { |element| valid_moves << element }   # Down - Right
  king_axes_w(pointer, grid, -1, 1).each { |element| valid_moves << element }  # Down - Left
  king_axes_w(pointer, grid, -1, -1).each { |element| valid_moves << element } # Up - Left
  king_axes_w(pointer, grid, 1, -1).each { |element| valid_moves << element }  # Up - Right

  valid_moves
end

def print_temp_w(grid)
  more_temp_grid = grid
  i = 0
  until i > 7
    more_temp_grid[i].each { |element| print "#{element} " }
    print "\n"

    i += 1
  end
end

def king_axes_w(pointer, grid, x, y)
  in_bound = (pointer[0] + y).between?(0, 7) && (pointer[1] + x).between?(0, 7)
  valid_moves = []

  valid_moves << [pointer[0] + y, pointer[1] + x] if in_bound && available_w?(grid[pointer[0] + y][pointer[1] + x])
  valid_moves
end

def under_check_w?(grid, king_location_w, _check_if_opponent_is_checked)
  grid.each_with_index do |row, y|
    row.each_with_index do |square, x|
      index = [y, x]
      case square
      when '.'
      when '♙'
        return true if move_pawn_b(index, king_location_w, grid)
      when '♘'
        return true if move_knight_b(index, king_location_w, grid)
      when '♗'
        return true if move_bishop_b(index, king_location_w, grid)
      when '♖'
        return true if move_rook_b(index, king_location_w, grid)
      when '♕'
        return true if move_queen_b(index, king_location_w, grid)
      when '♔'
        return true if valid_king_move_b(index, grid).include?(king_location_w)
      end
    end
  end
  false
end

def hypothetical_board_w(starting, ending, grid, piece)
  temp_grid = grid.map(&:dup)
  temp_grid[starting[0]][starting[1]] = '.'
  temp_grid[ending[0]][ending[1]] = piece
  temp_grid
end

def move_queen_w(starting, ending, grid)
  return true if valid_queen_move_w(starting, grid).include?(ending)

  false
end

def valid_queen_move_w(pointer, grid, valid_moves = [])
  axes_move_w(pointer, grid, 0, 1).each { |element| valid_moves << element }   # Up
  axes_move_w(pointer, grid, 0, -1).each { |element| valid_moves << element }  # Down
  axes_move_w(pointer, grid, -1, 0).each { |element| valid_moves << element }  # Left
  axes_move_w(pointer, grid, 1, 0).each { |element| valid_moves << element }   # Right
  axes_move_w(pointer, grid, 1, 1).each { |element| valid_moves << element }   # Down - Right
  axes_move_w(pointer, grid, 1, -1).each { |element| valid_moves << element }  # Up - Right
  axes_move_w(pointer, grid, -1, 1).each { |element| valid_moves << element }  # Down - Left
  axes_move_w(pointer, grid, -1, -1).each { |element| valid_moves << element } # Up - Left

  valid_moves
end

def move_rook_w(starting, ending, grid)
  return true if valid_rook_move_w(starting, grid).include?(ending)

  false
end

def valid_rook_move_w(pointer, grid, valid_moves = [])
  axes_move_w(pointer, grid, 0, 1).each { |element| valid_moves << element }   # Up
  axes_move_w(pointer, grid, 0, -1).each { |element| valid_moves << element }  # Down
  axes_move_w(pointer, grid, -1, 0).each { |element| valid_moves << element }  # Left
  axes_move_w(pointer, grid, 1, 0).each { |element| valid_moves << element }   # Right

  valid_moves
end

def move_bishop_w(starting, ending, grid)
  return true if valid_bishop_move_w(starting, grid).include?(ending)

  false
end

def valid_bishop_move_w(pointer, grid, valid_moves = [])
  axes_move_w(pointer, grid, 1, 1).each { |element| valid_moves << element }   # Down - Right
  axes_move_w(pointer, grid, 1, -1).each { |element| valid_moves << element }  # Up - Right
  axes_move_w(pointer, grid, -1, 1).each { |element| valid_moves << element }  # Down - Left
  axes_move_w(pointer, grid, -1, -1).each { |element| valid_moves << element } # Up - Left

  valid_moves
end

def axes_move_w(pointer, grid, x, y)
  valid_moves = []

  y_no_valid_moves = (pointer[0] <= 0 && y == -1) || (pointer[0] >= 7 && y == 1)
  x_no_valid_moves = (pointer[1] <= 0 && x == -1) || (pointer[1] >= 7 && x == 1)

  # Will not evaluate pointer if doing so will yield an out of bounds position
  pointer = [pointer[0] + y, pointer[1] + x] unless y_no_valid_moves || x_no_valid_moves

  # Will add valid moves until a black piece is capturable, bound is met or white piece is met
  until (pointer[0].between?(0, 7) == false) || (pointer[1].between?(0, 7) == false)
    valid_moves << pointer unless available_w?(grid[pointer[0]][pointer[1]]) == false

    break if capturable_b?(grid[pointer[0]][pointer[1]]) || available_w?(grid[pointer[0]][pointer[1]]) == false

    pointer = [pointer[0] + y, pointer[1] + x]
  end
  valid_moves
end

def move_knight_w(starting, ending, grid)
  return true if valid_knight_move_w(starting, grid).include?(ending)

  false
end

def valid_knight_move_w(starting, grid, valid_moves = [])
  if starting[0] >= 1 && starting[1] >= 2 && available_w?(grid[starting[0] - 1][starting[1] - 2]) # Left - Up
    valid_moves << [starting[0] - 1, starting[1] - 2]
  end
  if starting[0] >= 2 && starting[1] >= 1 && available_w?(grid[starting[0] - 2][starting[1] - 1]) # Up - Left
    valid_moves << [starting[0] - 2, starting[1] - 1]
  end
  if starting[0] >= 2 && starting[1] <= 6 && available_w?(grid[starting[0] - 2][starting[1] + 1]) # Up - Right
    valid_moves << [starting[0] - 2, starting[1] + 1]
  end
  if starting[0] >= 1 && starting[1] <= 5 && available_w?(grid[starting[0] - 1][starting[1] + 2]) # Right - Up
    valid_moves << [starting[0] - 1, starting[1] + 2]
  end
  if starting[0] <= 6 && starting[1] <= 5 && available_w?(grid[starting[0] + 1][starting[1] + 2]) # Right - Down
    valid_moves << [starting[0] + 1, starting[1] + 2]
  end
  if starting[0] <= 5 && starting[1] <= 6 && available_w?(grid[starting[0] + 2][starting[1] + 1]) # Down - Right
    valid_moves << [starting[0] + 2, starting[1] + 1]
  end
  if starting[0] <= 5 && starting[1] >= 1 && available_w?(grid[starting[0] + 2][starting[1] - 1]) # Down - Left
    valid_moves << [starting[0] + 2, starting[1] - 1]
  end
  if starting[0] <= 6 && starting[1] >= 2 && available_w?(grid[starting[0] + 1][starting[1] - 2]) # Left - Down
    valid_moves << [starting[0] + 1, starting[1] - 2]
  end

  valid_moves
end

def move_pawn_w(starting, ending, grid)
  return true if valid_pawn_move_w(starting, grid).include?(ending)

  false
end

def valid_pawn_move_w(starting, grid, valid_moves = [])
  # Unless the pawn is at the end of the board, blocked by a piece or input is invalid, add a forward move
  border = starting[0] >= 7
  not_blocked = border == false && grid[starting[0] + 1][starting[1]] == '.'
  unless (starting[0] + 1) > 7 || !not_blocked || starting.include?(nil)
    valid_moves << [starting[0] + 1,
                    starting[1]] # Add if empty square is available
  end

  if starting[0] == 1 && (grid[starting[0] + 2][starting[1]] == '.' && starting.include?(nil) == false) && not_blocked
    valid_moves << [starting[0] + 2,
                    starting[1]] # Add move 2 spaces forward if empty square is available and it is the first move
  end

  # Unless the pawn is at the end of the board, check if it can capture any pieces
  unless (starting[0] + 1) > 7
    if starting[1] > 0 && capturable_b?(grid[starting[0] + 1][starting[1] - 1])
      valid_moves << [starting[0] + 1,
                      starting[1] - 1]
    end
    if starting[1] < 7 && capturable_b?(grid[starting[0] + 1][starting[1] + 1])
      valid_moves << [starting[0] + 1,
                      starting[1] + 1]
    end
  end
  valid_moves
end

def coord_to_index(coord)
  alphabet = 'abcdefgh'
  index1 = alphabet.index(coord[0].downcase)
  index0 = (coord[1].to_i - 8).abs
  [index0, index1]
end

def index_to_coord(index)
  alphabet = 'abcdefgh'
  coord0 = alphabet[index[1]]
  coord1 = (index[0] - 8).abs.to_s
  [coord0, coord1].join.upcase
end

def capturable_b?(square)
  return true if '♙♘♗♖♕♔'.include?(square)

  false
end

def available_w?(square)
  return false if '♟︎♞♝♜♛♚'.include?(square)

  true
end
