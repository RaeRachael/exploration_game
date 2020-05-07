  
require_relative 'characters'
require_relative 'level'
 
$player = Character.new(1,1)
$lvl_num = 0
$current_level = Level.new
level_load

loop do
  player_status
  player_move
  monster_move
end