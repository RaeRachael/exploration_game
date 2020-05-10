class Level

  attr_accessor :level

  def initialize
    @level = []
    @save = []
  end

  def print_to_screen
    @level[$player.y][$player.x] = "o"
    if $monsters
      $monsters.each_with_index { |monster,i| @save[i] = @level[monster.y][monster.x]
       @level[monster.y][monster.x] = "X" }
    end
    print_level
    @level[$player.y][$player.x] = " "
    if $monsters
      $monsters.each_with_index do |monster,i|
        if @save[i] == "X"
          @level[monster.y][monster.x] = " "
        else
          @level[monster.y][monster.x] = @save[i]
        end
      end
    end
  end

  def position_check
    if $monsters
      $monsters.each do |monster|
        if $player.y == monster.y && $player.x == monster.x
          puts "you are dead"
          print_death_location
          exit
        end
      end
    end
    if @level[$player.y][$player.x] == "S"
      puts "found the stairs, going up to the next level"
      return true
    end
    if @level[$player.y][$player.x] == "t"
      puts "found the treasure, you winner!!"
      exit
    end
  end

  def print_death_location
    @level[$player.y][$player.x] = "X"
    print_level
  end

  def print_level
    @level.each { |slice| puts slice.center(16) }
    puts
  end
end

def level_load
  levels = ["-----------",
            "- -       -",
            "- - ----- -",
            "- - -     -",
            "- - -  ----",
            "-   -    S-",
            "-----------"],
           ["-----------",
            "-         -",
            "-         -",
            "-         -",
            "-       X -",
            "-        S-",
            "-----------"],
           ["-----------",
            "-         -",
            "-    -    -",
            "-    -    -",
            "- X  -   X-",
            "-    -   S-",
            "-----------"],
           ["-----------",
            "-         -",
            "-         -",
            "-         -",
            "-       XX-",
            "-       XS-",
            "-----------"],
           ["-----------",
            "-         -",
            "-  ----   -",
            "-  -      -",
            "-       XX-",
            "-       Xt-",
            "-----------"]

  $current_level.level = levels[$lvl_num]
  $player.x, $player.y = 1, 1
  level = levels[$lvl_num]
  $tile_map = level.map do |line, y|
    line.split("").map do |char, x|
      char = into_tile(char)
    end
  end
  add_monsters_in(level)
end

def into_tile(str)
  case str
  when "-"
    return Wall.new
  when "S"
    return Stairs.new
  when "t"
    return Treasure.new
  when " "
    return Empty.new
  else
    return Empty.new
  end
end

def add_monsters_in(level)
  $monsters = []
  level.each_with_index do |line, y|
    line.split("").each_with_index do |char, x|
      if char == "X"
        basic = Monster.new(x,y)
        $monsters << basic
      end
    end
  end
end
