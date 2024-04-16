# frozen_string_literal: false

require_relative '../lib/chess_print'
require_relative '../lib/chess_class'
require_relative '../lib/chess_move_w'

game = Game.new
print_grid(game.board)
p coord_to_index('A1')
p coord_to_index('A2')
p coord_to_index('A3')
p coord_to_index('A4')
p coord_to_index('A5')
p coord_to_index('A6')
p coord_to_index('A7')
p coord_to_index('A8')
