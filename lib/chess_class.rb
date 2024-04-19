# frozen_string_literal: false

require_relative '../lib/chess_move_w'

# Class that creates and operates a game of chess
class Game
  attr_accessor :board, :turn

  def initialize
    @board = Board.new
    @turn = 'white'
  end

  def take_turn_w
    white_input = take_input
    starting = coord_to_index(white_input[0])
    ending = coord_to_index(white_input[1])

    # puts "#{starting} and #{ending}"
    # board.grid[starting[0]][starting[1]]
    case board.grid[starting[0]][starting[1]]
    when '.'
      puts 'Can\'t move the ground.'
      exit
    when '♟︎'
      if move_pawn_w(starting, ending, board.grid)
        move_piece(starting, ending, '♟︎')
      else
        puts 'Your piece cannot move to that spot.'
      end
    when '♞'
      if move_knight_w(starting, ending, board.grid)
        move_piece(starting, ending, '♞')
      else
        puts 'Your piece cannot move to that spot.'
      end
    when '♝'
      if move_bishop_w(starting, ending, board.grid)
        move_piece(starting, ending, '♝')
      else
        puts 'Your piece cannot move to that spot'
      end
    when '♜'
    when '♛'
    when '♚'
    else
      puts 'That is not your piece.'
      exit
    end
  end

  def take_turn_b; end

  def switch_turn; end

  def take_input
    print "\n#{@turn.capitalize}'s turn: "
    user_input = gets.chomp.upcase
    if valid_input?(user_input) == false
      puts 'Invalid input.'
      exit
    end

    user_input.split
  end

  def valid_input?(input)
    return true if input.length == 5

    false
  end

  def move_piece(starting, ending, piece)
    board.grid[starting[0]][starting[1]] = '.'
    board.grid[ending[0]][ending[1]] = piece
  end
end

# Instance of a chess board, which contains indices of chess pieces
class Board
  attr_accessor :vertical_margin, :horizontal_margin, :grid, :pawn_w, :knight_w, :bishop_w, :rook_w, :queen_w, :king_w,
                :pawn_b, :knight_b, :bishop_b, :rook_b, :queen_b, :king_b

  def initialize
    @vertical_margin = (1..8).to_a.reverse
    @horizontal_margin = ('a'..'h').to_a
    @grid = create_board

    create_pieces_b
    create_pieces_w
  end

  def create_board
    [
      ['♜', '♞', '♝', '♛', '♚', '♝', '♞', '♜'],
      ['♟︎', '♟︎', '♟︎', '♟︎', '♟︎', '♟︎', '♟︎', '♟︎'],
      ['.', '.', '.', '.', '.', '.', '.', '.'],
      ['.', '.', '.', '.', '.', '.', '.', '.'],
      ['.', '.', '.', '.', '.', '.', '.', '.'],
      ['.', '.', '.', '.', '.', '.', '.', '.'],
      ['♙', '♙', '♙', '♙', '♙', '♙', '♙', '♙'],
      ['♖', '♘', '♗', '♕', '♔', '♗', '♘', '♖']
    ]

    #  [
    #  ['.', '.', '.', '.', '.', '.', '♞', '.'],
    #  ['.', '.', '.', '.', '.', '.', '.', '.'],
    #  ['.', '.', '.', '.', '.', '.', '.', '.'],
    #  ['.', '♟︎', '.', '♟︎', '.', '.', '.', '.'],
    #  ['♟', '.', '.', '.', '♟︎', '.', '.', '.'],
    #  ['.', '.', '♞', '.', '.', '.', '.', '.'],
    #  ['.', '.', '.', '.', '♟︎', '.', '♙', '♙'],
    #  ['.', '♞', '.', '♕', '♔', '♗', '♘', '♖']
    #  ]
  end

  def create_pieces_b
    @pawn_b = '♙'
    @knight_b = '♘'
    @bishop_b = '♗'
    @rook_b = '♖'
    @queen_b = '♕'
    @king_b = '♔'
  end

  def create_pieces_w
    @pawn_w = '♟︎'
    @knight_w = '♞'
    @bishop_w = '♝'
    @rook_w = '♜'
    @queen_w = '♛'
    @king_w = '♚'
  end
end
