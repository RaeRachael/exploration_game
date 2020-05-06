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