def pause(time)
  sleep(time)
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
  loop do
    chr = Timeout::timeout(0.1) { $stdin.getch }    
    return chr if chr.match(/[wasd]/)
  end
rescue Timeout::Error
end

def print_level(level) 
  puts level
end