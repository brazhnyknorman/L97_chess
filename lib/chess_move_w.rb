# frozen_string_literal: false

# require_relative '../lib/chess_class.rb'

def move_bishop_w(starting, ending, grid)
  return true if valid_bishop_move_w(starting, grid).include?(ending)

  false
end

def valid_bishop_move_w(starting, grid, valid_moves = [], pointer = starting)
  y_up_bound = pointer[0] >= 0
  x_right_bound = pointer[1] <= 7
  y_down_bound = pointer[0] <= 7
  x_left_bound = pointer[1] >= 0

  bishop_diagnol_w(starting, grid, y_up_bound, y_down_bound, x_right_bound, x_left_bound, 1, -1).each do |element|
    valid_moves << element
  end
  bishop_diagnol_w(starting, grid, y_up_bound, y_down_bound, x_right_bound, x_left_bound, 1, 1).each do |element|
    valid_moves << element
  end
  bishop_diagnol_w(starting, grid, y_up_bound, y_down_bound, x_right_bound, x_left_bound, -1, 1).each do |element|
    valid_moves << element
  end
  bishop_diagnol_w(starting, grid, y_up_bound, y_down_bound, x_right_bound, x_left_bound, -1, -1).each do |element|
    valid_moves << element
  end

  valid_moves
end

def bishop_diagnol_w(pointer, grid, up_bound, down_bound, right_bound, left_bound, x, y) # Evaluates Up - Right Diagnol
  valid_moves = []
  y_no_valid_moves = (pointer[0] <= 0 && y == -1) || (pointer[0] >= 7 && y == 1)
  x_no_valid_moves = (pointer[1] <= 0 && x == -1) || (pointer[1] >= 7 && x == 1)

  pointer = [pointer[0] + y, pointer[1] + x] unless y_no_valid_moves || x_no_valid_moves

  until (!up_bound && y == -1) || (!right_bound && x == 1) || (!down_bound && y == 1) || (!left_bound && x == -1)
    valid_moves << pointer unless available_w?(grid[pointer[0]][pointer[1]]) == false

    break if capturable_b?(grid[pointer[0]][pointer[1]]) || available_w?(grid[pointer[0]][pointer[1]]) == false

    pointer = [pointer[0] + y, pointer[1] + x]
    up_bound = pointer[0] >= 0
    right_bound = pointer[1] <= 7
    down_bound = pointer[0] <= 7
    left_bound = pointer[1] >= 0
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
  unless (starting[0] + 1) > 7 || grid[starting[0] + 1][starting[1]] != '.' || starting.include?(nil)
    valid_moves << [starting[0] + 1,
                    starting[1]] # Add if empty square is available
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
  return false if '♟︎♞♝♜♛♚'.include?(square) || square.include?('♟︎')

  true
end
