require_relative 'interface'

def time_check
  @start ||= Time.now
  if Time.now - @start > 0.5
    @start = Time.now
    return true
  end
  false
end

def start_game
  create_player
  set_lvl_num
  level_load
end

def status
  position_check
  print_to_screen
end

def position_check
  same_space_as_a_monster
  tile_interaction
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

to_run = Interface.new
to_run.start_game
to_run.main_loop
