require 'minitest/autorun'
require 'pry'
require 'pry-debugger'

class Minitest::Test
  def self.test(name, &blk)
    define_method("test_#{name.gsub(/\s+/, '_')}", blk)
  end

  def slow_test(program_name, test_name)
    unless ENV['FULL_SUITE']
      puts "Processing via #{program_name} is slow, set FULL_SUITE to include #{test_name} in the test run"
      skip ''
    end
  end
end

module Giffy
  module Fixtures
    def fixture_path(name)
      File.expand_path(File.join(File.dirname(__FILE__), "fixtures/#{name}"))
    end

    def test_video
      fixture_path('test_video.mov')
    end
  end
end
