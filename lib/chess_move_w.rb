# frozen_string_literal: false

def move_pawn_w(starting, ending); end

def coord_to_index(coord)
  alphabet = 'abcdefgh'
  index1 = alphabet.index(coord[0].downcase)
  index0 = (coord[1].to_i - 8).abs
  [index0, index1]
end
