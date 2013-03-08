require 'rspec'
require 'rviz'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end

def capture_stdout(&block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end

