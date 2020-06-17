# frozen_string_literal: true

# A player class for connect four
class Player
  attr_reader :name, :mark

  def initialize(name, mark)
    @name = name
    @mark = mark
  end
end
