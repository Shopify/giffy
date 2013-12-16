require 'test_helper'
require 'giffy'
require 'giffy/processors/video_extraction_processor'

module Giffy
  module Processors
    class VideoExtractionProcessorTest < Minitest::Test
      include Giffy::Fixtures

      attr_reader :dir, :processor
      attr_accessor :args
      def setup
        @dir = Dir.mktmpdir
        @args = {size: '320x240', dir: dir}
        @processor = VideoExtractionProcessor.new(args)
        @stdout = $stdout
      end

      def teardown
        FileUtils.remove_entry_secure(dir)
        $stdout = @stdout
      end

      test "it takes in a provided video path and generates the correct ffmpeg command" do
        expected_command = "ffmpeg -f image2 #{dir}/%03d.png -i #{video_path} -s #{args[:size]}"
        assert_equal expected_command, processor.command(video_path)
      end

      test "it can have additional options passed in for start location and video length to generate the ffmpeg command" do
        self.args = args.merge(start: '0:0:0.4', length: '0:0:0.5')
        processor = VideoExtractionProcessor.new(args)
        expected_command = "ffmpeg -f image2 #{dir}/%03d.png -i #{video_path} -t #{args[:length]} -s #{args[:size]} -ss #{args[:start]}"
        assert_equal expected_command, processor.command(video_path)
      end

      test "it can be queried for the directory it will be writing processed files to" do
        assert_equal dir, processor.dir
      end

      test "running the processor generates png files in the directory" do
        slow_test('ffmpeg', __method__)
        stdout = StringIO.new
        $stdout = stdout
        dir = processor.process(video_path)
        files = Dir.entries(dir).reject {|file| file =~ /\A\./}
        assert stdout.length > 0, "The mocked stdout should've been written to"
        assert_equal 31, files.length
        files.each do |file|
          assert file =~ /\.png\z/, "#{file} is not a PNG"
        end
      end
    end
  end
end
