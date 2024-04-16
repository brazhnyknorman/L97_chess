# frozen_string_literal: false

# Class that creates and operates a game of chess
class Game
  attr_accessor :board

  def initialize
    @board = Board.new
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

    # p grid
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
  end

  def create_pieces_w
    puts 'Created w!'
    @pawn_w = '♙'
    @knight_w = '♘'
    @bishop_w = '♗'
    @rook_w = '♖'
    @queen_w = '♕'
    @king_w = '♔'
  end

  def create_pieces_b
    puts 'Created b!'
    @pawn_b = '♟︎'
    @knight_b = '♞'
    @bishop_b = '♝'
    @rook_b = '♜'
    @queen_b = '♛'
    @king_b = '♚'
  end
end
