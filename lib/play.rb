
require_relative 'game.rb'

game = Game.new(Interface.new)
game.setup
game.main_loop
