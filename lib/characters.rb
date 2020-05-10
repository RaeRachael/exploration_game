
class Moveable

  attr_accessor :x, :y

  def initialize(x,y)
    @y = y
    @x = x
  end

end

class Player < Moveable

  def initialize (x, y)
    super(x,y)
  end

  require 'io/console'
  require 'timeout'

  def user_move
    start = Time.now
    while Time.now - start < 0.5
      move = read_move
      return move if move
    end
  end

  def read_move
    chr = Timeout::timeout(0.05) { $stdin.getch }
    return chr if chr.match(/[wasd]/)
  rescue Timeout::Error
  end

  def move
    check_and_move_player($player, user_move)
  end

  def check_and_move_player(character, move)
    case move
    when "w"
      character.y -= 1 unless $tile_map[character.y - 1][character.x].blockable()
    when "a"
      character.x -= 1 unless $tile_map[character.y][character.x - 1].blockable()
    when "s"
      character.y += 1 unless $tile_map[character.y + 1][character.x].blockable()
    when "d"
      character.x += 1 unless $tile_map[character.y][character.x + 1].blockable()
    end
  end

 def move_player(x,y)
   return $current_level.level[y][x] != "-"
 end

 def status
   if $current_level.position_check
     $lvl_num += 1
     level_load
   end
   $current_level.print_to_screen
 end
end

class Monster < Moveable

  def initialize (x, y)
    super(x,y)
  end

  def move
    return if $monsters == nil
    possible_moves = ["w","a","s","d",nil,nil]
    $monsters.each do |monster|
      check_and_move_monster(monster,possible_moves.sample)
    end
  end

  def check_and_move_monster(character, move)
    case move
    when "w"
      character.y -= 1 if move_monster(character.x, (character.y - 1))
    when "a"
      character.x -= 1 if move_monster((character.x - 1), character.y )
    when "s"
      character.y += 1 if move_monster(character.x, (character.y + 1))
    when "d"
      character.x += 1 if move_monster((character.x + 1), character.y)
    end
  end

  def move_monster(x,y)
    $monsters.each { |monster| return false if x == monster.x && y == monster.y }
    return $current_level.level[y][x] != "-"
  end
end
