class Tile
  attr_reader :blockabe

  def initialize
  end
end

class Stairs < Tile
  def initialize
    @blockabe = false
  end

  def player_interaction
    $lvl_num += 1
    level_load
  end
end

class Wall < Tile
  def initialize
    @blockabe = true
  end

  def player_interaction
    raise StandardError, "nothing should be in the wall"
  end
end

class Treasure < Tile
  def initialize
    @blockabe
  end

  def player_interaction
    puts "you are winner"
    exit
  end
end
