# frozen_string_literal: false

# require_relative '../lib/chess_class.rb'

def move_pawn_w(starting, ending, grid)
  return true if valid_pawn_move_w(starting, grid).include?(ending)

  false
end

def valid_pawn_move_w(starting, grid)
  valid_moves = []

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
