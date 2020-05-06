  
require_relative 'basic_methods'
require_relative 'level'

class Player
  
  attr_accessor :x, :y
  
  def initialize
    @y = 1
    @x = 1
  end
  
  def position_check(current_level)
    if current_level[@y][@x] == "X"
      puts "you are dead"
      exit
    elsif current_level[@y][@x] == "D"
      puts "found the stairs, going down to the next level"
      $lvl_num += 1
    end
  end
end

 
$player = Player.new
$lvl_num = 1


level_1 = Level.new(["----------",
                    "-    X   -",
                    "-  X     -",
                    "-    --  -",
                    "-  X     -",
                    "-----D----"])

$current_level = level_1

$current_level.print_to_screen($player)


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
  $player.position_check($current_level.level)
  $current_level.print_to_screen($player)
  if $lvl_num == 2
    puts "win"
    exit
  end
end

loop do
  player_move
  player_status
end