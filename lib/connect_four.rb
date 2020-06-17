# frozen_string_literal: true

require_relative 'game'

puts 'Welcome to Connect Four'
puts "\n"
loop do
  game = Game.new
  turn = game.player1
  loop do
    puts "\n"
    puts game.board_grid
    puts '---------------'
    puts ' 1 2 3 4 5 6 7 '
    selected_col = 0
    loop do
      puts "\nIt's #{turn.name}'s turn"
      puts "\nSelect a column [1-7] to drop the disc: "
      selected_col = gets.chomp.to_i
      break if (1..7).include?(selected_col)
    end
    game.play(turn, selected_col - 1)
    result = game.game_over_results
    turn = turn == game.player1 ? game.player2 : game.player1
    next unless result[0]

    puts "\nGame Over"
    if result[1].nil?
      puts "\nThe game is draw"
    else
      puts "\nThe winner is #{result[1]}"
    end
    break
  end
  another = 'n'
  loop do
    puts "\n\nDo you want to play another game? [y/n]"
    another = gets.chomp
    break if %w[y n].include?(another)
  end
  break unless another == 'y'
end
