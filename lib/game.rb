
require_relative 'characters'
require_relative 'level'
require_relative 'tile'


def time_check
  $start ||= Time.now
  if Time.now - $start > 0.5
    $start = Time.now
    return true
  end
  false
end

$player = Player.new(1,1)
$lvl_num = 0
$current_level = Level.new
level_load

loop do
  $player.status
  $player.move
  if $monsters && time_check
    $monsters.each { |monster| monster.move }
  end
end
