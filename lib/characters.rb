
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

def player_move
  move = user_move
  check_and_move($player, move)
end

def check_and_move(character, move)
  case move
  when "w"
    character.y -= 1 if $current_level.move_possible(character.x, (character.y - 1))   
  when "a"
    character.x -= 1 if $current_level.move_possible((character.x - 1), character.y )
  when "s"
    character.y += 1 if $current_level.move_possible(character.x, (character.y + 1))
  when "d"
    character.x += 1 if $current_level.move_possible((character.x + 1), character.y)
  end
end

def player_status
  if $current_level.position_check
    $lvl_num += 1
    level_load
  end
  if $lvl_num == 2
    puts "win"
    exit
  end
  $current_level.print_to_screen
end