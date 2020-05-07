
class Character
  
  attr_accessor :x, :y
  
  def initialize(x,y)
    @y = y 
    @x = x 
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
  check_and_move_player($player, user_move)
end

def monster_move
  return if $monsters == nil
  possible_moves = ["w","a","s","d",nil,nil]
  $monsters.each do |monster|
    check_and_move_monster(monster,possible_moves.sample)
  end
end

def check_and_move_player(character, move)
  case move
  when "w"
    character.y -= 1 if move_player(character.x, (character.y - 1))   
  when "a"
    character.x -= 1 if move_player((character.x - 1), character.y )
  when "s"
    character.y += 1 if move_player(character.x, (character.y + 1))
  when "d"
    character.x += 1 if move_player((character.x + 1), character.y)
  end
end

def check_and_move_monster(character, move)
  case move
  when "w"
    character.y -= 1 if move_monster(character.x, (character.y - 1))   
  when "a"
    character.x -= 1 if move_monster((character.x - 1), character.y )
  when "s"
    character.y += 1 if move_monster(character.x, (character.y + 1))
  when "d"
    character.x += 1 if move_monster((character.x + 1), character.y)
  end
end
 
def move_player(x,y)
  return $current_level.level[y][x] != "-"
end
  
def move_monster(x,y)
  $monsters.each { |monster| return false if x == monster.x && y == monster.y }
  return $current_level.level[y][x] != "-"
end

def player_status
  if $current_level.position_check
    $lvl_num += 1
    if $lvl_num == 3
      puts "win"
      exit
    end
    level_load
  end
  $current_level.print_to_screen
end

def time_check
  $start ||= Time.now
  if Time.now - $start > 0.5
    $start = Time.now
    return true
  end
  false
end