require_relative 'interface'

class Moveable

  attr_accessor :x, :y

  def initialize(x, y)
    @y = y
    @x = x
    @@interface ||= Interface.new
    @@hold = false
  end

  def tile_blocked_for?(y, x, moveable)
    if moveable == "monster"
      @@interface.blocked?(y, x, moveable) || @@interface.monster_blocks(y, x)
    elsif moveable == "player"
      @@interface.blocked?(y, x, moveable)
    end
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
    while Time.now - start < 0.49
      move = read_move
      return move if move
    end
    @hold_input = $stdin
    @@hold = true
  end

  def read_move
    chr = Timeout::timeout(0.05) do
      if @@hold
        @@hold = false
        @hold_input.to_s[0]
      else
        $stdin.getch
      end
    end
    return chr if chr.match(/[wasdp]/)
  rescue Timeout::Error
  end

  def move
    case user_move
    when "w"
      @y -= 1 unless tile_blocked_for?(@y - 1, @x, "player")
    when "a"
      @x -= 1 unless tile_blocked_for?(@y, @x - 1, "player")
    when "s"
      @y += 1 unless tile_blocked_for?(@y + 1, @x, "player")
    when "d"
      @x += 1 unless tile_blocked_for?(@y, @x + 1, "player")
    when "p"
      puts "exit game"
      exit
    end
  end
end

class Monster < Moveable

  def initialize (x, y)
    super(x,y)
    @possible_moves = ["w","a","s","d",nil,nil]
  end

  def possible_moves
    @possible_moves.sample
  end

  def move
    @@hold = true
    case possible_moves
    when "w"
      @y -= 1 unless tile_blocked_for?(@y - 1, @x, "monster")
    when "a"
      @x -= 1 unless tile_blocked_for?(@y, @x - 1, "monster")
    when "s"
      @y += 1 unless tile_blocked_for?(@y + 1, @x, "monster")
    when "d"
      @x += 1 unless tile_blocked_for?(@y, @x + 1, "monster")
    end
  end

end
