  
require_relative 'basic_methods'

class Level
  
  attr_accessor :level
  
  def initialize(level)
    @level = level  
  end
  
  def print_to_screen(player)
    @level[player.y][player.x] = "o" 
    @level.each { |slice| puts slice.center(16) }
    puts " " * (@level[0].length - 1)
    @level[player.y][player.x] = " "
  end

  
  def move_possible(x,y)
    return @level[y][x] != "-"
  end
  
end

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
      lvl_num += 1
    end
  end
end

  
player = Player.new
lvl_num = 1


level_1 = Level.new(["----------",
                    "-    X   -",
                    "-  X     -",
                    "-    --  -",
                    "-  X     -",
                    "-----D----"])
level_1.print_to_screen(player)

loop do
  move = user_move
  case move
  when "w"
    player.y -= 1 if level_1.move_possible(player.x, (player.y - 1))   
  when "a"
    player.x -= 1 if level_1.move_possible((player.x - 1), player.y )
  when "s"
    player.y += 1 if level_1.move_possible(player.x, (player.y + 1))
  when "d"
    player.x += 1 if level_1.move_possible((player.x + 1), player.y)
  end
  player.position_check(level_1.level)
  level_1.print_to_screen(player)
  if lvl_num == 2
    puts "win"
    exit
  end
end