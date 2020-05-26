require 'sinatra'
require_relative 'game.rb'

=begin
class PlaySinatra < Sinatra::Base
  get '/' do
    game = Game.new(Interface.new)
    game.setup
    game.main_loop
  end
end
=end

#=begin
game = Game.new(Interface.new)
game.setup
game.main_loop
#=end
