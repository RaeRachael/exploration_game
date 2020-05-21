require_relative 'game.rb'

game = Game.new(Interface.new)
game.start_game
game.main_loop
