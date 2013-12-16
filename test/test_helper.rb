require 'minitest/autorun'
require 'pry'
require 'pry-debugger'

class Minitest::Test
  def self.test(name, &blk)
    define_method("test_#{name.gsub(/\s+/, '_')}", blk)
  end

  def slow_test(program_name, test_name)
    unless ENV['FULL_SUITE']
      puts "Processing via #{program_name} is slow, set FULL_SUITE to include #{test_name} in the test run" unless ENV['NO_WARN']
      skip ''
    end
  end
end

module Giffy
  module Fixtures
    def fixture_path(name)
      File.expand_path(File.join(File.dirname(__FILE__), "fixtures/#{name}"))
    end

    def video_path
      fixture_path('test_video.mov')
    end

    def images_directory_path
      fixture_path('test_video_images/')
    end

    def images_sequence
      Dir.entries(images_directory_path).reject{|e| (e =~ /\.png\z/) == nil}.map{|e| "#{images_directory_path}/#{e}"}.join(' ')
    end
  end
end
