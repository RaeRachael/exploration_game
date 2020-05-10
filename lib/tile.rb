class Tile
  attr_reader :blockable

  def initialize
  end
end

class Empty < Tile
  def initialize
    @blockable = false
  end

  def player_interaction
  end
end

class Stairs < Tile
  def initialize
    @blockable = false
  end

  def player_interaction
    $lvl_num += 1
    level_load
  end
end

class Wall < Tile
  attr_reader :blockable
  def initialize
    @blockable = true
  end

  def player_interaction
    raise StandardError, "nothing should be in the wall"
  end
end

class Treasure < Tile
  def initialize
    @blockable
  end

  def player_interaction
    puts "you are winner"
    exit
  end
end
