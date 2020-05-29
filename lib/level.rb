
class LevelChange < StandardError
  attr_reader :thing
  def initialize(msg="My default message")
    @thing = thing
    super(msg)
  end
end

def into_tile(str, interface)
  case str
  when "-"
    return Wall.new(interface)
  when "S"
    return StairsUp.new(interface)
  when "D"
    return StairsDown.new(interface)
  when "t"
    return Treasure.new(interface)
  when "k"
    return Key.new(interface)
  when "|"
    return Door.new(interface)
  when " "
    return Empty.new(interface)
  when "\\"
    return DoorUnLocked.new(interface)
  else
    return Empty.new(interface)
  end
end

def level_data_1
  [["-----------",
   "- -       -",
   "- - ----- -",
   "- - -     -",
   "- - - -----",
   "-   -    S-",
   "-----------"],
  ["-----------",
   "-         -",
   "-   X     -",
   "-         -",
   "- --- -----",
   "-  S-    D-",
   "-----------"],
  ["-----------",
   "-   |     -",
   "- - ----- -",
   "- - -     -",
   "- - - -----",
   "-k-D-    S-",
   "-----------"],
  ["-----------",
   "-SX  -k  X-",
   "-    -    -",
   "-    -    -",
   "-    -    -",
   "-    |   D-",
   "-----------"],
  ["----------",
   "-D       -",
   "-        -",
   "-        -",
   "-        -",
   "-      X -",
   "-     X  -",
   "-       S-",
   "----------"],
  ["----------",
   "-      X -",
   "-       t-",
   "- -    X -",
   "- --------",
   "- -      -",
   "- --------",
   "-       D-",
   "----------"]]
end
