require_relative '../lib/tic_tac_toe.rb'

puts 'Welcome to TicTacToe'
bob = TicTacToe::Player.new(color: 'X', name: 'bob')
frank = TicTacToe::Player.new(color: 'O', name: 'frank')
players = [bob, frank]
TicTactoe::Game.new(players).play
