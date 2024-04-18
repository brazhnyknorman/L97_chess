# frozen_string_literal: false

require_relative '../lib/chess_print'
require_relative '../lib/chess_class'
require_relative '../lib/chess_move_w'

game = Game.new
print_grid(game.board)
puts "C3: #{coord_to_index('C3')}"
puts "Valid moves: #{valid_pawn_move_w(coord_to_index('H7'), game.board.grid)}"

50.times do
  game.take_turn_w
  print_grid(game.board)
end
