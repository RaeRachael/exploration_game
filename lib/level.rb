class LevelChange < StandardError
  attr_reader :thing
  def initialize(msg)
    @thing = thing
    super(msg)
  end
end

def into_tile(str, interface)
  case str
  when "-" then Wall.new(interface)
  when "S" then StairsUp.new(interface)
  when "D" then StairsDown.new(interface)
  when "t" then Treasure.new(interface)
  when "k" then Key.new(interface)
  when "|" then Door.new(interface)
  when " " then Empty.new(interface)
  when "\\" then DoorUnLocked.new(interface)
  else Empty.new(interface)
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
