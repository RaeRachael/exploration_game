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

class StairsUp < Tile
  def initialize
    @blocks_monster = false
    @string = " S "
    @move_on = false
  end

  def blocks_player
    @move_on = true
    return false
  end

  def player_interaction
    if @move_on
      lvl_up
      print_to_screen("found stairs leading up")
      sleep(1)
      level_load
    end
  end
end

class StairsDown < Tile
  def initialize
    @blocks_monster = false
    @string = " D "
    @move_on = false
  end

  def blocks_player
    @move_on = true
    return false
  end

  def player_interaction
    if @move_on
      lvl_down
      print_to_screen("found stairs leading down")
      sleep(1)
      level_load
    end
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
    print_to_screen("you are winner")
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
    get_key
    $tile[$player.y][$player.x] = Empty.new
    puts $levels[$lvl_num][$player.y][$player.x]
    $levels[$lvl_num][$player.y][$player.x] = " "
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
      if player_keys > 0
        @locked = false
        use_key
      end
    end
    @locked
  end
end
