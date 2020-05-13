def status
  position_check
  print_to_screen
end

def print_to_screen(string = "")
  @to_print = $tile.map {|line| line.map {|tile| tile.string }}
  @to_print[$player.y][$player.x] = " o "
  if $monsters
    $monsters.each { |monster| @to_print[monster.y][monster.x] = " X " }
  end
  print_level(string)
end

def position_check
  if $monsters
    $monsters.each do |monster|
      if $player.y == monster.y && $player.x == monster.x
        print_to_screen("you are dead")
        exit
      end
    end
  end
  $tile[$player.y][$player.x].player_interaction
end

def print_level(string)
  @to_print.each { |slice| puts slice.join("").center(16) }
  puts string
end

def level_load
  $levels ||= [["----------",
            "- -      -",
            "- - ---- -",
            "- - -    -",
            "- - - ----",
            "-   -   S-",
            "----------"],
           ["----------",
            "-  X     -",
            "-        -",
            "-        -",
            "- ---    -",
            "-  S-   D-",
            "----------"],
           ["----------",
            "-k- |    -",
            "- - ---- -",
            "- - -    -",
            "-   - ----",
            "-  D-   S-",
            "----------"],
           ["-----------",
            "-SX  -k  X-",
            "-    -    -",
            "-    -    -",
            "-    -    -",
            "-    |   D-",
            "-----------"],
           ["-----------",
            "-D        -",
            "-         -",
            "-         -",
            "-       XX-",
            "-       XS-",
            "-----------"],
           ["-----------",
            "-       X -",
            "-        t-",
            "- -     X -",
            "- ---------",
            "-        D-",
            "-----------"]]


  $tile = $levels[$lvl_num].map do |line, y|
    line.split("").map do |char, x|
      char = into_tile(char)
    end
  end
  add_moveables_in($levels[$lvl_num])
end

def into_tile(str)
  case str
  when "-"
    return Wall.new
  when "S"
    return StairsUp.new
  when "D"
    return StairsDown.new
  when "t"
    return Treasure.new
  when "k"
    return Key.new
  when "|"
    return Door.new
  when " "
    return Empty.new
  else
    return Empty.new
  end
end

def add_moveables_in(level)
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
