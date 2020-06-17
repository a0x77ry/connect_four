require './lib/game.rb'
require './lib/board.rb'
require './lib/player.rb'

describe Game do
  before do
    grid =
      %w[|.|.|.|.|.|.|.|
         |.|.|.|.|.|.|.|
         |.|.|o|.|.|.|.|
         |.|.|x|.|o|.|.|
         |.|.|x|.|o|.|.|
         |o|.|x|.|x|.|.|]
    @example_board = Board.new(grid)

    @example_player = Player.new('Player 1', 'x')

    @game = Game.new(@example_board)
  end

  context '#board' do
    it 'returns the board' do
      expect(@game.board_grid).to eql(
        %w[|.|.|.|.|.|.|.|
           |.|.|.|.|.|.|.|
           |.|.|o|.|.|.|.|
           |.|.|x|.|o|.|.|
           |.|.|x|.|o|.|.|
           |o|.|x|.|x|.|.|]
      )
    end
  end

  context '#play' do
    it 'drops one disc on an empty column and returns the updated board' do
      expect(@game.play(@example_player, 1)).to eql(
        %w[|.|.|.|.|.|.|.|
           |.|.|.|.|.|.|.|
           |.|.|o|.|.|.|.|
           |.|.|x|.|o|.|.|
           |.|.|x|.|o|.|.|
           |o|x|x|.|x|.|.|]
      )
    end

    it 'drops one disc on a non-empty column' do
      expect(@game.play(@example_player, 2)).to eql(
        %w[|.|.|.|.|.|.|.|
           |.|.|x|.|.|.|.|
           |.|.|o|.|.|.|.|
           |.|.|x|.|o|.|.|
           |.|.|x|.|o|.|.|
           |o|.|x|.|x|.|.|]
      )
    end
  end

  context '#game_over_results' do
    it "returns [false, nil] if game isn't over yet" do
      expect(@game.game_over_results(@example_board.grid))
        .to eql([false, nil])
    end

    it 'returns [true, nil] if the game has ended with a draw' do
      grd = %w[|o|x|o|x|o|o|x|
               |o|x|x|o|x|o|x|
               |x|o|o|x|o|o|x|
               |o|x|x|o|o|x|o|
               |x|o|x|o|o|x|o|
               |o|o|x|o|x|x|x|]
      expect(@game.game_over_results(grd)).to eql([true, nil])
    end

    it "returns [true, 'Player 1'] if Player 1 has won with a horizontal row" do
      grd =
        %w[|.|.|.|.|.|.|.|
           |.|.|.|.|.|.|.|
           |.|.|.|.|.|.|.|
           |.|.|.|.|.|.|.|
           |.|.|.|.|.|.|.|
           |.|.|x|x|x|x|.|]
      expect(@game.game_over_results(grd)).to eql([true, 'Player 1'])
    end

    it "returns [true, 'Player 2'] if Player 2 has won with a vertical row" do
      grd =
        %w[|.|.|.|.|.|.|.|
           |.|.|.|.|.|.|.|
           |.|.|o|.|.|.|.|
           |.|.|o|.|.|.|.|
           |.|.|o|.|.|.|.|
           |.|.|o|.|.|.|.|]
      expect(@game.game_over_results(grd)).to eql([true, 'Player 2'])
    end

    it "returns [true, 'Player 2'] if Player 2 has won with a sideways row" do
      grd =
        %w[|.|.|.|.|.|.|.|
           |.|.|.|.|.|.|.|
           |.|.|.|.|.|o|o|
           |.|.|.|.|x|o|x|
           |.|.|.|x|o|x|x|
           |.|.|x|o|o|o|x|]
      expect(@game.game_over_results(grd)).to eql([true, 'Player 2'])
    end

    it "returns [true, 'Player 1'] if Player 1 has won with a sideways row" do
      grd =
        %w[|.|.|.|x|.|.|.|
           |.|.|.|o|x|.|.|
           |.|.|.|o|o|x|.|
           |.|.|.|o|x|x|x|
           |.|.|.|x|o|o|o|
           |.|.|.|x|o|o|o|]
      expect(@game.game_over_results(grd)).to eql([true, 'Player 1'])
    end
  end
end
