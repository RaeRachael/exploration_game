class Level
  
  attr_accessor :level
  
  def initialize(level)
    @level = level  
  end
  
  def print_to_screen
    replace = @level[$player.y][$player.x]
    @level[$player.y][$player.x] = "o" 
    @level.each { |slice| puts slice.center(16) }
    puts " " * (@level[0].length - 1)
    @level[$player.y][$player.x] = replace 
  end
  
  def move_possible(x,y)
    return @level[y][x] != "-"
  end
  
  def position_check
    if @level[$player.y][$player.x] == "X"
       puts "you are dead"
      exit
    elsif @level[$player.y][$player.x] == "D"
      puts "found the stairs, going down to the next level"
      $lvl_num += 1
      $player.y, $player.x = 1,1
    end
  end
end
