
require_relative 'moveable'
require_relative 'level'
require_relative 'tile'

def blocked?(y,x,who)
  case who
  when "player"
    $tile[y][x].blocks_player
  when "monster"
    $tile[y][x].blocks_monster
  end
end

def lvl_down
  $lvl_num -= 1
end

def lvl_up
  $lvl_num += 1
end

def start_game
  $player = Player.new(1,1)
  $lvl_num = 0
  level_load
end

def main_loop
  loop do
    status
    $player.move
    if $monsters && time_check
      $monsters.each { |monster| monster.move }
    end
  end
end

start_game
main_loop
