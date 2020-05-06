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
    end
  end
end

require_relative 'basic_methods'
  
player = Player.new


level_1 = Level.new(["----------",
                    "-    X   -",
                    "-  X     -",
                    "-    --  -",
                    "-  X     -",
                    "----- ----"])
level_1.print_to_screen(player)
max_vert = level_1.level.length - 1
max_hor = level_1.level[0].length - 1

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
  if player.y == max_vert
    puts "win"
    exit
  end
end