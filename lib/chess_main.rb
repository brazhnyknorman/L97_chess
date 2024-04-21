# frozen_string_literal: false

require_relative '../lib/chess_print'
require_relative '../lib/chess_class'
require_relative '../lib/chess_move_w'

game = Game.new

2.times do
  game.load_game

  print_grid(game.board)
  game.take_turn_w
  # puts "F5: #{coord_to_index('F5')}"
  print_grid(game.board)

  game.take_turn_b
  print_grid(game.board)

  game.save_game
  game.load_game
end
