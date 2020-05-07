  
require_relative 'characters'
require_relative 'level'
 
$player = Character.new(1,1)
$lvl_num = 0

def player_move
  move = user_move
  case move
  when "w"
    $player.y -= 1 if $current_level.move_possible($player.x, ($player.y - 1))   
  when "a"
    $player.x -= 1 if $current_level.move_possible(($player.x - 1), $player.y )
  when "s"
    $player.y += 1 if $current_level.move_possible($player.x, ($player.y + 1))
  when "d"
    $player.x += 1 if $current_level.move_possible(($player.x + 1), $player.y)
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

$current_level = Level.new
level_load

loop do
  player_status
  player_move  
end