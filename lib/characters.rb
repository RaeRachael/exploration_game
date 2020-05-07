
class Character
  
  attr_accessor :x, :y
  
  def initialize(x,y)
    @y = 1
    @x = 1
  end
  
end

require 'io/console'
require 'timeout'

def user_move
  start = Time.now
  while Time.now - start < 0.5
    move = read_move
    return move if move
  end
end

def read_move 
  chr = Timeout::timeout(0.05) { $stdin.getch }    
  return chr if chr.match(/[wasd]/)
rescue Timeout::Error
end

