require_relative 'interface'

class Tile
  attr_reader :string

  def initialize(interface)
    @blocks_player = false
    @blocks_monster = false
    @interface = interface
  end

  def player_interaction
  end

  def blocks_player?
    @blocks_player
  end

  def blocks_monster?
    @blocks_monster
  end
end

class Empty < Tile
  def initialize(interface)
    super(interface)
    @string = "   "
  end
end

class StairsUp < Tile
  def initialize(interface)
    super(interface)
    @string = " S "
    @move_on = false
  end

  def blocks_player?
    @move_on = true
    return false
  end

  def player_interaction
    if @move_on
      raise LevelChange.new('up')
    end
  end
end

class StairsDown < Tile
  def initialize(interface)
    super(interface)
    @string = " D "
    @move_on = false
  end

  def blocks_player?
    @move_on = true
    return false
  end

  def player_interaction
    if @move_on
      raise LevelChange.new('down')
    end
  end
end

class Wall < Tile
  def initialize(interface)
    super(interface)
    @blocks_player = true
    @blocks_monster = true
    @string = "///"
  end
end

class Treasure < Tile
  def initialize(interface)
    super(interface)
    @string = " t "
  end

  def player_interaction
    @interface.print_to_screen("you are winner")
    exit(2)
  end
end

class Key < Tile
  def initialize(interface)
    super(interface)
    @string = " k "
  end

  def player_interaction
    @interface.get_key
    @interface.remove_key_from_level
  end
end

class Door < Tile
  def initialize(interface)
    super(interface)
    @blocks_monster = true
    @string = " | "
  end

  def blocks_player?
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
  def initialize(interface)
    super(interface)
    @blocks_monster = true
    @string = " | "
  end
end
