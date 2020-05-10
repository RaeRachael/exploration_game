class Tile
  attr_reader :blocks, :string

  def initialize
  end
end

class Empty < Tile
  def initialize
    @blocks = false
    @string = "   "
  end

  def player_interaction
  end
end

class Stairs < Tile
  def initialize
    @blocks = false
    @string = " S "
  end

  def player_interaction
    $lvl_num += 1
    level_load
  end
end

class Wall < Tile
  #attr_reader :blocks
  def initialize
    @blocks = true
    @string = "///"
  end

  def player_interaction
    raise StandardError, "nothing should be in the wall"
  end
end

class Treasure < Tile
  def initialize
    @blocks = false
    @string = " t "
  end

  def player_interaction
    print_to_screen
    puts "you are winner"
    exit
  end
end

class Key < Tile
  def initialize
    @blocks = false
    @string = " k "
  end

  def player_interaction
    $player.key += 1
    $tile[$player.y][$player.x] = Empty.new
  end
end

class Door < Tile
  def initialize
    @blocks = true
    @string = " | "
  end

  def blocks
    return false if $player.key >0
    true
  end

  def player_interaction
    $player.key -= 1
    $tile[$player.y][$player.x] = Empty.new
  end
end
