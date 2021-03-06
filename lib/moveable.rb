require_relative 'interface'

class Moveable

  attr_accessor :x, :y

  def initialize(x, y, interface)
    @y = y
    @x = x
    @interface = interface
  end

  def tile_blocked_for?(y, x, moveable)
    @interface.blocked?(y, x, moveable)
  end

end

class Player < Moveable

  attr_accessor :key
  attr_reader :sight

  def initialize(x, y, interface)
    super(x, y, interface)
    @key = 0
    @sight = 2
  end

  require 'io/console'
  require 'timeout'

  def user_move
    start = Time.now
    while Time.now - start < 0.49
      move = read_move
      return move if move
    end
  end

  def read_move
    chr = Timeout::timeout(0.05) do
      $stdin.getch
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

  def initialize(x, y, interface)
    super(x, y, interface)
    @possible_moves = ["w", "a", "s", "d", nil, nil]
  end

  def possible_moves
    @possible_moves.sample
  end

  def move
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
