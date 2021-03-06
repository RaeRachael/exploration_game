require_relative 'moveable'
require_relative 'level'
require_relative 'tile'

class Interface

  def setup
    create_player
    set_lvl_num
    load_level_data
    level_load
  end

  def blocked?(y, x, who) # called - moveable; needs - tile
    case who
    when "player"
      @tile[y][x].blocks_player?
    when "monster"
      @tile[y][x].blocks_monster? || monster_blocks?(y, x)
    end
  end

  def player_keys # called - tile; needs - moveable
    @player.key
  end

  def collect_key # called - tile; needs - moveable
    @player.key += 1
  end

  def use_key # called - tile; needs - moveable
    @player.key -= 1
  end

  def remove_key_from_level # called - tile; needs - interface
    @tile[@player.y][@player.x] = Empty.new(self)
    @levels[@lvl_num][@player.y - 2][@player.x - 2] = " "
  end

  def turn_into_un_locked # called - tile; needs - interface
    @tile[@player.y][@player.x] = DoorUnLocked.new(self)
    @levels[@lvl_num][@player.y - 2][@player.x - 2] = "\\"
  end

  def print_to_screen(string = "") # called - game, interface, tile; needs -
    selection
    add_moveables_to_print
    print_level(string)
  end

  def same_space_as_a_monster # called - game; needs - interface, moveable
    @monsters&.each do |monster|
      if @player.y == monster.y && @player.x == monster.x
        print_to_screen("you are dead")
        exit(1)
      end
    end
  end

  def tile_interaction # called - game; needs - interface, moveable
    begin
      @tile[@player.y][@player.x].player_interaction
    rescue LevelChange => code
      level_change(code.message)
    end
  end

  def player_move # called - game; needs - interface, moveable
    @player.move
  end

  def monster_move # called - game; needs - interface, moveable
    @monsters&.each { |monster| monster.move }
  end

  private

  def create_player # called - game; needs - moveable
    @player = Player.new(3, 3, self)
  end

  def set_lvl_num # called - game; holds level knowledge
    @lvl_num = 0
  end

  def load_level_data
    @levels = level_data_1
  end

  def level_load # called - game & tile; needs - tile & interface
    @tile = @levels[@lvl_num].map do |line|
      line.split("").map do |char|
        into_tile(char, self)
      end
    end
    create_empty_buffer
    add_monsters_in
  end

  def level_change(code)
    if code == 'down'
      lvl_down
      print_to_screen("found stairs leading down")
    elsif code == 'up'
      lvl_up
      print_to_screen("found stairs leading up")
    end
    sleep(1)
    level_load
  end

  def create_empty_buffer
    empty_buffer_top_bottom
    empty_buffer_left_right
  end

  def empty_buffer_top_bottom
    2.times do
      @tile.unshift([Empty.new(self)] * @tile[0].length)
      @tile.push([Empty.new(self)] * @tile[0].length)
    end
  end

  def empty_buffer_left_right
    @tile.map do |line|
      2.times do
        line.unshift(Empty.new(self))
        line.push(Empty.new(self))
      end
    end
  end

  def add_monsters_in # called - interface; needs - moveable
    @monsters = []
    @levels[@lvl_num].each_with_index do |line, y|
      line.split("").each_with_index do |char, x|
        if char == "X"
          basic = Monster.new(x + 2, y + 2, self)
          @monsters << basic
        end
      end
    end
  end

  def monster_blocks?(y, x) # called - moveable; needs - interface
    @monsters.each do |monster|
      return true if x == monster.x && y == monster.y
    end
    return false
  end

  def lvl_down # called - tile; needs - interface
    @lvl_num -= 1
  end

  def lvl_up # called - tile; needs - interface
    @lvl_num += 1
  end

  def selection
    @sight = @player.sight
    @printxy = []
    @print_y = @tile[(@player.y - @sight)..(@player.y + @sight)]
    @print_y.each do |line|
      @printxy << line[(@player.x - @sight)..(@player.x + @sight)].map{ |a| a.string }
    end
  end

  def add_moveables_to_print # called - interface; needs - moveable, interface
    @printxy[@sight][@sight] = " o "
    @monsters.each do |monster|
      if (monster.y - @player.y).abs <= @sight && (monster.x - @player.x).abs <= @sight
        y = @sight + (monster.y - @player.y)
        x = @sight + (monster.x - @player.x)
        @printxy[y][x] = " X "
      end
    end
  end

  def print_level(string) # called - interface; needs - interface
    @printxy.each { |slice| puts slice.join("") }
    puts string
    puts "\n\n"
  end

end
