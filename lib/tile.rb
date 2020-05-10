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
    puts "you are winner"
    exit
  end
end
