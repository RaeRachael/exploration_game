
def level_data
  [["----------",
   "- -      -",
   "- - ---- -",
   "- - -    -",
   "- - - ----",
   "-   -   S-",
   "----------"],
  ["----------",
   "-  X     -",
   "-        -",
   "-        -",
   "- ---    -",
   "-  S-   D-",
   "----------"],
  ["-----------",
   "-k- |     -",
   "- - ----- -",
   "- - -     -",
   "-   - -----",
   "-  D-    S-",
   "-----------"],
  ["-----------",
   "-SX  -k  X-",
   "-    -    -",
   "-    -    -",
   "-    -    -",
   "-    |   D-",
   "-----------"],
  ["-----------",
   "-D        -",
   "-         -",
   "-         -",
   "-       XX-",
   "-       XS-",
   "-----------"],
  ["-----------",
   "-       X -",
   "-        t-",
   "- -     X -",
   "- ---------",
   "-        D-",
   "-----------"]]
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
  when "\\"
    return DoorUnLocked.new
  else
    return Empty.new
  end
end
