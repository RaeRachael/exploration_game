require_relative '../../lib/game'

describe '#print_level' do
  it 'should print 5x5 area' do
    test = Interface.new
    test.setup
    expect { test.print_to_screen() }.
      to output(/.{15}\n.{15}\n.{15}\n.{15}\n.{15}\n/).to_stdout
  end
end
