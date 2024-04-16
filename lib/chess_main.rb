# frozen_string_literal: false

require_relative '../lib/chess_print'
require_relative '../lib/chess_class'

puts "hi!"
game = Game.new
print_grid(game.board)
