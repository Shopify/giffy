require 'test_helper'
require 'giffy/processors/gif_generation_processor'

module Giffy
  module Processors
    class GifGenerationProcessorTest < Minitest::Test
      include Giffy::Fixtures
      attr_reader :sequence, :dir

      def setup
        @sequence = images_sequence
        @dir = Dir.mktmpdir
        @stdout = $stdout
      end

      def teardown
        FileUtils.remove_entry_secure(dir)
        $stdout = @stdout
      end

      test "it should be able to generate the correct command" do
        processor = GifGenerationProcessor.new("filename" => 'result.gif')
        expected_command = "convert -delay 1x10 #{sequence} -coalesce -layers OptimizeTransparency result.gif"
        assert_equal expected_command, processor.command(sequence)
      end

      test "when the optimized option is passed in for the command generation" do
        processor = GifGenerationProcessor.new("optimize" => true, "delay" => '1x8')
        expected_command = "convert -fuzz 1% -delay 1x8 #{sequence} -coalesce -layers OptimizeTransparency animation.gif"
        assert_equal expected_command, processor.command(sequence)
      end

      test "it should be able to create a gif" do
        slow_test('convert', __method__)
        filename = "#{dir}/example.gif"
        processor = GifGenerationProcessor.new("filename" => filename)
        processor.process(sequence)
        assert File.exist?(filename), "#{filename} does not exist after the image processing"
      end
    end
  end
end
