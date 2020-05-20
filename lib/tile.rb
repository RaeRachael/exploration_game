require_relative 'interface'

class Tile
  attr_reader :blocks_player, :blocks_monster, :string
  def initialize
    @blocks_player = false
    @blocks_monster = false
    @interface = Interface.new
  end
  def player_interaction
  end
end

class Empty < Tile
  def initialize
    @string = "   "
  end
end

class StairsUp < Tile
  def initialize
    @string = " S "
    @move_on = false
    super
  end

  def blocks_player
    @move_on = true
    return false
  end

  def player_interaction
    if @move_on
      @interface.lvl_up
      @interface.print_to_screen("found stairs leading up")
      sleep(1)
      @interface.level_load
    end
  end
end

class StairsDown < Tile
  def initialize
    @string = " D "
    @move_on = false
    super
  end

  def blocks_player
    @move_on = true
    return false
  end

  def player_interaction
    if @move_on
      @interface.lvl_down
      @interface.print_to_screen("found stairs leading down")
      sleep(1)
      @interface.level_load
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
    @string = " t "
    super
  end

  def player_interaction
    @interface.print_to_screen("you are winner")
    exit
  end
end

class Key < Tile
  def initialize
    @string = " k "
    super
  end

  def player_interaction
    @interface.get_key
    @interface.remove_key_from_level
  end
end

class Door < Tile
  def initialize
    @blocks_monster = true
    @string = " | "
    super
  end

  def blocks_player
    if @interface.player_keys > 0
      @interface.use_key
      false
    else
      true
    end
  end

  def player_interaction
    @interface.turn_into_UnLocked
  end
end

class DoorUnLocked < Tile
  def initialize
    @blocks_monster = true
    @string = " | "
    super
  end
end
