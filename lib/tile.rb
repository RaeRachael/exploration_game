class Tile
  attr_reader :blocks_player, :blocks_monster, :string
  def player_interaction
  end 
end

class Empty < Tile
  def initialize
    @blocks_player = false
    @blocks_monster = false
    @string = "   "
  end

  def player_interaction
  end
end

class Stairs < Tile
  def initialize
    @blocks_player = false
    @blocks_monster = false
    @string = " S "
  end

  def player_interaction
    $lvl_num += 1
    print_to_screen
    puts "found stairs leading up"
    sleep(1)
    level_load
  end
end

class Wall < Tile
  def initialize
    @blocks_player = true
    @blocks_monster = true
    @string = "///"
  end
end

class Treasure < Tile
  def initialize
    @blocks_player = false
    @blocks_monster = false
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
    @blocks_player = false
    @blocks_monster = false
    @string = " k "
  end

  def player_interaction
    $player.key += 1
    $tile[$player.y][$player.x] = Empty.new
  end
end

class Door < Tile
  def initialize
    @blocks_monster = true
    @string = " | "
    @locked = true
  end

  def blocks_player
    if @locked
      if $player.key >0
        @locked = false
        $player.key -= 1
      end
    end
    @locked
  end
end
