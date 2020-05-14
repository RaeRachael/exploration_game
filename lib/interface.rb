
require_relative 'moveable'
require_relative 'level'
require_relative 'tile'

class Interface
  def blocked?(y, x, who)
    case who
    when "player"
      @@tile[y][x].blocks_player
    when "monster"
      @@tile[y][x].blocks_monster
    end
  end

  def monster_blocks(y,x)
    @@monsters.each do |monster|
      return true if x == monster.x && y == monster.y
    end
    return false
  end

  def lvl_down
    @@lvl_num -= 1
  end

  def lvl_up
    @@lvl_num += 1
  end

  def player_keys
    @@player.key
  end

  def get_key
    @@player.key += 1
  end

  def use_key
    @@player.key -= 1
  end

  def remove_key_from_level
    @@tile[@@player.y][@@player.x] = Empty.new
    @@levels[@@lvl_num][@@player.y][@@player.x] = " "
  end

  def print_to_screen(string = "")
    @@to_print = @@tile.map {|line| line.map {|tile| tile.string }}
    @@to_print[@@player.y][@@player.x] = " o "
    if @@monsters
      @@monsters.each { |monster| @@to_print[monster.y][monster.x] = " X " }
    end
    print_level(string)
  end

  def same_space_as_a_monster
    if @@monsters
      @@monsters.each do |monster|
        if @@player.y == monster.y && @@player.x == monster.x
          print_to_screen("you are dead")
          exit
        end
      end
    end
  end

  def tile_interaction
    @@tile[@@player.y][@@player.x].player_interaction
  end

  def print_level(string)
    @@to_print.each { |slice| puts slice.join("").center(16) }
    puts string
  end

  def level_load
    @@levels ||= level_data
    @@tile = @@levels[@@lvl_num].map do |line, y|
      line.split("").map do |char, x|
        char = into_tile(char)
      end
    end
    add_monsters_in(@@levels[@@lvl_num])
  end

  def add_monsters_in(level)
    @@monsters = []
    level.each_with_index do |line, y|
      line.split("").each_with_index do |char, x|
        if char == "X"
          basic = Monster.new(x,y)
          @@monsters << basic
        end
      end
    end
  end

  def start_game
    create_player
    set_lvl_num
    level_load
  end

  def create_player
    @@player = Player.new(1,1)
  end

  def set_lvl_num
    @@lvl_num = 0
  end

  def main_loop
    loop do
      status
      @@player.move
      if @@monsters && time_check
        @@monsters.each { |monster| monster.move }
      end
    end
  end
end
