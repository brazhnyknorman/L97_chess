# frozen_string_literal: false

require_relative '../lib/chess_print'
require_relative '../lib/chess_class'
require_relative '../lib/chess_move_w'

def check_for_save_load(user_input, game)
  if user_input == 'load'
    game.load_game
    # puts ''
  elsif user_input == 'save'
    game.save_game
  end
  game
end

def welcome_message
  puts 'Chess.'
  puts "Enter your coordinates using start and end points. \nExample: e2 e4, g1 h3, etc."
  puts "\nSave or Load your games by entering load or save."
  puts 'Use CTRL + C if an abort is neccessary.'
  puts "\nHave fun."
end

game = Game.new
welcome_message

5000.times do
  print_grid(game.board) if game.turn == 'white'
  user_input = game.take_turn_w if game.turn == 'white'
  game = check_for_save_load(user_input, game)

  print_grid(game.board) if game.turn == 'black'
  user_input = game.take_turn_b if game.turn == 'black'
  game = check_for_save_load(user_input, game)
end
