# frozen_string_literal: false

# require_relative '../lib/chess_class.rb'

def king_move_w(_starting, _ending, _grid)
  x = 1
end

def under_check?(starting, ending, grid); end

def giving_check?; end

def hypothetical_board(starting, ending, grid)
  grid[starting[0]][starting[1]] = '.'
  grid[ending[0]][ending[1]] = piece
  grid
end

#####################
def move_queen_b(starting, ending, grid)
  return true if valid_queen_move_b(starting, grid).include?(ending)

  false
end

def valid_queen_move_b(pointer, grid, valid_moves = [])
  axes_move_b(pointer, grid, 0, 1).each { |element| valid_moves << element }   # Up
  axes_move_b(pointer, grid, 0, -1).each { |element| valid_moves << element }  # Down
  axes_move_b(pointer, grid, -1, 0).each { |element| valid_moves << element }  # Left
  axes_move_b(pointer, grid, 1, 0).each { |element| valid_moves << element }   # Right
  axes_move_b(pointer, grid, 1, 1).each { |element| valid_moves << element }   # Down - Right
  axes_move_b(pointer, grid, 1, -1).each { |element| valid_moves << element }  # Up - Right
  axes_move_b(pointer, grid, -1, 1).each { |element| valid_moves << element }  # Down - Left
  axes_move_b(pointer, grid, -1, -1).each { |element| valid_moves << element } # Up - Left

  p valid_moves
end

def move_rook_b(starting, ending, grid)
  return true if valid_rook_move_b(starting, grid).include?(ending)

  false
end

#####################
def valid_rook_move_b(pointer, grid, valid_moves = [])
  axes_move_b(pointer, grid, 0, 1).each { |element| valid_moves << element }   # Up
  axes_move_b(pointer, grid, 0, -1).each { |element| valid_moves << element }  # Down
  axes_move_b(pointer, grid, -1, 0).each { |element| valid_moves << element }  # Left
  axes_move_b(pointer, grid, 1, 0).each { |element| valid_moves << element }   # Right

  valid_moves
end

def move_bishop_b(starting, ending, grid)
  return true if valid_bishop_move_b(starting, grid).include?(ending)

  false
end

def valid_bishop_move_b(pointer, grid, valid_moves = [])
  axes_move_b(pointer, grid, 1, 1).each { |element| valid_moves << element }   # Down - Right
  axes_move_b(pointer, grid, 1, -1).each { |element| valid_moves << element }  # Up - Right
  axes_move_b(pointer, grid, -1, 1).each { |element| valid_moves << element }  # Down - Left
  axes_move_b(pointer, grid, -1, -1).each { |element| valid_moves << element } # Up - Left

  valid_moves
end

#####################
def axes_move_b(pointer, grid, x, y)
  valid_moves = []

  y_no_valid_moves = (pointer[0] <= 0 && y == -1) || (pointer[0] >= 7 && y == 1)
  x_no_valid_moves = (pointer[1] <= 0 && x == -1) || (pointer[1] >= 7 && x == 1)

  # Will not evaluate pointer if doing so will yield an out of bounds position
  pointer = [pointer[0] + y, pointer[1] + x] unless y_no_valid_moves || x_no_valid_moves

  # Will add valid moves until a black piece is capturable, bound is met or white piece is met
  until (pointer[0].between?(0, 7) == false) || (pointer[1].between?(0, 7) == false)
    valid_moves << pointer unless available_b?(grid[pointer[0]][pointer[1]]) == false

    break if capturable_w?(grid[pointer[0]][pointer[1]]) || available_b?(grid[pointer[0]][pointer[1]]) == false

    pointer = [pointer[0] + y, pointer[1] + x]
  end
  valid_moves
end

#####################
def move_knight_b(starting, ending, grid)
  return true if valid_knight_move_b(starting, grid).include?(ending)

  false
end

def valid_knight_move_b(starting, grid, valid_moves = [])
  if starting[0] >= 1 && starting[1] >= 2 && available_b?(grid[starting[0] - 1][starting[1] - 2]) # Left - Up
    valid_moves << [starting[0] - 1, starting[1] - 2]
  end
  if starting[0] >= 2 && starting[1] >= 1 && available_b?(grid[starting[0] - 2][starting[1] - 1]) # Up - Left
    valid_moves << [starting[0] - 2, starting[1] - 1]
  end
  if starting[0] >= 2 && starting[1] <= 6 && available_b?(grid[starting[0] - 2][starting[1] + 1]) # Up - Right
    valid_moves << [starting[0] - 2, starting[1] + 1]
  end
  if starting[0] >= 1 && starting[1] <= 5 && available_b?(grid[starting[0] - 1][starting[1] + 2]) # Right - Up
    valid_moves << [starting[0] - 1, starting[1] + 2]
  end
  if starting[0] <= 6 && starting[1] <= 5 && available_b?(grid[starting[0] + 1][starting[1] + 2]) # Right - Down
    valid_moves << [starting[0] + 1, starting[1] + 2]
  end
  if starting[0] <= 5 && starting[1] <= 6 && available_b?(grid[starting[0] + 2][starting[1] + 1]) # Down - Right
    valid_moves << [starting[0] + 2, starting[1] + 1]
  end
  if starting[0] <= 5 && starting[1] >= 1 && available_b?(grid[starting[0] + 2][starting[1] - 1]) # Down - Left
    valid_moves << [starting[0] + 2, starting[1] - 1]
  end
  if starting[0] <= 6 && starting[1] >= 2 && available_b?(grid[starting[0] + 1][starting[1] - 2]) # Left - Down
    valid_moves << [starting[0] + 1, starting[1] - 2]
  end

  valid_moves
end

#####################
def move_pawn_b(starting, ending, grid)
  return true if valid_pawn_move_b(starting, grid).include?(ending)

  false
end

def valid_pawn_move_b(starting, grid, valid_moves = [])
  # Unless the pawn is at the end of the board, blocked by a piece or input is invalid, add a forward move
  unless (starting[0] - 1) < 0 || grid[starting[0] - 1][starting[1]] != '.' || starting.include?(nil)
    valid_moves << [starting[0] - 1,
                    starting[1]] # Add if empty square is available
  end

  if starting[0] == 6 && (grid[starting[0] - 2][starting[1]] == '.' && starting.include?(nil) == false)
    valid_moves << [starting[0] - 2,
                    starting[1]] # Add move 2 spaces forward if empty square is available and it is the first move
  end

  # Unless the pawn is at the end of the board, check if it can capture any pieces
  unless (starting[0] + 1) > 7
    if starting[1] > 0 && capturable_b?(grid[starting[0] - 1][starting[1] - 1])
      valid_moves << [starting[0] - 1,
                      starting[1] - 1]
    end
    if starting[1] < 7 && capturable_b?(grid[starting[0] - 1][starting[1] + 1])
      valid_moves << [starting[0] - 1,
                      starting[1] + 1]
    end
  end
  valid_moves
end

def capturable_b?(square)
  return true if '♟︎♞♝♜♛♚'.include?(square)

  false
end

def available_b?(square)
  return false if '♙♘♗♖♕♔'.include?(square)

  true
end
