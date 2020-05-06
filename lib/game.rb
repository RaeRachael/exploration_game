  
require_relative 'basic_methods'
require_relative 'level'

class Player
  
  attr_accessor :x, :y
  
  def initialize
    @y = 1
    @x = 1
  end
  
end

 
$player = Player.new
$lvl_num = 0

def levels
levels = [Level.new(["----------",
                    "-    X   -",
                    "-  X     -",
                    "-    --  -",
                    "-  X     -",
                    "-----D----"]),
          Level.new(["----------",
                      "-   X    -",
                      "-  -  XX -",
                      "- X  -   -",
                      "-   -  D -",
                      "----------"])]

$current_level = levels[$lvl_num]
$player.x, $player.y = 1, 1
end


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
  levels if $current_level.position_check      
  if $lvl_num == 2
    puts "win"
    exit
  end
  $current_level.print_to_screen
end


levels
loop do
  player_status
  player_move  
end