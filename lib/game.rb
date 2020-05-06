class Level
  
  attr_accessor :level
  
  def initialize(level)
    @level = level  
  end
  
  def print_to_screen(frog)
    @level[frog.vert][frog.hor] = "f" 
    @level.each { |slice| puts slice.center(16) }
    puts " " * (@level[0].length - 1)
    @level[frog.vert][frog.hor] = "_"
  end
  
end

class Frog
  
  attr_accessor :hor, :vert
  
  def initialize
    @vert = 0
    @hor = 0
  end
  
  def alive_check(current_level)
    if current_level[@vert][@hor] == " "
      puts "you are dead"
      exit
    end
  end
end

require_relative 'basic_methods'
  
frog = Frog.new


level_1 = Level.new(["________","___ ___ "," ___ ___","__  __  "," __  __ ","________"])
level_1.print_to_screen(frog)
max_vert = level_1.level.length - 1
max_hor = level_1.level[0].length - 1

loop do
  move = user_move
  #puts move
  case move
  when "w"
    frog.vert -= 1
    frog.vert = 0 if frog.vert < 0
  when "a"
    frog.hor -= 1
    frog.hor = 0 if frog.hor < 0
  when "s"
    frog.vert += 1
  when "d"
    frog.hor += 1
    frog.hor = max_hor if frog.hor > max_hor
  end
  frog.alive_check(level_1.level)
  level_1.print_to_screen(frog)
  if frog.vert == max_vert
    puts "win"
    exit
  end
end
