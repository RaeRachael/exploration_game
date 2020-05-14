require_relative 'game'

class Moveable

  attr_accessor :x, :y

  def initialize(x, y)
    @y = y
    @x = x
    @interface = Interface.new
  end

end

class Player < Moveable

  attr_accessor :key

  def initialize (x, y)
    super(x,y)
    @key = 0
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
    return chr if chr.match(/[wasdp]/)
  rescue Timeout::Error
  end

  def move
    check_and_move_player(user_move)
  end

  def check_and_move_player(move)
    case move
    when "w"
      @y -= 1 unless @interface.blocked?(@y - 1, @x, "player")
    when "a"
      @x -= 1 unless @interface.blocked?(@y, @x - 1, "player")
    when "s"
      @y += 1 unless @interface.blocked?(@y + 1, @x, "player")
    when "d"
      @x += 1 unless @interface.blocked?(@y, @x + 1, "player")
    when "p"
      puts "exit game"
      exit
    end
  end
end

class Monster < Moveable

  def initialize (x, y)
    super(x,y)
  end

  def move
    possible_moves = ["w","a","s","d",nil,nil]
    check_and_move_monster(possible_moves.sample)
  end

  def check_and_move_monster(move)
    case move
    when "w"
      @y -= 1 unless @interface.blocked?(@y - 1, @x, "monster") || @interface.monster_blocks(@y - 1, @x)
    when "a"
      @x -= 1 unless @interface.blocked?(@y, @x - 1, "monster") || @interface.monster_blocks(@y, @x - 1)
    when "s"
      @y += 1 unless @interface.blocked?(@y + 1, @x, "monster") || @interface.monster_blocks(@y + 1, @x)
    when "d"
      @x += 1 unless @interface.blocked?(@y, @x + 1, "monster") || @interface.monster_blocks(@y, @x + 1)
    end
  end
end