require_relative 'interface'

def time_check
  @start ||= Time.now
  if Time.now - @start > 0.5
    @start = Time.now
    return true
  end
  false
end

to_run = Interface.new
to_run.start_game
to_run.main_loop
