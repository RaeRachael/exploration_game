
require_relative 'moveable'
require_relative 'level'
require_relative 'tile'

class Interface

  def setup
    create_player
    set_lvl_num
    level_load
  end

  def blocked?(y, x, who) #called - moveable; needs - tile
    case who
    when "player"
      @tile[y][x].blocks_player?
    when "monster"
      @tile[y][x].blocks_monster? || monster_blocks?(y, x)
    end
  end

  def player_keys #called - tile; needs - moveable
    @player.key
  end

  def get_key #called - tile; needs - moveable
    @player.key += 1
  end

  def use_key #called - tile; needs - moveable
    @player.key -= 1
  end

  def remove_key_from_level #called - tile; needs - interface
    @tile[@player.y][@player.x] = Empty.new(self)
    @levels[@lvl_num][@player.y][@player.x] = " "
  end

  def turn_into_UnLocked #called - tile; needs - interface
    @tile[@player.y][@player.x] = DoorUnLocked.new(self)
    @levels[@lvl_num][@player.y][@player.x] = "\\"
  end

  def print_to_screen(string = "") #called - game, interface, tile; needs -
    ## selection [0..2*sight]grid
    add_moveables_to_print
    print_level(string)
  end

  def same_space_as_a_monster #called - game; needs - interface, moveable
    if @monsters
      @monsters.each do |monster|
        if @player.y == monster.y && @player.x == monster.x
          print_to_screen("you are dead")
          exit(1)
        end
      end
    end
  end

  def tile_interaction #called - game; needs - interface, moveable
    begin
      @tile[@player.y][@player.x].player_interaction
    rescue LevelChange => code
      if code.message == 'down'
        lvl_down
        print_to_screen("found stairs leading down")
      elsif code.message == 'up'
        lvl_up
        print_to_screen("found stairs leading up")
      end
      sleep(1)
      level_load
    end
  end

  def player_move #called - game; needs - interface, moveable
    @player.move
  end

  def monster_move #called - game; needs - interface, moveable
    if @monsters
      @monsters.each { |monster| monster.move }
    end
  end

  private

  def create_player #called - game; needs - moveable
    @player = Player.new(1, 1, self)
  end

  def set_lvl_num #called - game; holds level knowledge
    @lvl_num = 0
  end

  def level_load #called - game & tile; needs - tile & interface
    @levels ||= level_data
    @tile = @levels[@lvl_num].map do |line, y|
      line.split("").map do |char, x|
        char = into_tile(char, self)
      end
    end
    add_monsters_in
  end

  def add_monsters_in #called - interface; needs - moveable
    @monsters = []
    @levels[@lvl_num].each_with_index do |line, y|
      line.split("").each_with_index do |char, x|
        if char == "X"
          basic = Monster.new(x, y, self)
          @monsters << basic
        end
      end
    end
  end

  def monster_blocks?(y,x) #called - moveable; needs - interface
    @monsters.each do |monster|
      return true if x == monster.x && y == monster.y
    end
    return false
  end

  def lvl_down #called - tile; needs - interface
    @lvl_num -= 1
  end

  def lvl_up #called - tile; needs - interface
    @lvl_num += 1
  end

  def add_moveables_to_print #called - interface; needs - moveable, interface
    @to_print = @tile.map {|line| line.map {|tile| tile.string }}
    @to_print[@player.y][@player.x] = " o "
    if @monsters
      @monsters.each { |monster| @to_print[monster.y][monster.x] = " X " }
    end
  end

  def print_level(string) #called - interface; needs - interface
    @to_print.each { |slice| puts slice.join("").center(30) }
    puts string
  end

end
