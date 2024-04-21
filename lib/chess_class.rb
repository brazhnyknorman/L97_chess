# frozen_string_literal: false

require_relative '../lib/chess_move_w'
require_relative '../lib/chess_move_b'

# Class that creates and operates a game of chess
class Game
  attr_accessor :board, :turn, :end_turn, :raise_input_error, :white_king, :black_king

  def initialize
    @board = Board.new
    @turn = 'white'
    @end_turn = false
    @raise_input_error = false
    @white_king = WhiteKing.new([0, 3])
    @black_king = BlackKing.new([7, 3])
  end

  class WhiteKing
    attr_accessor :location, :under_check

    def initialize(starting)
      @location = starting
      @under_check = false
    end
  end

  class BlackKing
    attr_accessor :location, :under_check

    def initialize(starting)
      @location = starting
      @under_check = false
    end
  end

  def take_turn_w
    end_turn = false
    if under_check_w?(board.grid, white_king.location)
      white_king.under_check = true
      game_over if under_checkmate_w?(original_board = board.grid(&:dup), white_king.location) == true

      puts "\nYou are under check!"
    end
    until end_turn == true
      white_input = take_input
      begin
        starting = coord_to_index(white_input[0])
        ending = coord_to_index(white_input[1])
      rescue StandardError
        puts 'That was Invalid input.'
        raise_input_error = true
      end

      unless raise_input_error == true
        piece = board.grid[starting[0]][starting[1]]
        case piece
        when '.'
          puts 'Can\'t move the ground.'
        when '♟︎'
          if move_pawn_w(starting, ending, board.grid, white_king.location)
            end_turn = move_piece(starting, ending, piece)
            promote_pawn(ending, piece)
          else
            puts 'Your pawn cannot move to that spot.'
          end
        when '♞'
          if move_knight_w(starting, ending, board.grid, white_king.location)
            end_turn = move_piece(starting, ending, piece)
          else
            puts 'Your knight cannot move to that spot.'
          end
        when '♝'
          if move_bishop_w(starting, ending, board.grid, white_king.location)
            end_turn = move_piece(starting, ending, piece)
          else
            puts 'Your bishop cannot move to that spot'
          end
        when '♜'
          if move_rook_w(starting, ending, board.grid, white_king.location)
            end_turn = move_piece(starting, ending, piece)
          else
            puts 'Your rook cannot move to that spot'
          end
        when '♛'
          if move_queen_w(starting, ending, board.grid, white_king.location)
            end_turn = move_piece(starting, ending, piece)
          else
            puts 'Your queen cannot move to that spot'
          end
        when '♚'
          if king_move_w(starting, ending, board.grid)
            end_turn = move_piece(starting, ending, piece)
            white_king.location = ending
            white_king.under_check = false
          else
            puts 'Your king cannot move to that spot'
          end
        else
          puts 'That is not your piece.'
        end
        switch_turn if end_turn == true
      end
      raise_input_error = false
    end
  end

  def take_turn_b
    end_turn = false
    if under_check_b?(board.grid, black_king.location)
      black_king.under_check = true
      game_over if under_checkmate_b?(original_board = board.grid(&:dup), black_king.location) == true

      puts "\nYou are under check!"
    end
    until end_turn == true
      black_input = take_input
      begin
        starting = coord_to_index(black_input[0])
        ending = coord_to_index(black_input[1])
      rescue StandardError
        puts 'That was Invalid input.'
        raise_input_error = true
      end

      unless raise_input_error == true
        piece = board.grid[starting[0]][starting[1]]
        case piece
        when '.'
          puts 'Can\'t move the ground.'
        when '♙'
          if move_pawn_b(starting, ending, board.grid, black_king.location)
            end_turn = move_piece(starting, ending, piece)
            promote_pawn(ending, piece)
          else
            puts 'Your pawn cannot move to that spot.'
          end
        when '♘'
          if move_knight_b(starting, ending, board.grid, black_king.location)
            end_turn = move_piece(starting, ending, piece)
          else
            puts 'Your knight cannot move to that spot.'
          end
        when '♗'
          if move_bishop_b(starting, ending, board.grid, black_king.location)
            end_turn = move_piece(starting, ending, piece)
          else
            puts 'Your bishop cannot move to that spot'
          end
        when '♖'
          if move_rook_b(starting, ending, board.grid, black_king.location)
            end_turn = move_piece(starting, ending, piece)
          else
            puts 'Your rook cannot move to that spot'
          end
        when '♕'
          if move_queen_b(starting, ending, board.grid, black_king.location)
            end_turn = move_piece(starting, ending, piece)
          else
            puts 'Your queen cannot move to that spot'
          end
        when '♔'
          if king_move_b(starting, ending, board.grid)
            end_turn = move_piece(starting, ending, piece)
            black_king.location = ending
            black_king.under_check = false
          else
            puts 'Your king cannot move to that spot'
          end
        else
          puts 'That is not your piece.'
        end
        switch_turn if end_turn == true
      end
      raise_input_error = false
    end
  end

  def each_square
    board.grid.each_with_index do |row, y|
      row.each_with_index do |_square, x|
        index = [y, x]
      end
    end
  end

  def switch_turn
    @turn = if @turn == 'white'
              'black'
            else
              'white'
            end
    black_king.under_check = false
    white_king.under_check = false
  end

  def take_input
    print "\n#{@turn.capitalize}'s turn: "
    user_input = gets.chomp.upcase
    valid_input?(user_input)

    user_input.split
  end

  def valid_input?(input)
    raise_input_error = false
    return true if input.length == 5

    raise_input_error = true
    false
  end

  def move_piece(starting, ending, piece)
    board.grid[starting[0]][starting[1]] = '.'
    board.grid[ending[0]][ending[1]] = piece
    true
  end

  def promote_pawn(ending, piece)
    if piece == '♙' && ending[0] == 0
      board.grid[ending[0]][ending[1]] = '♕'
    elsif piece == '♟︎' && ending[0] == 7
      board.grid[ending[0]][ending[1]] = '♛'
    end
  end

  def game_over
    switch_turn
    puts "\n#{@turn.capitalize} wins!"
    exit
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
      ['♜', '♞', '♝', '♚', '♛', '♝', '♞', '♜'],
      ['♟︎', '♟︎', '♟︎', '♟︎', '♟︎', '♟︎', '♟︎', '♟︎'],
      ['.', '.', '.', '.', '.', '.', '.', '.'],
      ['.', '.', '.', '.', '.', '.', '.', '.'],
      ['.', '.', '.', '.', '.', '.', '.', '.'],
      ['.', '.', '.', '.', '.', '.', '.', '.'],
      ['♙', '♙', '♙', '♙', '♙', '♙', '♙', '♙'],
      ['♖', '♘', '♗', '♔', '♕', '♗', '♘', '♖']
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

    # [
    #  ['.', '.', '.', '.', '♚', '.', '.', '.'],
    #  ['.', '.', '.', '.', '♛', '.', '.', '.'],
    #  ['.', '.', '.', '.', '.', '.', '.', '.'],
    #  ['.', '.', '.', '.', '.', '.', '.', '.'],
    #  ['.', '.', '.', '.', '.', '.', '.', '.'],
    #  ['.', '.', '.', '.', '.', '.', '.', '.'],
    #  ['.', '.', '.', '.', '♕', '.', '.', '.'],
    #  ['.', '.', '.', '.', '♔', '.', '.', '.']
    # ]
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
