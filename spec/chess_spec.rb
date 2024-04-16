# frozen_string_literal: true

require_relative '../lib/chess_print'
require_relative '../lib/chess_class'
require_relative '../lib/chess_move_w'

describe Game do
  describe '#coord_to_index' do
    it 'maps A5 to [3, 0]' do
      initial_coord = 'A5'
      new_coord = coord_to_index(initial_coord)
      expect(new_coord).to eq([3, 0])
    end
  end
end
