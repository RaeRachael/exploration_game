class Level
  
  attr_accessor :level
  
  def initialize
    @level = []  
  end
  
  def print_to_screen
    replace = @level[$player.y][$player.x]
    @level[$player.y][$player.x] = "o"
    if $monsters
      $monsters.each { |monster| @level[monster.y][monster.x] = "X" }
    end
    @level.each { |slice| puts slice.center(16) }
    puts 
    @level[$player.y][$player.x] = replace
    if $monsters
      $monsters.each { |monster| @level[monster.y][monster.x] = " " }
    end
  end
  
  def move_possible(x,y)
    return @level[y][x] != "-"
  end
  
  def position_check
    if $monsters
      $monsters.each do |monster|
        if $player.y == monster.y && $player.x == monster.x
          puts "you are dead"
          exit
        end
      end
    end
    if @level[$player.y][$player.x] == "D"
      puts "found the stairs, going down to the next level"
      return true
    end
  end
end

def print_level(level) 
  puts level
end

def level_load
  levels = ["----------",
            "- -    - -",
            "- - -    -",
            "- - ---- -",
            "-    -D  -",
            "----------"],
           ["----------",
            "-        -",
            "-    X   -",
            "-        -",
            "-       D-",
            "----------"]

  $current_level.level = levels[$lvl_num]
  $player.x, $player.y = 1, 1
  add_monsters_in(levels[$lvl_num])
end

def add_monsters_in(level)
  $monsters = []
  level.each_with_index do |line, y|
    line.split("").each_with_index do |char, x|
      if char == "X"
        basic = Character.new(x,y)
        $monsters << basic
      end
    end
  end
end
