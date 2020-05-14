require_relative 'interface'

class Game
  def initialize(interface)
    @interface = interface
  end

  def start_game
    @interface.create_player
    @interface.set_lvl_num
    @interface.level_load
  end

  def main_loop
    loop do
      status
      @interface.player_move
      @interface.monster_move if time_check
    end
  end

  def status
    position_check
    @interface.print_to_screen
  end

  def position_check
    @interface.same_space_as_a_monster
    @interface.tile_interaction
  end
end

def time_check
  @start ||= Time.now
  if Time.now - @start > 0.5
    @start = Time.now
    return true
  end
  false
end

def into_tile(str)
  case str
  when "-"
    return Wall.new
  when "S"
    return StairsUp.new
  when "D"
    return StairsDown.new
  when "t"
    return Treasure.new
  when "k"
    return Key.new
  when "|"
    return Door.new
  when " "
    return Empty.new
  else
    return Empty.new
  end
end


game = Game.new(Interface.new)

game.start_game
game.main_loop
